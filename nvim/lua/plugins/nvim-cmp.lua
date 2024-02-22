return {
  -- then: setup supertab in cmp
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
    },
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })

      local cmp = require("cmp")

      opts.mapping = vim.tbl_extend("force", opts.mapping, {
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.confirm({ select = true }) -- 補完メニューが表示されている場合、選択中の項目を確定
          else
            fallback() -- 補完メニューが表示されていない場合、フォールバックの動作（例：通常のタブ挿入）
          end
        end, { "i", "s" }),
        ["<S-Tab>"] = function(fallback)
          cmp.abort()
          fallback()
        end,
        ["<CR>"] = function(fallback)
          cmp.abort()
          fallback()
        end,
        ["<C-CR>"] = function(fallback)
          cmp.abort()
          fallback()
        end,
        ["<S-CR>"] = function(fallback)
          cmp.abort()
          fallback()
        end,
      })
    end,
  },
}
