return {
  "nvimtools/none-ls.nvim",
  optional = true,
  opts = function(_, opts)
    local nls = require("null-ls")
    opts.sources = opts.sources or {}
    table.insert(opts.sources, nls.builtins.formatting.htmlbeautifier)
    table.insert(
      opts.sources,
      nls.builtins.diagnostics.haml_lint.with({
        method = require("null-ls").methods.DIAGNOSTICS_ON_SAVE,
      })
    )
  end,
}
