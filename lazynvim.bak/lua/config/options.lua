-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

-- encoding
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"

-- visual
opt.ambiwidth = "double" -- 全角文字を2文字分として扱います。
opt.smarttab = true -- インデントにタブを使用します。
opt.breakindent = true -- 折り返し時にインデントを維持します。
opt.autoindent = true -- 新しい行を作成する際に前の行と同じインデントを使用します。
opt.smartindent = true -- 自動インデントを有効にします。
opt.expandtab = true -- タブをスペースに変換します。
opt.shiftwidth = 2 -- シフト幅を設定します。
opt.tabstop = 2 -- タブ幅を設定します。

opt.visualbell = true -- ビジュアルベルを有効にします。
opt.number = true -- 行番号を表示します。
opt.showmatch = true -- 対応する括弧を表示します。
opt.matchtime = 1 -- マッチした文字列をハイライトする時間を設定します。

-- search
opt.incsearch = true -- 検索パターンに一致する文字列を入力すると、入力中に一致する箇所を表示します。
opt.ignorecase = true -- 検索パターンに大文字が含まれていない場合は大文字小文字を区別しません。
opt.smartcase = true -- 検索パターンに大文字が含まれている場合は大文字小文字を区別します。
opt.hlsearch = true -- 検索ハイライトを有効にします。
vim.api.nvim_set_keymap("n", "<Esc><Esc>", ":nohl<CR>", { noremap = true, silent = true }) -- Escを二度押しすると検索ハイライトをオフにします。

-- manipulation
vim.g.mapleader = " " -- <leader>
opt.clipboard:append({ "unnamedplus" }) -- クリップボードを有効にします。
opt.ttimeout = true -- タイプコマンドのタイムアウトを有効にします。
opt.ttimeoutlen = 50 -- タイプコマンドのタイムアウト時間を設定します。

opt.undofile = true -- undoファイルを有効にします。
opt.undodir = vim.fn.stdpath("cache") .. "/undo" -- undoファイルの保存先

-- indent
opt.list = true -- 特殊文字（タブやスペース）を可視化します。
opt.listchars = { eol = "↲" }
-- vim.opt.listchars = {tab='»-', space='⋅', eol='↲'}
-- vim.opt.listchars = {tab='»-', space='⋅', trail='-', eol='¬', extends='»', precedes='«', nbsp='%'}

opt.relativenumber = false
