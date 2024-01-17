return {
  "akinsho/nvim-bufferline.lua",
  opts = {
    options = {
      numbers = function(numbers_opts)
        return string.format("%s|%s", numbers_opts.id, numbers_opts.raise(numbers_opts.ordinal))
      end,
    },
  },
}
