-- refference:
  -- https://github.com/disk-inue/dotfiles/tree/work-article
  -- https://zenn.dev/monicle/articles/59ff479ae51c66
  -- https://github.com/craftzdog/dotfiles-public/tree/master

vim.loader.enable()
require 'options'
require 'keybinds'
require 'autocmds'
require 'extensions'
require 'appearance' -- テーマをプラグインとして読み込んでるから読み込みが終わってから読み込む

-- netrw（デフォルトのファイラー）を読み込まない
vim.api.nvim_set_var('loaded_netrw', 1)
vim.api.nvim_set_var('loaded_netrwPlugin', 1)

