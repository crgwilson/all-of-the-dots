local fn = vim.fn
local installer = require("crgwilson.utils.installer")

-- Installing packer.nvim if it is not already present
local packer_was_installed = false
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  installer.install_from_git("https://github.com/wbthomason/packer.nvim", install_path)
  packer_was_installed = true

  vim.cmd([[packadd packer.nvim]])
end

-- Reload nvim whenever plugins.lua is save
-- TODO: Might need to do this in a smarter way in the future
local packer_augroup = vim.api.nvim_create_augroup("packer_user_config", { clear = true })
vim.api.nvim_create_autocmd(
  "BufWritePost", {
    pattern = "packer.lua",
    command = "source <afile> | PackerSync",
    group = packer_augroup
  }
)

-- Make sure packer actually works
local ok, packer = pcall(require, "packer")
if not ok then
  vim.notify("Packer unable to be loaded, plugins will be broken", 2)
  return
end

-- configure packer here
packer.init({
  max_jobs = 5  -- cap the max number of jobs allowed to run for PackerSync
})

return require("packer").startup(function(use)
  -- plugin manager (after first time bootstrap)
  use({
    "wbthomason/packer.nvim",
    commit="ed2d5c9c17f4df2eeaca4878145fecc9669e0138"
  })

  -- colorschemes
  use({
    "nanotech/jellybeans.vim",
    commit="ef83bf4dc8b3eacffc97bf5c96ab2581b415c9fa"
  })
  use({
    "morhetz/gruvbox",
    commit="bf2885a95efdad7bd5e4794dd0213917770d79b7"
  })
  use({
    "folke/tokyonight.nvim",
    commit="df13e3268a44f142999fa166572fe95a650a0b37"
  })

  -- icons
  use({
    "nvim-tree/nvim-web-devicons",
    commit="986875b7364095d6535e28bd4aac3a9357e91bbe"
  })

  -- status line
  use({
    "nvim-lualine/lualine.nvim",
    commit="84ffb80e452d95e2c46fa29a98ea11a240f7843e"
  })

  -- snippets
  use({
    "L3MON4D3/LuaSnip",  -- my snippet engine
    commit="b4bc24c4925aeb05fd47d2ee9b24b7f73f5d7e32"
  })
  use({
    "rafamadriz/friendly-snippets",  -- general collection of snippets to use
    commit="10f741908e56ce47cf6b3440e3f04b4fdc0da2f2"
  })
  use({
    "crgwilson/mysnips",
    commit="c982b9b56dde600045be0f0825430d2994b02f9c"
  })

  -- lsp
  use({
    "hrsh7th/nvim-cmp",  -- main completion engine
    commit="935b4069ce73b60ba9075bf05ee6ab50ed3af1a9"
  })
  use({
    "hrsh7th/cmp-nvim-lsp",  -- completion source for the built-in nvim lsp client
    commit="0e6b2ed705ddcff9738ec4ea838141654f12eeef"
  })
  use({
    "hrsh7th/cmp-buffer",  -- completion source for words in current buffer
    commit="3022dbc9166796b644a841a02de8dd1cc1d311fa"
  })
  use({
    "hrsh7th/cmp-path",  -- completion source for fs paths
    commit="91ff86cd9c29299a64f968ebb45846c485725f23"
  })
  use({
    "saadparwaiz1/cmp_luasnip",  -- completion source for luasnip
    commit="18095520391186d634a0045dacaa346291096566"
  })
  use({
    "hrsh7th/cmp-nvim-lua",  -- completion source for nvim lua api
    commit="f12408bdb54c39c23e67cab726264c10db33ada8"
  })
  use({
    "neovim/nvim-lspconfig",  -- collection of nvim lsp client configs for various lsp servers
    commit="8356319af6e8012a5797b647e946b377d1ba3d9c"
  })
  use({
    "mfussenegger/nvim-jdtls",  -- Java is a special snowflake and jdtls doesn't work well with lsp-installer & lspconfig
    commit="355de7458fd63ccef9c6485d952ea118ba2cb46a"
  })
  use({
    "jose-elias-alvarez/null-ls.nvim",  -- language server providing formatting & linting
    commit="71797bb303ac99a4435592e15068f127970513d7"
  })
  use({
    "onsails/lspkind-nvim",  -- inline symbols
    commit="57610d5ab560c073c465d6faf0c19f200cb67e6e"
  })
  use({
    "nvimdev/lspsaga.nvim",  -- code actions, hover docstrings, and other junk too
    commit="76696bed4397c3b58563c246dc1f7856ed4af023"
  })
  use({
    "williamboman/mason.nvim",
    commit="a51391311e86c295fc7611be2beb58859e93f21b"
  })
  use({
    "williamboman/mason-lspconfig.nvim",
    commit="90a8bbf106b85b76951a34c542058ffa807de2b1"
  })
  use({
    "jay-babu/mason-nvim-dap.nvim",
    commit="c836e511e796d2b6a25ad9f164f5b25d8b9ff705"
  })
  use({
    "mfussenegger/nvim-dap",
    commit="6cedcb527e264c8f25e86afa8dae74c6692dee51"
  })
  use({
    "rcarriga/nvim-dap-ui",
    commit="4ce7b97dd8f50b4f672948a34bf8f3a56214fdb8"
  })
  use({
    "theHamsta/nvim-dap-virtual-text",
    commit="ab988dbb7d20cdaebf9b3ef7554a89f6895de042"
  })
  use({
    "mfussenegger/nvim-dap-python",
    commit="51ecb08dbff57fca8add396b93dc765aba262e0a"
  })
  use({
    "simrat39/symbols-outline.nvim",  -- nerdtree like tree of symbols (I will probably never use this)
    commit="512791925d57a61c545bc303356e8a8f7869763c"
  })

  -- general behavior
  use({
    "godlygeek/tabular",
    commit="339091ac4dd1f17e225fe7d57b48aff55f99b23a"
  })
  use({
    "tpope/vim-surround",
    commit="bf3480dc9ae7bea34c78fbba4c65b4548b5b1fea"
  })
  use({
    "tpope/vim-sensible",
    commit="226203be173bf0b95ee2a5cb6575ae604b3f9f7a"
  })
  use({
    "tpope/vim-endwise",
    commit="79a3397f7799cb211a7fb803388b96a5f28fd778"
  })
  use({
    "lukas-reineke/indent-blankline.nvim",
    commit="8299fe7703dfff4b1752aeed271c3b95281a952d"
  })
  use({
    "ntpeters/vim-better-whitespace",
    commit="1b22dc57a2751c7afbc6025a7da39b7c22db635d"
  })
  use({
    "AndrewRadev/splitjoin.vim",
    commit="5553f71bbac9f87a3a3f78d01de24a615744a4b3"
  })  -- gS & gJ to split and join, but I don't really use this one
  use({
    "chrisbra/NrrwRgn",
    commit="e027db9d94f94947153cd7b5ac9abd04371ab2b0"
  })  -- Don't use this one either
  use({
    "tomtom/tcomment_vim",
    commit="7fb091aad8d824bef1d7bc9365921c65e26d82ad"
  })  -- Replace this with comment.nvim?
  use({
    "psliwka/vim-smoothie",
    commit="df1e324e9f3395c630c1c523d0555a01d2eb1b7e"
  })
  use({
    "RRethy/vim-illuminate",
    commit="c82e6d04f27a41d7fdcad9be0bce5bb59fcb78e5"
  })

  -- git integration
  use({
    "tpope/vim-fugitive",
    commit="f809dde0e719f89a6fb5cb80f3be65f5cbc1d1fe"
  })

  -- language syntax (how many of these are necessary with treesitter?)
  use({
    "vim-ruby/vim-ruby",
    commit="a99282403445ac1d008b51d6edd820d5dc053ecb"
  })
  use({
    "fatih/vim-go",
    commit="b7506c6da8ea3a88e268a91aa6630be3e26a20a9"
  })
  use({
    "tpope/vim-markdown",
    commit="b78bbce3371a2eb56c89f618cd4ab2baadc9ee61"
  })
  use({
    "elzr/vim-json",
    commit="3727f089410e23ae113be6222e8a08dd2613ecf2"
  })
  use({
    "pearofducks/ansible-vim",
    commit="93798e8c89c441d29d4678da0c0d5e1429eb43b0"
  })
  use({
    "hashivim/vim-terraform",
    commit="f0b17ac9f1bbdf3a29dba8b17ab429b1eed5d443"
  })
  use({
    "ap/vim-css-color",
    commit="8bf943681f92c81a8cca19762a1ccec8bc29098a"
  })
  use({
    "ekalinin/Dockerfile.vim",
    commit="2a31e6bcea5977209c05c728c4253d82fd873c82"
  })
  use({
    "kergoth/vim-bitbake",
    commit="0a229746e4a8e9c5b3b4666e9452dec2cbe69c9b"
  })
  use({
    "joukevandermaas/vim-ember-hbs",
    commit="c47e1958a6c190c9d79ac66cb812f1a1d3b4e968"
  })

  -- nerdtree
  use({
    "nvim-tree/nvim-tree.lua",
    commit="270c95556cad96d18ca547d86ae65927334b108b"
  })

  -- fuzzy finding
  use({
    "nvim-telescope/telescope.nvim",
    commit="d77b37f4520e5fc2cf4c74c12e42ed4b589bd367",
    requires={ {"nvim-lua/plenary.nvim"} }
  })

  -- treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    commit="6e8ad92031ff3b07db8980ab4a5491d1c40398ea",
    run=":TSUpdate"
  })

  -- cheat.sh
  use({
    "crgwilson/cheat.nvim",
    commit="163f83c91a082992d3bf21f7bf9f436e7b8126a4"
  })

  -- startup profiling
  use({
    "tweekmonster/startuptime.vim",
    commit="dfa57f522d6f61793fe5fea65bca7484751b8ca2"
  })

  -- Install all plugins if packer was just installed
  if packer_was_installed then
    require("packer").sync()
  end
end)
