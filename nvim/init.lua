-- encoding
vim.o.encofing = 'utf-8'
vim.scriptencoding = 'utf-8'

-- visual
vim.o.ambiwidth = 'double'
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.autoindent = true
vim.o.smartindent = true

vim.o.visualbell = true
vim.o.number = true
vim.o.showmatch = true
vim.o.matchtime = 1

-- search
vim.o.incsearch = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.hlsearch = true
vim.api.nvim_set_keymap('n', '<Esc><Esc>', ':nohl<CR>', { noremap = true, silent = true})

-- manipulation
vim.g.mapleader = ' ' -- <leader>
vim.opt.clipboard:append{'unnamedplus'}
vim.o.ttimeout = true
vim.o.ttimeoutlen = 50

vim.o.undofile = true
vim.o.undodir = vim.fn.stdpath('cache') .. '/undo'

--------------
-- keymap
--------------
-- インサートモード抜ける
vim.keymap.set('i', 'jj', '<ESC>', { silent = true})
-- 表示行単位で上下移動するように
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')
vim.keymap.set('n', '<Down>', 'gj')
vim.keymap.set('n', '<Up>', 'gk')
-- 逆に普通の行単位で移動したい時のために逆の map も設定しておく
vim.keymap.set('n', 'gj', 'j')
vim.keymap.set('n', 'gk', 'k')
-- 日本語用
vim.keymap.set('n', 'あ', 'a')
vim.keymap.set('n', 'い', 'i')
vim.keymap.set('n', 'う', 'u')
vim.keymap.set('n', 'お', 'o')
vim.keymap.set('n', 'っd', 'dd')
vim.keymap.set('n', 'っy', 'yy')

-- lua/lazy_nvim.initを読み込む
require('lazy_nvim')

-- カラースキーム
require('color_scheme')
