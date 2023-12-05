-- 保存時にEOLが空行で無ければ空行を追加する
local function add_eol()
  local lines = vim.api.nvim_buf_get_lines(0, -2, -1, false)
  if #lines == 0 or #lines[1] > 0 then
      vim.api.nvim_buf_set_lines(0, -1, -1, false, {""})
  end
end

vim.api.nvim_create_autocmd("BufWritePre", {
  callback = add_eol,
})


-- ファイルごとのインデントの設定
local function set_tab_spaces(buf, num_spaces, expandtab)
  vim.api.nvim_buf_set_option(buf, 'tabstop', num_spaces)
  vim.api.nvim_buf_set_option(buf, 'shiftwidth', num_spaces)
  vim.api.nvim_buf_set_option(buf, 'softtabstop', 0) -- 0にするとtabstopの値が使われる
  vim.api.nvim_buf_set_option(buf, 'expandtab', expandtab)
end

vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
  pattern = '*',
  group = vim.api.nvim_create_augroup('buffer_set_options', {}),
  callback = function()
    local buf = 0 -- 現在のバッファ
    local file_type = vim.bo.filetype -- 現在のファイルタイプ

    local four_space_file_types = {
      php = true
    }

    if four_space_file_types[file_type] then
      -- 特定のファイルタイプ（PythonやPHP）の場合、インデントをスペース4つに設定
      set_tab_spaces(buf, 4, true)
    elseif file_type == 'go' then
      -- Goの場合、インデントをタブでスペース4つ分に設定
      set_tab_spaces(buf, 4, false)
    else
      -- デフォルト設定: インデントをスペース2つに設定
      set_tab_spaces(buf, 2, true)
    end
  end
})
