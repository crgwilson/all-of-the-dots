-- TODO:
--  - nvim DAP for debugging
local jdtls_ok, jdtls = pcall(require, "jdtls")
local jdtls_setup_ok, jdtls_setup = pcall(require, "jdtls.setup")
if not jdtls_ok or not jdtls_setup_ok then
  return
end

local lsphandler = require("crgwilson.lsp.handler")
local lspinstaller = require("crgwilson.lsp.installer")
lspinstaller.ensure_installed({
  "jdtls",
})

local home = vim.env.HOME
local jdtls_dir = home .. "/.local/share/nvim/lsp_servers/jdtls/"
local jdtls_plugins_dir = jdtls_dir .. "plugins/"
local eclipse_equinox_launcher = vim.fn.glob(jdtls_plugins_dir .. "org.eclipse.equinox.launcher_*.jar")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local jdtls_workspace_dir = home .. "/.cache/jdtls/workspace/" .. project_name

local jdk_17_install_path = home .. "/.local/opt/jdk17"

local jdk_17_install_url = "https://download.oracle.com/java/17/latest/jdk-17_macos-x64_bin.tar.gz"
local jdk_17_java_bin = jdk_17_install_path .. "/Contents/Home/bin/java"
local jdtls_config = "config_mac"

-- TODO: Move OS detecting into a utils module
if vim.loop.os_uname().sysname == "Linux" then
  jdk_17_java_bin = jdk_17_install_path .. "/bin/java"
  jdk_17_install_url = "https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.tar.gz"
  jdtls_config = "config_linux"
end

local installer = require("crgwilson.utils.installer")
if vim.fn.empty(vim.fn.glob(jdk_17_install_path)) > 0 then
  vim.notify("Could not find JDK 17, installing it")
  installer.install_from_tar(
    jdk_17_install_url,
    jdk_17_install_path
  )
end

local config = {
  cmd = {
    jdk_17_java_bin,
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-noverify",
    "-Xmx4G",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
    "-jar", eclipse_equinox_launcher,
    "-configuration", jdtls_dir .. jdtls_config,
    "-data", jdtls_workspace_dir,
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
        }
      },

      -- home = "/Library/Java/JavaVirtualMachines/jdk11.0.13.8-msft.jdk/Contents/Home",
      errors = {
        incompleteClassPath = {
          severity = "warning"
        }
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
        server = "off"  -- off, messages, or verbose
      },
      import = {
        gradle = {
          wrapper = {
            enabled = true,
            checksums = {}
          }
        },
        maven = {
          enabled = false
        },
        exclusions = {
          "**/node_modules/**",
          "**/.metadata/**",
          "**/archtype-resources/**",
          "**/META-INF/maven/**",
          "/**/test/**"
        }
      },
      format = {
        enabled = true
      }
    }
  },

  -- Language server `initializationOptions`
  -- You need to extend the `bundles` with paths to jar files
  -- if you want to use additional eclipse.jdt.ls plugins.
  --
  -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
  --
  -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
  init_options = {
    bundles = {}
  },
}

-- Hack to override the handler's on_attach function to do
-- special snowflake jdtls things
local default_handler = lsphandler.get_default_options()
local default_on_attach = default_handler["on_attach"]
local function on_attach_java(client, bufnr)
  default_on_attach(client, bufnr)
  jdtls_setup.add_commands()
end

jdtls.start_or_attach(vim.tbl_deep_extend(
  "force",
  {
    on_attach = on_attach_java,
    capabilities = default_handler["capabilities"]
  },
  config
))
jdtls_setup.add_commands()
