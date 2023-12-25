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
        commit = "55d9fe89e33efd26f532ef20223e5f9430c8b0c0",
    })

    -- colorschemes
    use({
        "nanotech/jellybeans.vim",
        commit = "ef83bf4dc8b3eacffc97bf5c96ab2581b415c9fa",
    })
    use({
        "morhetz/gruvbox",
        commit = "f1ecde848f0cdba877acb0c740320568252cc482",
    })
    use({
        "folke/tokyonight.nvim",
        commit = "f247ee700b569ed43f39320413a13ba9b0aef0db",
    })

    -- icons
    use({
        "nvim-tree/nvim-web-devicons",
        commit = "78d41a9930532f9bba3ea075907aa92892b9a3eb",
    })

    -- status line
    use({
        "nvim-lualine/lualine.nvim",
        commit = "2248ef254d0a1488a72041cfb45ca9caada6d994",
    })

    -- snippets
    use({
        "L3MON4D3/LuaSnip", -- my snippet engine
        commit = "57c9f5c31b3d712376c704673eac8e948c82e9c1",
    })
    use({
        "rafamadriz/friendly-snippets", -- general collection of snippets to use
        commit = "53d3df271d031c405255e99410628c26a8f0d2b0",
    })
    use({
        "crgwilson/mysnips",
    })

    -- lsp
    use({
        "hrsh7th/nvim-cmp", -- main completion engine
        commit = "538e37ba87284942c1d76ed38dd497e54e65b891",
    })
    use({
        "hrsh7th/cmp-nvim-lsp", -- completion source for the built-in nvim lsp client
        commit = "5af77f54de1b16c34b23cba810150689a3a90312",
    })
    use({
        "hrsh7th/cmp-buffer", -- completion source for words in current buffer
        commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa",
    })
    use({
        "hrsh7th/cmp-path", -- completion source for fs paths
        commit = "91ff86cd9c29299a64f968ebb45846c485725f23",
    })
    use({
        "saadparwaiz1/cmp_luasnip", -- completion source for luasnip
        commit = "05a9ab28b53f71d1aece421ef32fee2cb857a843",
    })
    use({
        "hrsh7th/cmp-nvim-lua", -- completion source for nvim lua api
        commit = "f12408bdb54c39c23e67cab726264c10db33ada8",
    })
    use({
        "neovim/nvim-lspconfig", -- collection of nvim lsp client configs for various lsp servers
        commit = "9099871a7c7e1c16122e00d70208a2cd02078d80",
    })
    use({
        "mfussenegger/nvim-jdtls", -- Java is a special snowflake and jdtls doesn't work well with lsp-installer & lspconfig
        commit = "66b5ace68a5d1c45fdfb1afa8d847e87af2aa1f8",
    })
    use({
        "nvimtools/none-ls.nvim", -- language server providing formatting & linting
        commit = "e7382de51b4cf629e56f1fa18192e716e5ba8145",
    })
    use({
        "onsails/lspkind-nvim", -- inline symbols
        commit = "d11d58c3fc3edbd8c0112b5850ef4ed553d98752",
    })
    use({
        "nvimdev/lspsaga.nvim", -- code actions, hover docstrings, and other junk too
        commit = "335805d4f591f5bb71cabb6aa4dc58ccef8e8617",
    })
    use({
        "williamboman/mason.nvim",
        commit = "41e75af1f578e55ba050c863587cffde3556ffa6",
    })
    use({
        "williamboman/mason-lspconfig.nvim",
        commit = "56e435e09f8729af2d41973e81a0db440f8fe9c9",
    })
    use({
        "jay-babu/mason-null-ls.nvim",
        commit = "d1f7258f80867f718d643d88eee66959671a4bef",
    })
    use({
        "jay-babu/mason-nvim-dap.nvim",
        commit = "9e82ded0515186edd4f69e4ce6b1a5f1b55b47e9",
    })
    use({
        "mfussenegger/nvim-dap",
        commit = "e64ebf3309154b578a03c76229ebf51c37898118",
    })
    use({
        "rcarriga/nvim-dap-ui",
        commit = "34160a7ce6072ef332f350ae1d4a6a501daf0159",
    })
    use({
        "theHamsta/nvim-dap-virtual-text",
        commit = "57f1dbd0458dd84a286b27768c142e1567f3ce3b",
    })
    use({
        "mfussenegger/nvim-dap-python",
        commit = "091e4ae00a12085f9ed4200a3cd04af7179b8a23",
    })
    use({
        "leoluz/nvim-dap-go",
        commit = "a5cc8dcad43f0732585d4793deb02a25c4afb766",
    })
    use({
        "simrat39/symbols-outline.nvim", -- nerdtree like tree of symbols (I will probably never use this)
        commit = "512791925d57a61c545bc303356e8a8f7869763c",
    })

    -- general behavior
    use({
        "godlygeek/tabular",
        commit = "339091ac4dd1f17e225fe7d57b48aff55f99b23a",
    })
    use({
        "tpope/vim-surround",
        commit = "bf3480dc9ae7bea34c78fbba4c65b4548b5b1fea",
    })
    use({
        "tpope/vim-sensible",
        commit = "226203be173bf0b95ee2a5cb6575ae604b3f9f7a",
    })
    use({
        "tpope/vim-endwise",
        commit = "79a3397f7799cb211a7fb803388b96a5f28fd778",
    })
    use({
        "lukas-reineke/indent-blankline.nvim",
        commit = "0dca9284bce128e60da18693d92999968d6cb523",
    })
    use({
        "AndrewRadev/splitjoin.vim",
        commit = "5553f71bbac9f87a3a3f78d01de24a615744a4b3",
    }) -- gS & gJ to split and join, but I don't really use this one
    use({
        "chrisbra/NrrwRgn",
        commit = "e027db9d94f94947153cd7b5ac9abd04371ab2b0",
    }) -- Don't use this one either
    use({
        "tomtom/tcomment_vim",
        commit = "90eaf759099bcd47aa0471f974109d7fd78e4eea",
    }) -- Replace this with comment.nvim?
    use({
        "psliwka/vim-smoothie",
        commit = "df1e324e9f3395c630c1c523d0555a01d2eb1b7e",
    })
    use({
        "RRethy/vim-illuminate",
        commit = "3bd2ab64b5d63b29e05691e624927e5ebbf0fb86",
    })

    -- git integration
    use({
        "tpope/vim-fugitive",
        commit = "59659093581aad2afacedc81f009ed6a4bfad275",
    })

    -- language syntax (how many of these are necessary with treesitter?)
    use({
        "vim-ruby/vim-ruby",
        commit = "f06f069ce67bdda6f2cd408f8859cdf031e5b6b4",
    })
    use({
        "tpope/vim-markdown",
        commit = "f2b82b7884a3d8bde0c5de7793b27e07030eb2bc",
    })
    use({
        "elzr/vim-json",
        commit = "3727f089410e23ae113be6222e8a08dd2613ecf2",
    })
    use({
        "pearofducks/ansible-vim",
        commit = "afc739e505053a6143a1fc6cedac6fb4d7a1d4db",
    })
    use({
        "hashivim/vim-terraform",
        commit = "d37ae7e7828aa167877e338dea5d4e1653ed3eb1",
    })
    use({
        "ap/vim-css-color",
        commit = "6cc65734bc7105d9677ca54e2255fcbc953ba6bf",
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
        commit = "50f30bcd8c62ac4a83d133d738f268279f2c2ce2",
    })

    -- fuzzy finding
    use({
        "nvim-telescope/telescope.nvim",
        commit = "f336f8cfab38a82f9f00df380d28f0c2a572f862",
    })

    -- treesitter
    use({
        "nvim-treesitter/nvim-treesitter",
        commit = "cd4de5f7b14b878ac8f5c459c9d579cc58ba1ac5",
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
