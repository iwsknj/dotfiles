-- 起動の高速化
if vim.loader then
  vim.loader.enable()
end

-- TODO: debugできるようにする
-- https://github.com/craftzdog/dotfiles-public/blob/master/.config/nvim/lua/util/debug.lua

-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
