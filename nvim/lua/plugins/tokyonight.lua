return {
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = function(_, opts)
      opts.styoe = "moon"
      local tokyonight = require("tokyonight")
      opts.on_highlights = function(highlights, colors)
        highlights.LineNr = { fg = "#87CEEB" }
      end

      tokyonight.setup(opts)
    end,
  },
}
