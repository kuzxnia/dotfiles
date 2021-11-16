-- vim.cmd [[packadd packer.nvim]]
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
    execute 'packadd packer.nvim'
end

vim.cmd 'autocmd BufWritePost plugins.lua PackerCompile' -- Auto compile when there are changes in plugins.lua

return require('packer').startup(function(use)
    -- Packer can manage itself as an optional plugin
    use 'wbthomason/packer.nvim'

    -- Information
    use 'nanotee/nvim-lua-guide'

    -- Quality of life improvements
    use 'norcalli/nvim_utils'

    -- LSP
    use 'neovim/nvim-lspconfig'
    use 'glepnir/lspsaga.nvim'
    use 'onsails/lspkind-nvim'
    use 'kosayoda/nvim-lightbulb'
    use 'mfussenegger/nvim-jdtls'
    use 'kabouzeid/nvim-lspinstall'

    -- Debugging
    use 'mfussenegger/nvim-dap'

    -- Autocomplete
    use 'hrsh7th/nvim-compe'
    use 'mattn/emmet-vim'
    use 'hrsh7th/vim-vsnip'
    use 'xabikos/vscode-javascript'
    use 'dsznajder/vscode-es7-javascript-react-snippets'
    use 'golang/vscode-go'
    use 'rust-lang/vscode-rust'
    use 'ChristianChiarulli/html-snippets'
    use 'ChristianChiarulli/java-snippets'
    use 'ChristianChiarulli/python-snippets'

    -- Treesitter
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use 'nvim-treesitter/nvim-treesitter-refactor'
    use 'nvim-treesitter/playground'

    -- Icons
    use 'kyazdani42/nvim-web-devicons'
    use 'ryanoasis/vim-devicons'

    -- Status Line and Bufferline
    use 'glepnir/galaxyline.nvim'
    use 'romgrk/barbar.nvim'

    -- Find, Filter, Preview, Pick. All lua, all the time.
    use {
      "~/repos/telescope.nvim",
      opt = false,
      requires = {
        -- An implementation of the Popup API from vim in Neovim.
        { "nvim-lua/popup.nvim" },

        -- plenary: full; complete; entire; absolute; unqualified.
        { "~/repos/plenary.nvim" },

        -- FZY style sorter that is compiled
        { "nvim-telescope/telescope-fzy-native.nvim" },

        -- Preview media files in Telescope
        { "nvim-telescope/telescope-media-files.nvim" },

        -- A telescope.nvim extension that offers intelligent prioritization
        -- when selecting files from your editing history.
        { "nvim-telescope/telescope-frecency.nvim" },
      },
    }

    -- Explorer
    use 'kyazdani42/nvim-tree.lua'

    -- Color
    use 'joshdick/onedark.vim'
    use 'NieTiger/halcyon-neovim'
    use 'rakr/vim-one'
    use 'ayu-theme/ayu-vim'
    use 'norcalli/nvim-colorizer.lua'
    use 'sheerun/vim-polyglot'

    -- Git
    use 'TimUntersberger/neogit'
    use {'lewis6991/gitsigns.nvim', requires = {'nvim-lua/plenary.nvim'}}
    use 'f-person/git-blame.nvim'
    -- use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb'

    -- Easily Create Gists
    use 'mattn/vim-gist'
    use 'mattn/webapi-vim'

    -- Webdev
    use 'windwp/nvim-ts-autotag'
    use 'gennaro-tedesco/nvim-jqx'
    use 'turbio/bracey.vim'

    -- Registers
    use 'gennaro-tedesco/nvim-peekup'

    -- Navigation
    use 'unblevable/quick-scope'
    use 'phaazon/hop.nvim'
    use 'kevinhwang91/rnvimr'

    -- General Plugins
    use 'liuchengxu/vim-which-key'


    use '907th/vim-auto-save'
    use 'terrortylor/nvim-comment'

    use 'kevinhwang91/nvim-bqf'
    use 'airblade/vim-rooter'
    use 'metakirby5/codi.vim'
    use 'moll/vim-bbye'
    use {'iamcco/markdown-preview.nvim', run = 'cd app && npm install'}
    use 'voldikss/vim-floaterm'
    use 'liuchengxu/vista.vim'
    use 'bfredl/nvim-miniyank'
    use 'monaqa/dial.nvim'
    use 'junegunn/goyo.vim'
    use 'andymass/vim-matchup'
    use 'windwp/nvim-autopairs'
    use 'blackcauldron7/surround.nvim'

    -- TODO put this back when stable for indent lines
    	use { 'lukas-reineke/indent-blankline.nvim', branch = 'lua'}
    	-- vim.g.indent_blankline_space_char = ''
    -- use 'b3nj5m1n/kommentary'
    -- use {
    --     'glacambre/firenvim',
    --     run = function()
    --         vim.fn['firenvim#install'](1)
    --     end
    -- }
    -- use 'mhinz/vim-startify'
    -- use 'cstrap/python-snippets'
    -- use 'ylcnfrht/vscode-python-snippet-pack'
    -- use 'SirVer/ultisnips'
    -- use 'norcalli/snippets.nvim'
    -- use {'akinsho/nvim-bufferline.lua', requires = 'kyazdani42/nvim-web-devicons'}
end)
