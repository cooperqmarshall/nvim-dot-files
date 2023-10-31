local ok, indent = pcall(require, 'ibl')
if (ok) then
  indent.setup {
    indent = {char = "▏"},
    scope = {show_start = false, show_end = false }
  }
end
