-- encoding
vim.o.encofing='utf-8'
vim.scriptencoding='utf-8'

-- visual
vim.o.ambiwidth='double'
vim.opt.smarttab = true
vim.opt.breakindent = true
vim.o.autoindent=true
vim.o.smartindent=true

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

-- indent
vim.o.list = true
vim.opt.listchars = {tab='»-', space='⋅'}
-- vim.opt.listchars = {tab='»-', space='⋅', trail='-', eol='¬', extends='»', precedes='«', nbsp='%'}
