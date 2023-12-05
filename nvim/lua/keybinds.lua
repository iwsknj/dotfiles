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

vim.keymap.set('n', 'Y', 'y$', { noremap = true })


