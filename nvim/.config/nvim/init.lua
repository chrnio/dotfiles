-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

if vim.g.neovide then
  vim.g.neovide_opacity = 1.0
  vim.g.neovide_normal_opacity = 1.0
end
