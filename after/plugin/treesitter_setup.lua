if pcall(require, 'nvim-treesitter.configs') then
  require('nvim-treesitter.configs').setup {
    ensure_installed = { "python", "lua", "vim", "vimdoc", "query", "go" },
    sync_install = false,

    highlight = {
      enable = false,
      additional_vim_regex_highlighting = false,
    },
  }
end
