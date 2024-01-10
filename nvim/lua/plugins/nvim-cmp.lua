return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local cmp = require("cmp")
    -- Enterではなく、Tabで補完する
    opts.mapping = cmp.mapping.preset.insert({
      ["<CR>"] = nil,
      ["<Tab>"] = cmp.mapping.confirm({ select = true }),
    })
  end,
}
