return {
  'junegunn/vim-easy-align',
  config = function()
    -- Visualモードでのキーバインド
    vim.api.nvim_set_keymap('x', 'ga', '<Plug>(EasyAlign)', {})
    -- ノーマルモードでのキーバインド
    vim.api.nvim_set_keymap('n', 'ga', '<Plug>(EasyAlign)', {})
  end
}
