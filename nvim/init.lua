-- refference:
  -- https://github.com/disk-inue/dotfiles/tree/work-article
  -- https://zenn.dev/monicle/articles/59ff479ae51c66

vim.loader.enable()
require 'options'
require 'keybinds'
require 'appearance'
require 'extensions'
require 'color_scheme' -- プラグインを読み込んでから

-- netrw
vim.api.nvim_set_var('loaded_netrw', 1)
vim.api.nvim_set_var('loaded_netrwPlugin', 1)

