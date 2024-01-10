local M = {}

-- telescope setting
local t_builtin = require("telescope.builtin")
local telescope = {
  "telescope.nvim",
  dependencies = {
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
    },
    "nvim-telescope/telescope-file-browser.nvim",
  },
  keys = {
    -- add a keymap to browse plugin files
    -- stylua: ignore
    {
      "<leader>tP",
      function() t_builtin.find_files({ cwd = require("lazy.core.config").options.root }) end,
      desc = "Find Plugin File",
    },
    {
      "<leader>tf",
      function()
        t_builtin.find_files({ hidden = true })
      end,
      desc = "Lists files in your current working directory, respects .gitignore. but include .git dir ",
    },
    {
      "<leader>tr",
      function()
        t_builtin.live_grep()
      end,
      desc = "Search for a string in your current working directory and get results live as you type, respects .gitignore",
    },
    {
      "<leader>t/",
      function()
        t_builtin.buffers()
      end,
      desc = "Lists open buffers",
    },
    {
      "<leader>tt",
      function()
        t_builtin.help_tags()
      end,
      desc = "Lists available help tags and opens a new window with the relevant help info on <cr>",
    },
    {
      "<leader>t;",
      function()
        t_builtin.resume()
      end,
      desc = "Resume the previous telescope picker",
    },
    {
      "<leader>te",
      function()
        t_builtin.diagnostics()
      end,
      desc = "Lists Diagnostics for all open buffers or a specific buffer",
    },
    {
      "<leader>ts",
      function()
        t_builtin.treesitter()
      end,
      desc = "Lists Function names, variables, from Treesitter",
    },
    {
      "<leader>tb",
      function()
        local telescope = require("telescope")
        local function telescope_buffer_dir()
          return vim.fn.expand("%:p:h")
        end

        telescope.extensions.file_browser.file_browser({
          path = "%:p:h",
          cwd = telescope_buffer_dir(),
          respect_gitignore = false,
          hidden = true,
          grouped = true,
          previewer = false,
          initial_mode = "normal",
          layout_config = { height = 40 },
        })
      end,
      desc = "Open File Browser with the path of the current buffer",
    },
    -- Git
    { "<leader>tgc", "<cmd>Telescope git_commits<CR>", desc = "git commits" },
    { "<leader>tgs", "<cmd>Telescope git_status<CR>", desc = "git status" },
  },
  config = function(_, opts)
    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local fb_actions = require("telescope").extensions.file_browser.actions

    opts.defaults = vim.tbl_deep_extend("force", opts.defaults, {
      wrap_results = true,
      layout_strategy = "horizontal",
      layout_config = { prompt_position = "top" },
      sorting_strategy = "ascending",
      winblend = 0,
      mappings = {
        n = {},
      },
    })
    opts.pickers = {
      diagnostics = {
        theme = "ivy",
        initial_mode = "normal",
        layout_config = {
          preview_cutoff = 9999,
        },
      },
    }

    opts.extensions = {
      file_browser = {
        theme = "dropdown",
        -- disables netrw and use telescope-file-browser in its place
        hijack_netrw = true,
        mappings = {
          -- your custom insert mode mappings
          ["n"] = {
            -- your custom normal mode mappings
            ["N"] = fb_actions.create,
            ["h"] = fb_actions.goto_parent_dir,
            ["/"] = function()
              vim.cmd("startinsert")
            end,
            ["<C-u>"] = function(prompt_bufnr)
              for _ = 1, 10 do
                actions.move_selection_previous(prompt_bufnr)
              end
            end,
            ["<C-d>"] = function(prompt_bufnr)
              for _ = 1, 10 do
                actions.move_selection_next(prompt_bufnr)
              end
            end,
            ["<PageUp>"] = actions.preview_scrolling_up,
            ["<PageDown>"] = actions.preview_scrolling_down,
          },
        },
      },
    }

    telescope.setup(opts)
    require("telescope").load_extension("fzf")
    require("telescope").load_extension("file_browser")
  end,
}

-- cheatsheet
local cheatsheet = {
  "sudormrfbin/cheatsheet.nvim",
  config = function()
    require("cheatsheet").setup({
      bundled_cheatsheets = {
        enabled = { "default" },
      },
      bundled_plugin_cheatsheets = false,
    })
  end,
}

-- 行ごとにコメントアウトする
local vim_commentary = {
  "tpope/vim-commentary",
  vscode = true,
}

-- 単語や行にキーワードで移動する
local hop = {
  "phaazon/hop.nvim",
  vscode = true,
  branch = "v2",
  keys = {
    { "<leader><leader>hw", "<cmd>HopWord<cr>", desc = "Hop Word" },
    { "<leader><leader>hl", "<cmd>HopLine<cr>", desc = "Hop Line" },
    { "<leader><leader>hf", "<cmd>HopChar1<cr>", desc = "Hop Char" },
  },
  config = true,
}

-- クォーテーションやカッコの操作
local nvim_surround = {
  "kylechui/nvim-surround",
  vscode = true,
  version = "*", -- Use for stability; omit to use `main` branch for the latest features
  event = "VeryLazy",
  config = true,
}

local scrollbar = {
  "petertriho/nvim-scrollbar",
  config = true,
}

table.insert(M, telescope)
table.insert(M, cheatsheet)
table.insert(M, vim_commentary)
table.insert(M, hop)
table.insert(M, nvim_surround)
table.insert(M, scrollbar)
return M
