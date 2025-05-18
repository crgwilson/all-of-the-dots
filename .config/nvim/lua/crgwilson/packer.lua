local fn = vim.fn
local installer = require("crgwilson.utils.installer")

-- Installing packer.nvim if it is not already present
local packer_was_installed = false
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
    installer.install_from_git(
        "https://github.com/wbthomason/packer.nvim",
        install_path
    )
    packer_was_installed = true

    vim.cmd([[packadd packer.nvim]])
end

-- Reload nvim whenever plugins.lua is save
-- TODO: Might need to do this in a smarter way in the future
local packer_augroup =
    vim.api.nvim_create_augroup("packer_user_config", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = "packer.lua",
    command = "source <afile> | PackerSync",
    group = packer_augroup,
})

-- Make sure packer actually works
local ok, packer = pcall(require, "packer")
if not ok then
    vim.notify("Packer unable to be loaded, plugins will be broken", 2)
    return
end

-- configure packer here
packer.init({
    max_jobs = 5, -- cap the max number of jobs allowed to run for PackerSync
})

return require("packer").startup(function(use)
    -- plugin manager (after first time bootstrap)
    use({
        "wbthomason/packer.nvim",
        commit = "ea0cc3c59f67c440c5ff0bbe4fb9420f4350b9a3",
    })

    -- Several plugins require plenary as a dependency
    use({
        "nvim-lua/plenary.nvim",
        commit = "857c5ac632080dba10aae49dba902ce3abf91b35",
    })

    -- colorschemes
    use({
        "folke/tokyonight.nvim",
        commit = "f247ee700b569ed43f39320413a13ba9b0aef0db",
    })

    -- icons
    use({
        "nvim-tree/nvim-web-devicons",
        commit = "2c2b4eafce6cdd0cb165036faa17396eff18f847",
    })

    -- status line
    use({
        "nvim-lualine/lualine.nvim",
        commit = "15884cee63a8c205334ab13ab1c891cd4d27101a",
    })

    -- snippets
    use({
        "L3MON4D3/LuaSnip", -- my snippet engine
        commit = "7d08b780201a4a7c9c117a3855492fdd6318380f",
    })
    use({
        "rafamadriz/friendly-snippets", -- general collection of snippets to use
        commit = "572f5660cf05f8cd8834e096d7b4c921ba18e175",
    })
    use({
        "crgwilson/mysnips",
        commit = "f834f6348cd43b4e7292b5b980e35ad91a80fd24",
    })

    -- lsp
    use({
        "hrsh7th/nvim-cmp", -- main completion engine
        commit = "b5311ab3ed9c846b585c0c15b7559be131ec4be9",
    })
    use({
        "hrsh7th/cmp-nvim-lsp", -- completion source for the built-in nvim lsp client
        commit = "a8912b88ce488f411177fc8aed358b04dc246d7b",
    })
    use({
        "hrsh7th/cmp-buffer", -- completion source for words in current buffer
        commit = "b74fab3656eea9de20a9b8116afa3cfc4ec09657",
    })
    use({
        "hrsh7th/cmp-path", -- completion source for fs paths
        commit = "c6635aae33a50d6010bf1aa756ac2398a2d54c32",
    })
    use({
        "saadparwaiz1/cmp_luasnip", -- completion source for luasnip
        commit = "98d9cb5c2c38532bd9bdb481067b20fea8f32e90",
    })
    use({
        "hrsh7th/cmp-nvim-lua", -- completion source for nvim lua api
        commit = "f12408bdb54c39c23e67cab726264c10db33ada8",
    })
    use({
        "neovim/nvim-lspconfig", -- collection of nvim lsp client configs for various lsp servers
        commit = "1b801f68d09e70e59e6dd967b663b6d84ee3e87d",
    })
    use({
        "mfussenegger/nvim-jdtls", -- Java is a special snowflake and jdtls doesn't work well with lsp-installer & lspconfig
        commit = "c23f200fee469a415c77265ca55b496feb646992",
    })
    use({
        "nvimtools/none-ls.nvim", -- language server providing formatting & linting
        commit = "7c493a266a6b1ed419f8a2e431651bc15b10df27",
    })
    use({
        "onsails/lspkind-nvim", -- inline symbols
        commit = "d79a1c3299ad0ef94e255d045bed9fa26025dab6",
    })
    use({
        "nvimdev/lspsaga.nvim", -- code actions, hover docstrings, and other junk too
        commit = "920b1253e1a26732e53fac78412f6da7f674671d",
    })
    use({
        "williamboman/mason.nvim",
        commit = "fc98833b6da5de5a9c5b1446ac541577059555be",
    })
    use({
        "williamboman/mason-lspconfig.nvim",
        commit = "1a31f824b9cd5bc6f342fc29e9a53b60d74af245",
    })
    use({
        "jay-babu/mason-null-ls.nvim",
        commit = "de19726de7260c68d94691afb057fa73d3cc53e7",
    })
    use({
        "jay-babu/mason-nvim-dap.nvim",
        commit = "4c2cdc69d69fe00c15ae8648f7e954d99e5de3ea",
    })
    use({
        "mfussenegger/nvim-dap",
        commit = "8df427aeba0a06c6577dc3ab82de3076964e3b8d",
    })
    use({
        "nvim-neotest/nvim-nio",
        commit = "21f5324bfac14e22ba26553caf69ec76ae8a7662",
    })
    use({
        "rcarriga/nvim-dap-ui",
        commit = "73a26abf4941aa27da59820fd6b028ebcdbcf932",
    })
    use({
        "theHamsta/nvim-dap-virtual-text",
        commit = "df66808cd78b5a97576bbaeee95ed5ca385a9750",
    })
    use({
        "mfussenegger/nvim-dap-python",
        commit = "34282820bb713b9a5fdb120ae8dd85c2b3f49b51",
    })
    use({
        "leoluz/nvim-dap-go",
        commit = "8763ced35b19c8dc526e04a70ab07c34e11ad064",
    })
    use({
        "simrat39/symbols-outline.nvim", -- nerdtree like tree of symbols (I will probably never use this)
        commit = "512791925d57a61c545bc303356e8a8f7869763c",
    })

    -- general behavior
    use({
        "godlygeek/tabular",
        commit = "12437cd1b53488e24936ec4b091c9324cafee311",
    })
    use({
        "tpope/vim-surround",
        commit = "3d188ed2113431cf8dac77be61b842acb64433d9",
    })
    use({
        "tpope/vim-sensible",
        commit = "0ce2d843d6f588bb0c8c7eec6449171615dc56d9",
    })
    use({
        "tpope/vim-endwise",
        commit = "eab530110d7a0d985902a3964894816b50dbf31a",
    })
    use({
        "lukas-reineke/indent-blankline.nvim",
        commit = "005b56001b2cb30bfa61b7986bc50657816ba4ba",
    })
    use({
        "AndrewRadev/splitjoin.vim",
        commit = "6af1cdcae4b46a90dbcd59ce0ca3543f34c7732c",
    }) -- gS & gJ to split and join, but I don't really use this one
    -- use({
    --     "tomtom/tcomment_vim",
    --     commit = "90eaf759099bcd47aa0471f974109d7fd78e4eea",
    -- }) -- Replace this with comment.nvim?
    use({
        "RRethy/vim-illuminate",
        commit = "fbc16dee336d8cc0d3d2382ea4a53f4a29725abf",
    })

    -- git integration
    use({
        "tpope/vim-fugitive",
        commit = "4a745ea72fa93bb15dd077109afbb3d1809383f2",
    })

    -- language syntax (how many of these are necessary with treesitter?)
    use({
        "vim-ruby/vim-ruby",
        commit = "bf3a5994ce63796db7b1b04aea92772271f387aa",
    })
    use({
        "tpope/vim-markdown",
        commit = "f9f845f28f4da33a7655accb22f4ad21f7d9fb66",
    })
    use({
        "elzr/vim-json",
        commit = "3727f089410e23ae113be6222e8a08dd2613ecf2",
    })
    use({
        "pearofducks/ansible-vim",
        commit = "3329367d2e5f90d203c8d340c53fa83c60a1ad41",
    })
    use({
        "hashivim/vim-terraform",
        commit = "8912ca1be3025a1c9fab193618f3b99517e01973",
    })
    use({
        "ekalinin/Dockerfile.vim",
        commit = "2a31e6bcea5977209c05c728c4253d82fd873c82",
    })
    use({
        "kergoth/vim-bitbake",
        commit = "0a229746e4a8e9c5b3b4666e9452dec2cbe69c9b",
    })
    use({
        "joukevandermaas/vim-ember-hbs",
        commit = "777095c1b25f334cef9db5504c7d409d52843aa9",
    })
    use({
        "rodjek/vim-puppet",
        commit = "81943d532dee24f8518f855dfb17160809abfdfb",
    })

    -- nerdtree
    use({
        "nvim-tree/nvim-tree.lua",
        commit = "582ae48c9e43d2bcd55dfcc8e2e7a1f29065d924",
    })

    -- fuzzy finding
    use({
        "nvim-telescope/telescope.nvim",
        commit = "a4ed82509cecc56df1c7138920a1aeaf246c0ac5",
    })

    -- treesitter
    use({
        "nvim-treesitter/nvim-treesitter",
        commit = "94ea4f436d2b59c80f02e293466c374584f03b8c",
        run = ":TSUpdate",
    })

    -- cheat.sh
    use({
        "crgwilson/cheat.nvim",
        commit = "163f83c91a082992d3bf21f7bf9f436e7b8126a4",
    })

    -- startup profiling
    use({
        "tweekmonster/startuptime.vim",
        commit = "dfa57f522d6f61793fe5fea65bca7484751b8ca2",
    })

    -- Install all plugins if packer was just installed
    if packer_was_installed then
        require("packer").sync()
    end
end)
