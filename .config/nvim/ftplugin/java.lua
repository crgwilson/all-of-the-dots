-- TODO:
--  - Auto install JDK 17
--  - nvim DAP for debugging
local jdtls_ok, jdtls = pcall(require, "jdtls")
local jdtls_setup_ok, jdtls_setup = pcall(require, "jdtls.setup")
if not jdtls_ok or not jdtls_setup_ok then
  return
end

local lsphander = require("crgwilson.lsp.handler")
local lspinstaller = require("crgwilson.lsp.installer")
lspinstaller.ensure_installed({
  "jdtls",
})

local home = vim.env.HOME
local java_bin = "/opt/jdk17/bin/java"
local jdtls_dir = home .. "/.local/share/nvim/lsp_servers/jdtls/"
local jdtls_plugins_dir = jdtls_dir .. "plugins/"
local eclipse_equinox_launcher = vim.fn.glob(jdtls_plugins_dir .. "org.eclipse.equinox.launcher_*.jar")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local jdtls_workspace_dir = home .. "/.cache/jdtls/workspace/" .. project_name

-- TODO: Move OS detecting into a utils module
local jdtls_config = "config_mac"
if vim.loop.os_uname().sysname == "Linux" then
  jdtls_config = "config_linux"
end

local config = {
  cmd = {
    java_bin,
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.level=ALL",
    "-noverify",
    "-Xmx1G",
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
      -- configuration {
			-- 	-- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
      --   -- And search for `interface RuntimeOption`
      --   -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
      --   runtimes = {
      --     {
      --       name = "JavaSE-11",
      --       path = "/usr/lib/jvm/java-11-openjdk/",
      --     },
      --     {
      --       name = "JavaSE-17",
      --       path = "/usr/lib/jvm/java-17-openjdk/",
      --     },
			-- 	}
      -- }
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

jdtls.start_or_attach(vim.tbl_deep_extend(
  "force",
  lsphander.get_default_options(),
  config
))
