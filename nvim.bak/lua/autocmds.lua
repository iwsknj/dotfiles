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

-- 保存時に行末の空白を削除する
vim.api.nvim_create_autocmd("BufWritePre", {
    pattern = "*",
    callback = function()
         local save_cursor = vim.api.nvim_win_get_cursor(0)

         -- 末尾の空白を削除
         vim.cmd([[ %s/\s\+$//e ]])

        -- ファイルの最後の行を取得
        local last_line = vim.fn.line("$")

        -- 末尾の空行を一行だけ残す
        while last_line > 1 and string.match(vim.fn.getline(last_line), "^%s*$") do
            if string.match(vim.fn.getline(last_line - 1), "^%s*$") then
                vim.api.nvim_buf_set_lines(0, last_line - 1, last_line, false, {})
            else
                break
            end
            last_line = last_line - 1
        end

        -- ファイルの最後の行が空行でなければ、空行を追加
        if last_line == 0 or not string.match(vim.fn.getline(last_line), "^%s*$") then
            vim.fn.append(last_line, "")
        end

        -- カーソル位置を調整
        if save_cursor[1] > vim.fn.line("$") then
            save_cursor[1] = vim.fn.line("$")
        end
        vim.api.nvim_win_set_cursor(0, save_cursor)
    end,
})

