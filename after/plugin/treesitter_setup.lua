local ok, ts = pcall(require, 'nvim-treesitter.configs')
if (ok) then
  ts.setup {
    ensure_installed = { "python", "lua", "vim", "query", "go" },
    sync_install = false,

    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
  }
end
