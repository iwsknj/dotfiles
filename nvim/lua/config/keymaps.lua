-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local discipline = require("utils.discipline")
discipline.cowboy()

local keymap = vim.keymap
keymap.set("i", "jj", "<ESC>", { noremap = true, desc = "jjでインサートモードを抜ける" })

keymap.set(
  "n",
  "+",
  "<Cmd>let @+ = @@<CR>",
  { noremap = true, desc = "レジスタ+に無名レジスタの文字列をコピー" }
)

keymap.set('n', 'j', 'gj', {noremap = true, desc = 'jで折り返しを無視'})
keymap.set('n', 'k', 'gk', {noremap = true, desc = 'kで折り返しを無視'})

-- ビジュアル選択した範囲を「ファイルパス:行番号\n内容」の形式でクリップボードにコピー
-- AIへの指示など、コードの場所を伝えたいときに使う
keymap.set("v", "<leader>y", function()
  local start_line = vim.fn.line("v")
  local end_line = vim.fn.line(".")
  local filepath = vim.fn.expand("%")
  local lines = vim.fn.getline(start_line, end_line)
  local content = table.concat(lines, "\n")
  local result = filepath .. ":" .. start_line .. "-" .. end_line .. "\n" .. content
  vim.fn.setreg("+", result)
  print("Copied: " .. filepath .. ":" .. start_line .. "-" .. end_line)
end, { desc = "ファイルパスと行番号付きでコピー" })
