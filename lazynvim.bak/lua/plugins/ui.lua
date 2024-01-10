local M = {}

local bufferline = {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  keys = {
    { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
    { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev buffer" },
    { "<leader><Tab>w", "<Cmd>bw<CR>", desc = "Close buffer" },
  },
  opts = {
    options = {
      mode = "buffers",
      -- separator_style = "slant",
      -- show_buffer_close_icons = false,
      -- show_close_icon = false,
    },
  },
}

table.insert(M, bufferline)
return M
