local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

function merge_tables(t1, t2)
    local merged = {}
    for _, v in ipairs(t1) do
        table.insert(merged, v)
    end
    for _, v in ipairs(t2) do
        table.insert(merged, v)
    end
    return merged
end

local is_vscode = vim.g.vscode == 1

local common_plugins = {
  -- 両方で使うプラグインを列挙
  {
    'phaazon/hop.nvim',
    branch = 'v2',
    config = function()
      require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
      vim.keymap.set('', '<leader><leader>hw', '<cmd>HopWord<cr>')
      vim.keymap.set('', '<leader><leader>hl', '<cmd>HopLine<cr>')
      vim.keymap.set('', '<leader><leader>hf', '<cmd>HopChar1<cr>')
    end
  },
  {
    'tpope/vim-commentary'
  },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
}
}

local vscode_plugins = {
    -- vscode-neovimでのみ使うプラグインを列挙
}

local neovim_plugins = {
    -- Neovimでのみ使うプラグインを列挙
    {
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1000,
      opts = {},
    }
}

require('lazy').setup(
  merge_tables(common_plugins, is_vscode and vscode_plugins or neovim_plugins)
)
