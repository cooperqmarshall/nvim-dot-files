local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' }, -- Required
      {
        'williamboman/mason.nvim', -- Optional
        run = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional
      { 'jose-elias-alvarez/null-ls.nvim' },
      { 'jay-babu/mason-null-ls.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },         -- Required
      { 'hrsh7th/cmp-nvim-lsp' },     -- Required
      { 'hrsh7th/cmp-buffer' },       -- Optional
      { 'hrsh7th/cmp-path' },         -- Optional
      { 'saadparwaiz1/cmp_luasnip' }, -- Optional
      { 'f3fora/cmp-spell' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },             -- Required
      { 'rafamadriz/friendly-snippets' }, -- Optional
    }
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
  }

  -- themes/aesthetics
  use 'folke/tokyonight.nvim'
  use 'Mofiqul/dracula.nvim'
  use { 'catppuccin/nvim', as = 'catppuccin' }
  use 'AlexvZyl/nordic.nvim'
  use 'lewis6991/gitsigns.nvim'
  use 'feline-nvim/feline.nvim'
  use 'lukas-reineke/indent-blankline.nvim'

  -- workflow
  use 'kyazdani42/nvim-web-devicons'
  use 'ibhagwan/fzf-lua'
  use 'tpope/vim-fugitive'
  use { 'ThePrimeagen/harpoon',
    requires = { 'nvim-lua/plenary.nvim' }
  }
  use 'numToStr/Comment.nvim'
  use 'dstein64/vim-startuptime'
  use 'stevearc/oil.nvim'
  use 'akinsho/toggleterm.nvim'

  -- Automatically set up your configuration after cloning packer.nvim
  if packer_bootstrap then
    require('packer').sync()
  end
end)
