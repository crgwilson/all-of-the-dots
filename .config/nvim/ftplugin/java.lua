local jdtls_ok, jdtls = pcall(require, "jdtls")
local jdtls_setup_ok, jdtls_setup = pcall(require, "jdtls.setup")
if not jdtls_ok or not jdtls_setup_ok then
    return
end

vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4

local lsphandler = require("crgwilson.lsp.handler")
local lspinstaller = require("crgwilson.lsp.installer")

-- The java LSP stuff has special integrations with nvim-jdtls
-- so it's easier to setup everything here than using my "normal"
-- setup flow.
lspinstaller.install_lsp_servers({
    "jdtls",
})
lspinstaller.install_debuggers({
    "javadbg",
    "javatest",
})

local home = vim.env.HOME
local jdtls_dir = lspinstaller.get_install_path("jdtls")
local lombok_jar = jdtls_dir .. "/lombok.jar"
local jdtls_plugins_dir = jdtls_dir .. "/plugins/"
local eclipse_equinox_launcher =
    vim.fn.glob(jdtls_plugins_dir .. "org.eclipse.equinox.launcher_*.jar")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local jdtls_workspace_dir = home .. "/.cache/jdtls/workspace/" .. project_name

local jdk_17_install_path = home .. "/.local/opt/microsoft-jdk-17.0.9"

local jdk_17_java_bin = jdk_17_install_path .. "/Contents/Home/bin/java"
local jdtls_config = "/config_mac"

-- TODO: Move OS detecting into a utils module
if vim.loop.os_uname().sysname == "Linux" then
    jdk_17_java_bin = jdk_17_install_path .. "/bin/java"
    jdtls_config = "/config_linux"
end

-- Discover & merge all jars into a single table to be used below
local bundles = {
    vim.fn.glob(
        lspinstaller.get_install_path("java-debug-adapter")
            .. "/extension/server/com.microsoft.java.debug.plugin-*.jar",
        1
    ),
}
vim.list_extend(
    bundles,
    vim.split(
        vim.fn.glob(
            lspinstaller.get_install_path("java-test")
                .. "/extension/server/*.jar",
            1
        ),
        "\n"
    )
)

-- This section needs to be repeated in both config and init config
-- https://github.com/mfussenegger/nvim-jdtls/discussions/249#discussioncomment-3159367
local import_options = {
    gradle = {
        wrapper = {
            enabled = true,
            checksums = {
                {
                    sha256 = "65e45cec6f57a53c6e0f03e0bd51930fd8f820732c6c6f3f6bc4ebb67382d553",
                    allowed = true,
                },
            },
        },
    },
    maven = {
        enabled = false,
    },
    exclusions = {
        "**/node_modules/**",
        "**/.metadata/**",
        "**/archtype-resources/**",
        "**/META-INF/maven/**",
        "/**/test/**",
    },
}

local config = {
    cmd = {
        jdk_17_java_bin,
        "-javaagent:" .. lombok_jar,
        "-Declipse.application=org.eclipse.jdt.ls.core.id1",
        "-Dosgi.bundles.defaultStartLevel=4",
        "-Declipse.product=org.eclipse.jdt.ls.core.product",
        "-Dlog.protocol=true",
        "-Dlog.level=ALL",
        "-noverify",
        "-Xmx4G",
        "--add-modules=ALL-SYSTEM",
        "--add-opens",
        "java.base/java.util=ALL-UNNAMED",
        "--add-opens",
        "java.base/java.lang=ALL-UNNAMED",
        "-jar",
        eclipse_equinox_launcher,
        "-configuration",
        jdtls_dir .. jdtls_config,
        "-data",
        jdtls_workspace_dir,
    },

    root_dir = jdtls_setup.find_root({
        ".git",
        ".mvnw",
        "gradlew",
    }),

    -- Here you can configure eclipse.jdt.ls specific settings
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- for a list of options
    settings = {
        java = {
            autobuild = { enabled = false },
            signatureHelp = { enabled = true },
            completion = {
                favoriteStaticMembers = {
                    "io.crate.testing.Asserts.assertThat",
                    "org.assertj.core.api.Asserions.assertThat",
                    "org.assertj.core.api.Assertions.assertThatThrownBy",
                    "org.assertj.core.api.Assertions.assertThatExceptionOfType",
                    "org.assertj.core.apo.Assertions.catchThrowable",
                    "org.junit.jupiter.api.Assertions.*",
                    "java.util.Obhects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                    "org.mockito.Mockito.*",
                },
                filteredTypes = {
                    "com.sun.*",
                    "io.micrometer.shaded.*",
                    "java.awt.*",
                    "jdk.*",
                    "sun.*",
                },
            },

            -- home = "/Library/Java/JavaVirtualMachines/jdk11.0.13.8-msft.jdk/Contents/Home",
            errors = {
                incompleteClassPath = {
                    severity = "warning",
                },
            },
            configuration = {
                -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
                -- And search for `interface RuntimeOption`
                -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
                -- runtimes = {
                --   {
                --     name = "JavaSE-1.8",
                --     path = "/Library/Java/JavaVirtualMachines/jdk1.8.0_281.jdk/Contents/Home"
                --   },
                --   {
                --     name = "JavaSE-11",
                --     path = "/Library/Java/JavaVirtualMachines/jdk11.0.13.8-msft.jdk/Contents/Home"
                --   }
                -- }
            },
            trace = {
                server = "off", -- off, messages, or verbose
            },
            imports = import_options,
            format = {
                enabled = true,
            },
        },
    },

    -- Language server `initializationOptions`
    -- You need to extend the `bundles` with paths to jar files
    -- if you want to use additional eclipse.jdt.ls plugins.
    --
    -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
    --
    -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
    init_options = {
        bundles = bundles,
        settings = {
            java = {
                imports = import_options,
            },
        },
    },
}

-- Hack to override the handler's on_attach function to do
-- special snowflake jdtls things
local default_handler = lsphandler.get_default_options()
local default_on_attach = default_handler["on_attach"]
local function on_attach_java(client, bufnr)
    default_on_attach(client, bufnr)
    jdtls.setup_dap({ hotcoderplace = "auto" })
    jdtls_setup.add_commands()

    vim.api.nvim_set_keymap(
        "n",
        "<leader>bt",
        "<cmd>lua require'jdtls'.test_class()<cr>",
        { noremap = true }
    )
    vim.api.nvim_set_keymap(
        "n",
        "<leader>bm",
        "<cmd>lua require'jdtls'.test_nearest_method()<cr>",
        { noremap = true }
    )
end

jdtls.start_or_attach(vim.tbl_deep_extend("force", {
    on_attach = on_attach_java,
    capabilities = default_handler["capabilities"],
}, config))
