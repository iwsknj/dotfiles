return {
  "williamboman/mason.nvim",
  opts = function(_, opts)
    vim.list_extend(opts.ensure_installed, {
      -- lazyvim.plugins.extras.lang.xxxで設定できないものはここでインストールする
      "shellcheck",
      "css-lsp",
    })
  end,
}
