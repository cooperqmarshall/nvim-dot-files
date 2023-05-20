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
  use "wbthomason/packer.nvim"
  use {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' }, -- Required
      {
        -- Optional
        'williamboman/mason.nvim',
        run = function()
          pcall(vim.cmd, 'MasonUpdate')
        end,
      },
      { 'williamboman/mason-lspconfig.nvim' }, -- Optional

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },         -- Required
      { 'hrsh7th/cmp-nvim-lsp' },     -- Required
      { 'hrsh7th/cmp-buffer' },       -- Optional
      { 'hrsh7th/cmp-path' },         -- Optional
      { 'saadparwaiz1/cmp_luasnip' }, -- Optional

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
  use { "catppuccin/nvim", as = "catppuccin" }
  use 'lewis6991/gitsigns.nvim'
  use 'feline-nvim/feline.nvim'

  -- workflow
  use { 'ibhagwan/fzf-lua',
    requires = { 'kyazdani42/nvim-web-devicons' }
  }
  use 'tpope/vim-fugitive'
  use { 'ThePrimeagen/harpoon',
    requires = { 'nvim-lua/plenary.nvim' }
  }
  use { "akinsho/toggleterm.nvim",
    tag = '*',
    config = function()
      require("toggleterm").setup({
        size = function(term)
          if term.direction == "horizontal" then
            return 15
          elseif term.direction == "vertical" then
            return vim.o.columns * 0.5
          end
        end
      })
    end
  }
  use {'stevearc/oil.nvim'}

  -- Automatically set up your configuration after cloning packer.nvim
  if packer_bootstrap then
    require('packer').sync()
  end
end)
