-- VSCode & Cursorを中心に使うため不使用
return {}

-- return {
--   "hrsh7th/cmp-cmdline",
--   config = function()
--     local cmp = require("cmp")

--     -- cmp-cmdline
--     cmp.setup.cmdline({ "/", "?" }, {
--       mapping = cmp.mapping.preset.cmdline(),
--       sources = {
--         { name = "buffer" },
--       },
--     })
--     cmp.setup.cmdline(":", {
--       mapping = cmp.mapping.preset.cmdline(),
--       sources = cmp.config.sources({
--         { name = "path" },
--       }, {
--         {
--           name = "cmdline",
--           -- option = {
--           --     ignore_cmds = { 'Man', '!' }
--           -- }
--         },
--       }),
--     })
--   end,
-- }
