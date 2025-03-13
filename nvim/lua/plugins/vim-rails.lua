-- VSCode & Cursorを中心に使うため不使用
return {}

-- return {
--   "tpope/vim-rails",
--   config = function()
--     -- disable autocmd set filetype=eruby.yaml
--     vim.api.nvim_create_autocmd(
--       { 'BufNewFile', 'BufReadPost' },
--       {
--         pattern = { '*.yml' },
--         callback = function()
--           vim.bo.filetype = 'yaml'
--         end

--       }
--     )
--   end
-- }
