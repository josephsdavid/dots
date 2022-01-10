local colorscheme = "rigel"
vim.g.kanagawabones = { solid_line_nr = true, darken_comments = 45, darkness="stark" }
-- local colorscheme = "kanagawabones"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify("colorscheme " .. colorscheme .. " not found!")
  return
end
