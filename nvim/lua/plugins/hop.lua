return {
  "phaazon/hop.nvim",
  vscode = true,
  branch = "v2",
  config = function()
    -- place this in one of your configuration file(s)
    local hop = require("hop")
    local directions = require("hop.hint").HintDirection

    hop.setup()

    vim.keymap.set("n", "f", function()
      hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
    end, { remap = true, desc = "fコマンドの拡張。;で移動はできない" })
    vim.keymap.set("n", "F", function()
      hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
    end, { remap = true, desc = "Fコマンドの拡張。;で移動はできない" })
    vim.keymap.set("n", "t", function()
      hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
    end, { remap = true })
    vim.keymap.set("n", "T", function()
      hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
    end, { remap = true })
    vim.keymap.set("n", "<leader><leader>j", function()
      hop.hint_words({ direction = directions.AFTER_CURSOR })
    end, { remap = true, desc = "下方向に単語移動" })
    vim.keymap.set("n", "<leader><leader>k", function()
      hop.hint_words({ direction = directions.BEFORE_CURSOR })
    end, { remap = true, desc = "上方向に単語移動" })
    vim.keymap.set("n", "<leader><leader>hl", "<cmd>HopLine<cr>", { remap = true, desc = "行移動" })
  end,
}
