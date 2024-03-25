return {
  "stevearc/conform.nvim",
  opts = function(_, opts)
    table.insert(opts.formatters_by_ft, { ["eruby"] = "htmlbeautifier" })
  end,
}
