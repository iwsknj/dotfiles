-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- vim.opt.ignorecase = true -- Case insensitive searching UNLESS /C or capital in search
local opt = vim.opt
opt.encoding = "utf-8"
opt.fileencoding = "utf-8"
opt.smarttab = true -- インデントにタブを使用します。
opt.breakindent = true -- 折り返し時にインデントを維持します。
opt.autoindent = true -- 新しい行を作成する際に前の行と同じインデントを使用します。
opt.smartindent = true -- 自動インデントを有効にします。
opt.expandtab = true -- タブをスペースに変換します。
opt.shiftwidth = 2 -- シフト幅を設定します。
opt.tabstop = 2 -- タブ幅を設定します。
opt.incsearch = true -- 検索パターンに一致する文字列を入力すると、入力中に一致する箇所を表示します。
opt.hlsearch = true -- 検索ハイライトを有効にします。
opt.wrap = true -- 行の折り返しを有効にします。
-- opt.list = true -- 特殊文字（タブやスペース）を可視化します。
-- opt.listchars = { eol = "↲" }
opt.relativenumber = false -- 行番号を絶対値で表示します。
