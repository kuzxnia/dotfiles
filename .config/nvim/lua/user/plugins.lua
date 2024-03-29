local fn = vim.fn

function _G.is_directory(path)
  local stat = vim.loop.fs_stat(path)
  return stat and stat.type == "directory" or false
end

function _G.join_paths(...)
  local result = table.concat({ ... }, '/')
  return result
end

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use "wbthomason/packer.nvim" -- Have packer manage itself
  use "nvim-lua/popup.nvim" -- An implementation of the Popup API from vim in Neovim
  use "nvim-lua/plenary.nvim" -- Useful lua functions used ny lots of plugins

  -- faster load time - cache
  use "lewis6991/impatient.nvim"

  -- Colorschemes
  -- use 'Mofiqul/vscode.nvim'
  use {
    'navarasu/onedark.nvim',
    config = function ()
      require('onedark').setup({
        style = 'dark'
      })
      require('onedark').load()
    end
  }
  use 'ryanoasis/vim-devicons'
  use 'bryanmylee/vim-colorscheme-icons'
  --[[ use {
    'sunjon/shade.nvim', -- messing lspinstaller up
    config = function ()
      require('shade').setup({ overlay_opacity = 50, opacity_step = 1 })
    end
  } ]]
    -- cmp plugins
  use {
    "hrsh7th/nvim-cmp", -- The completion plugin
      requires = {"L3MON4D3/LuaSnip"},
  }
  use "hrsh7th/cmp-nvim-lsp" -- The completion plugin
  use "hrsh7th/cmp-nvim-lsp-signature-help"
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions

  -- snippets
  use {
    "rafamadriz/friendly-snippets", -- a bunch of snippets to use
  }
  use {
    "L3MON4D3/LuaSnip", --snippet engine
    config = function()
      local paths = {}
      if true then
        paths[#paths + 1] = join_paths('~/.local/share/nvim/site/pack/packer/start/friendly-snippets')
      end
      require("luasnip.loaders.from_lua").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load {
        paths = paths,
      }
      require("luasnip.loaders.from_snipmate").lazy_load()
    end,
  }
  -- LSP
  use "neovim/nvim-lspconfig" -- enable LSP
  use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  use "jose-elias-alvarez/null-ls.nvim"
  use "RRethy/vim-illuminate"  -- highlights and allows moving between variable references

  use {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({})
    end,
  }
  use {
    "zbirenbaum/copilot-cmp",
    after = { "copilot.lua" },
    config = function ()
      require("copilot_cmp").setup()
    end
  }

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

  -- explorer, line
  use { 'kyazdani42/nvim-tree.lua', requires = 'kyazdani42/nvim-web-devicons' }
  use 'hoob3rt/lualine.nvim'

  -- buffers
  use "akinsho/bufferline.nvim"
  use "famiu/bufdelete.nvim"

  -- fuzzy, browse files
  use 'brooth/far.vim'
  use {'nvim-telescope/telescope.nvim'}
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' } -- might require make clean && make in ~/.local/share/nvim/site/pack/../start/telescope-fzf-native.nvim
  use { "nvim-telescope/telescope-file-browser.nvim" }
  use {'nvim-telescope/telescope-ui-select.nvim' }
  use { "folke/which-key.nvim" }

  -- refactor
  use {
    "ThePrimeagen/refactoring.nvim",
    requires = {
        {"nvim-lua/plenary.nvim"},
        {"nvim-treesitter/nvim-treesitter"}
    },
    config = function ()
      require('refactoring').setup({})
    end
  }

  -- naviagation
  use { 'AckslD/nvim-whichkey-setup.lua', requires = {'liuchengxu/vim-which-key'} }
  use 'christoomey/vim-tmux-navigator'
  use 'ggandor/lightspeed.nvim'

  -- debugging
  use 'mfussenegger/nvim-dap'
  use 'mfussenegger/nvim-dap-python'
  use 'nvim-telescope/telescope-dap.nvim'
  use 'theHamsta/nvim-dap-virtual-text'
  use 'rcarriga/nvim-dap-ui'

  -- dart & flutter
  --[[ use {
    'akinsho/flutter-tools.nvim',
    requires = 'nvim-lua/plenary.nvim',
  } ]]

  -- notes
  use 'preservim/vim-markdown'
  use {
    "epwalsh/obsidian.nvim",
    config = function ()
      require("obsidian").setup({
        dir = "~/notes/obsidian",
        completion = {
          nvim_cmp = true,
        },
        note_id_func = function(title)
          -- Create note IDs in a Zettelkasten format with a timestamp and a suffix.
          local suffix = ""
          if title ~= nil then
            -- If title is given, transform it into valid file name.
            suffix = title:gsub(" ", "_"):gsub("[^A-Za-z0-9-_]", ""):lower()
            print(suffix)
          else
            -- If title is nil, just add 4 random uppercase letters to the suffix.
            for _ = 1, 4 do
              suffix = suffix .. string.char(math.random(65, 90))
            end
          end
          return suffix
        end
      })
    end
  }

  -- other
  use "goolord/alpha-nvim"
  use '907th/vim-auto-save'
  use 'farmergreg/vim-lastplace'
  use 'wellle/tmux-complete.vim'
  use 'b3nj5m1n/kommentary'
  use 'mg979/vim-visual-multi'

  -- syntax highlight
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate', commit = 'aebc6cf6bd4675ac86629f516d612ad5288f7868' }
  use 'nvim-treesitter/nvim-treesitter-context'
  use 'nvim-treesitter/playground'

  use "windwp/nvim-autopairs"
  use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
        require("nvim-surround").setup({ })
    end
  })

--- END PLUGINS ---
  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
