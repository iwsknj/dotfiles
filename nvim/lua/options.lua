-- encoding
vim.o.encofing='utf-8'
vim.scriptencoding='utf-8'

-- visual
vim.o.ambiwidth='double' -- 全角文字を2文字分として扱います。
vim.opt.smarttab = true -- インデントにタブを使用します。
vim.opt.breakindent = true -- 折り返し時にインデントを維持します。
vim.o.autoindent=true -- 新しい行を作成する際に前の行と同じインデントを使用します。
vim.o.smartindent=true -- 自動インデントを有効にします。

vim.o.visualbell = true -- ビジュアルベルを有効にします。
vim.o.number = true -- 行番号を表示します。
vim.o.showmatch = true -- 対応する括弧を表示します。
vim.o.matchtime = 1 -- マッチした文字列をハイライトする時間を設定します。

-- search
vim.o.incsearch = true -- 検索パターンに一致する文字列を入力すると、入力中に一致する箇所を表示します。
vim.o.ignorecase = true -- 検索パターンに大文字が含まれていない場合は大文字小文字を区別しません。
vim.o.smartcase = true -- 検索パターンに大文字が含まれている場合は大文字小文字を区別します。
vim.o.hlsearch = true -- 検索ハイライトを有効にします。
vim.api.nvim_set_keymap('n', '<Esc><Esc>', ':nohl<CR>', { noremap = true, silent = true}) -- Escを二度押しすると検索ハイライトをオフにします。

-- manipulation
vim.g.mapleader = ' ' -- <leader>
vim.opt.clipboard:append{'unnamedplus'} -- クリップボードを有効にします。
vim.o.ttimeout = true -- タイプコマンドのタイムアウトを有効にします。
vim.o.ttimeoutlen = 50 -- タイプコマンドのタイムアウト時間を設定します。

vim.o.undofile = true -- undoファイルを有効にします。
vim.o.undodir = vim.fn.stdpath('cache') .. '/undo' -- undoファイルの保存先

-- indent
vim.o.list = true -- 特殊文字（タブやスペース）を可視化します。
vim.opt.listchars = {tab='»-', space='⋅'}
-- vim.opt.listchars = {tab='»-', space='⋅', trail='-', eol='¬', extends='»', precedes='«', nbsp='%'}
