return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }

  use 'Mofiqul/dracula.nvim'
  use 'folke/tokyonight.nvim'
  use { 'junegunn/fzf', run = './install --bin', }
  use { 'ibhagwan/fzf-lua',
    requires = { 'kyazdani42/nvim-web-devicons' }
  }
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  use { 'jose-elias-alvarez/null-ls.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  }
  use 'tpope/vim-fugitive'
  use 'ThePrimeagen/harpoon'
  use 'lewis6991/gitsigns.nvim'
  use 'feline-nvim/feline.nvim'
  use {"akinsho/toggleterm.nvim", tag = '*', config = function()
    require("toggleterm").setup({
      size= function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.4
      end
    end,
  })
  end}
  use { "akinsho/toggleterm.nvim", tag = '*', config = function()
    require("toggleterm").setup({
    size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.5
    end
  end}
  )
  end }
end)
