vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function()
  -- Packer can manage itself
  use 'wbthomason/packer.nvim'
  -- themes, and syntax
  --use 'joshdick/onedark.vim'
  use 'navarasu/onedark.nvim'
  use 'sheerun/vim-polyglot'
  --use 'numirias/semshi'
  use 'ryanoasis/vim-devicons'
  use 'bryanmylee/vim-colorscheme-icons'
  use 'itchyny/lightline.vim'
  -- LSP                           
  use 'neovim/nvim-lspconfig'      
  use 'hrsh7th/nvim-compe'      
  use 'onsails/lspkind-nvim'       
  -- Git
  use 'tpope/vim-fugitive'
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('gitsigns').setup()
    end
  }
  -- explorer
  use {
    'kyazdani42/nvim-tree.lua',
    requires = 'kyazdani42/nvim-web-devicons'
  }
  -- fuzzy, browse files
  use 'junegunn/fzf.vim'
  use 'brooth/far.vim'
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use {
    "nvim-telescope/telescope-frecency.nvim",
    config = function()
      require"telescope".load_extension("frecency")
    end,
    requires = {"tami5/sqlite.lua"}
  }
  -- See what keys do like in emacs
  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {}
    end
  }
  -- naviagation
  use {
    'AckslD/nvim-whichkey-setup.lua',
    requires = {'liuchengxu/vim-which-key'},
  }
  use 'christoomey/vim-tmux-navigator'
  use 'justinmk/vim-sneak'
  -- other
  use '907th/vim-auto-save'
  use 'farmergreg/vim-lastplace'
  use 'wellle/tmux-complete.vim'
  use "terrortylor/nvim-comment"
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
end)
