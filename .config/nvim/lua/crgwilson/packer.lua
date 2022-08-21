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
    commit = "d268d2e083ca0abd95a57dfbcc5d5637a615e219"
  })

  -- colorschemes
  use({
    "nanotech/jellybeans.vim",
    commit = "ef83bf4dc8b3eacffc97bf5c96ab2581b415c9fa"
  })
  use({
    "morhetz/gruvbox",
    commit = "bf2885a95efdad7bd5e4794dd0213917770d79b7"
  })
  use({
    "folke/tokyonight.nvim",
    commit = "8223c970677e4d88c9b6b6d81bda23daf11062bb"
  })

  -- icons
  use({
    "kyazdani42/nvim-web-devicons",
    commit="8d2c5337f0a2d0a17de8e751876eeb192b32310e"
  })

  -- status line
  use({
    "nvim-lualine/lualine.nvim",
    commit="c15e3b4c9eb7015dd58688b3d9bb1d659a49d3d1"
  })

  -- snippets
  use({
    "L3MON4D3/LuaSnip",  -- my snippet engine
    commit="295cc9e422060b3200234b42cbee6dde1dfee765"
  })
  use({
    "rafamadriz/friendly-snippets",  -- general collection of snippets to use
    commit="2ef6e939450102ac21de6cfe6c643891cda3d693"
  })
  use({
    "crgwilson/mysnips",
    commit = "c982b9b56dde600045be0f0825430d2994b02f9c"
  })

  -- lsp
  use({
    "hrsh7th/nvim-cmp",  -- main completion engine
    commit="9897465a7663997b7b42372164ffc3635321a2fe"
  })
  use({
    "hrsh7th/cmp-nvim-lsp",  -- completion source for the built-in nvim lsp client
    commit="affe808a5c56b71630f17aa7c38e15c59fd648a8"
  })
  use({
    "hrsh7th/cmp-buffer",  -- completion source for words in current buffer
    commit="62fc67a2b0205136bc3e312664624ba2ab4a9323"
  })
  use({
    "hrsh7th/cmp-path",  -- completion source for fs paths
    commit="981baf9525257ac3269e1b6701e376d6fbff6921"
  })
  use({
    "saadparwaiz1/cmp_luasnip",  -- completion source for luasnip
    commit="a9de941bcbda508d0a45d28ae366bb3f08db2e36"
  })
  use({
    "hrsh7th/cmp-nvim-lua",  -- completion source for nvim lua api
    commit="d276254e7198ab7d00f117e88e223b4bd8c02d21"
  })
  use({
    "neovim/nvim-lspconfig",  -- collection of nvim lsp client configs for various lsp servers
    commit="b9c375c385765ea42418f7994354bdecc1036765"
  })
  use({
    "williamboman/nvim-lsp-installer",  -- coc-esque lsp installer
    commit="d2c5d9cef4bf310ed3e14e2a8a0dd0f0fec13ac8"
  })
  use({
    "jose-elias-alvarez/null-ls.nvim",  -- language server providing formatting & linting
    commit="a2b7bf89663c78d58a5494efbb791819a24bb025"
  })
  use({
    "onsails/lspkind-nvim",  -- inline symbols
    commit="57e5b5dfbe991151b07d272a06e365a77cc3d0e7"
  })
  use({
    "glepnir/lspsaga.nvim",  -- code actions, hover docstrings, and other junk too
    commit="6d430d4f257a7628ab906bafd6b6661344d49f36"
  })
  use({
    "simrat39/symbols-outline.nvim",  -- nerdtree like tree of symbols (I will probably never use this)
    commit="15ae99c27360ab42e931be127d130611375307d5"
  })

  -- general behavior
  use({
    "godlygeek/tabular",
    commit = "339091ac4dd1f17e225fe7d57b48aff55f99b23a"
  })
  use({
    "tpope/vim-surround",
    commit = "bf3480dc9ae7bea34c78fbba4c65b4548b5b1fea"
  })
  use({
    "tpope/vim-sensible",
    commit = "226203be173bf0b95ee2a5cb6575ae604b3f9f7a"
  })
  use({
    "tpope/vim-endwise",
    commit = "79a3397f7799cb211a7fb803388b96a5f28fd778"
  })
  use({
    "nathanaelkane/vim-indent-guides",
    commit = "765084d38bf102a95ab966fb06472e83fa7deff7"
  })  -- I don't know if I like this (:IndentGuideToggle)
  use({
    "ntpeters/vim-better-whitespace",
    commit = "1b22dc57a2751c7afbc6025a7da39b7c22db635d"
  })
  use({
    "AndrewRadev/splitjoin.vim",
    commit = "5553f71bbac9f87a3a3f78d01de24a615744a4b3"
  })  -- gS & gJ to split and join, but I don't really use this one
  use({
    "chrisbra/NrrwRgn",
    commit = "e027db9d94f94947153cd7b5ac9abd04371ab2b0"
  })  -- Don't use this one either
  use({
    "tomtom/tcomment_vim",
    commit = "7fb091aad8d824bef1d7bc9365921c65e26d82ad"
  })  -- Replace this with comment.nvim?
  use({
    "psliwka/vim-smoothie",
    commit = "df1e324e9f3395c630c1c523d0555a01d2eb1b7e"
  })
  use({
    "RRethy/vim-illuminate",
    commit = "c82e6d04f27a41d7fdcad9be0bce5bb59fcb78e5"
  })

  -- git integration
  use({
    "tpope/vim-fugitive",
    commit = "f809dde0e719f89a6fb5cb80f3be65f5cbc1d1fe"
  })
  -- I don't use this and probably don't need it
  -- use({ "junegunn/gv.vim" })

  -- language syntax (how many of these are necessary with treesitter?)
  use({
    "vim-ruby/vim-ruby",
    commit = "a99282403445ac1d008b51d6edd820d5dc053ecb"
  })
  use({
    "fatih/vim-go",
    commit = "b7506c6da8ea3a88e268a91aa6630be3e26a20a9"
  })
  use({
    "tpope/vim-markdown",
    commit = "b78bbce3371a2eb56c89f618cd4ab2baadc9ee61"
  })
  use({
    "elzr/vim-json",
    commit = "3727f089410e23ae113be6222e8a08dd2613ecf2"
  })
  use({
    "pearofducks/ansible-vim",
    commit = "93798e8c89c441d29d4678da0c0d5e1429eb43b0"
  })
  use({
    "hashivim/vim-terraform",
    commit = "f0b17ac9f1bbdf3a29dba8b17ab429b1eed5d443"
  })
  use({
    "ap/vim-css-color",
    commit = "8bf943681f92c81a8cca19762a1ccec8bc29098a"
  })
  use({
    "ekalinin/Dockerfile.vim",
    commit = "2a31e6bcea5977209c05c728c4253d82fd873c82"
  })
  use({
    "kergoth/vim-bitbake",
    commit = "0a229746e4a8e9c5b3b4666e9452dec2cbe69c9b"
  })
  use({
    "joukevandermaas/vim-ember-hbs",
    commit = "c47e1958a6c190c9d79ac66cb812f1a1d3b4e968"
  })

  -- nerdtree
  use({
    "kyazdani42/nvim-tree.lua",
    commit="f43b8af8f40004e476cc43d178b82350b3249d1a"
  })

  -- fuzzy finding
  use({
    "nvim-telescope/telescope.nvim",
    commit = "f8047b8bc9e2fdc06cc3b5d3d7701f1299f3b6e4",
    requires = { {"nvim-lua/plenary.nvim"} }
  })

  -- treesitter
  use({
    "nvim-treesitter/nvim-treesitter",
    commit = "f75e27c2170ef4cc83cc9fa10a82c84ec82f5021",
    run = ":TSUpdate"
  })

  -- cheat.sh
  use({
    "crgwilson/cheat.nvim",
    commit = "163f83c91a082992d3bf21f7bf9f436e7b8126a4"
  })

  -- startup profiling
  use({
    "tweekmonster/startuptime.vim",
    commit = "dfa57f522d6f61793fe5fea65bca7484751b8ca2"
  })

  -- Install all plugins if packer was just installed
  if packer_was_installed then
    require("packer").sync()
  end
end)
