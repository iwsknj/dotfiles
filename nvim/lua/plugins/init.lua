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

local function merge_tables(t1, t2)
    local merged = {}
    for _, v in ipairs(t1) do
        table.insert(merged, v)
    end
    for _, v in ipairs(t2) do
        table.insert(merged, v)
    end
    return merged
end

-- TODO: プラグインの読み込みや設定をファイルで分割する
local is_vscode = vim.g.vscode == 1
local common_plugins = {
    -- 両方で使うプラグインを列挙
    {
        'phaazon/hop.nvim', -- 単語や行にキーワードで移動する
        branch = 'v2',
        config = function()
             require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
             vim.keymap.set('', '<leader><leader>hw', '<cmd>HopWord<cr>')
             vim.keymap.set('', '<leader><leader>hl', '<cmd>HopLine<cr>')
             vim.keymap.set('', '<leader><leader>hf', '<cmd>HopChar1<cr>')
        end
    },
    {
        'tpope/vim-commentary' -- 行ごとにコメントアウトする
    },
    {
        "kylechui/nvim-surround", -- クォーテーションやカッコの操作
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end
    },
}

local vscode_plugins = {
    -- vscode-neovimでのみ使うプラグインを列挙
}

local neovim_plugins = {
    -- Neovimでのみ使うプラグインを列挙
    {
        "github/copilot.vim",
        lazy = false,
        config = function()
            vim.g.copilot_node_command = "~/.nvm/versions/node/v20.10.0/bin/node"
        end
    },
    {
         "folke/tokyonight.nvim", -- カラースキーム
         lazy = false,
         priority = 1000,
         opts = {},
    },
    {
        'nvim-lualine/lualine.nvim', -- vimのステータスラインの管理
        dependencies = { 'nvim-tree/nvim-web-devicons' },
        config = function()
          require('lualine').setup()
        end
    },
    {
        'akinsho/bufferline.nvim',
        version = "*",
        dependencies = 'nvim-tree/nvim-web-devicons',
        event = "VeryLazy",
        keys = {
            { "<Tab>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next tab" },
            { "<S-Tab>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev tab" },
        },
        opts = {
            options = {
                mode = "tabs",
            },
        },
    },
    {
         "lukas-reineke/indent-blankline.nvim",
         main = 'ibl',
         opts = {
           indent = {
             char = "╎",
           },
         },
         show_start = true,
         show_end = true,
         smart_indent_cap = true,
         priority = 2,
    },
    {
        'windwp/nvim-autopairs',
        event = "InsertEnter",
        opts = {} -- this is equalent to setup({}) function
    },
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup()
            require("scrollbar.handlers.gitsigns").setup()
        end
    },
    {
        "dinhhuy258/git.nvim",
        event = "BufReadPre",
        opts = {
            keymaps = {
                -- Open blame window
                blame = "<Leader>gb",
                -- Open file/folder in git repository
                browse = "<Leader>go",
            },
        },
        config = function()
            require('git').setup()
        end,
    },
    {
        "NeogitOrg/neogit",
        dependencies = {
          "nvim-lua/plenary.nvim",         -- required
          "sindrets/diffview.nvim",        -- optional - Diff integration

          -- Only one of these is needed, not both.
          "nvim-telescope/telescope.nvim", -- optional
          -- "ibhagwan/fzf-lua",              -- optional
        },
        config = true
    },
    {
        'akinsho/git-conflict.nvim',
        version = "*",
        config = true,
    },
    {
        "nvim-telescope/telescope.nvim",

        dependencies = {
            "nvim-lua/plenary.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
            'kyazdani42/nvim-web-devicons',
            'nvim-telescope/telescope-ui-select.nvim',
            "nvim-telescope/telescope-file-browser.nvim"
        },
        keys = {
            -- refference: https://github.com/craftzdog/dotfiles-public/blob/master/.config/nvim/lua/plugins/editor.lua
            {
                "<leader>fP",
                function()
                    require("telescope.builtin").find_files({
                        cwd = require("lazy.core.config").options.root,
                    })
               end,
               desc = "Find Plugin File",
            },
            {
                ";f",
                function()
                    local builtin = require("telescope.builtin")
                    builtin.find_files({
                        no_ignore = false,
                        hidden = true,
                    })
                end,
                desc = "Lists files in your current working directory, respects .gitignore",
            },
            {
                ";r",
                function()
                    local builtin = require("telescope.builtin")
                    builtin.live_grep()
                end,
                desc = "Search for a string in your current working directory and get results live as you type, respects .gitignore",
            },
            {
                "\\\\",
                function()
                    local builtin = require("telescope.builtin")
                    builtin.buffers()
                end,
                desc = "Lists open buffers",
            },
            {
                ";t",
                function()
                    local builtin = require("telescope.builtin")
                    builtin.help_tags()
                end,
                desc = "Lists available help tags and opens a new window with the relevant help info on <cr>",
            },
            {
                ";;",
                function()
                    local builtin = require("telescope.builtin")
                    builtin.resume()
                end,
                desc = "Resume the previous telescope picker",
            },
            {
                ";e",
                function()
                    local builtin = require("telescope.builtin")
                    builtin.diagnostics()
                end,
                desc = "Lists Diagnostics for all open buffers or a specific buffer",
            },
            {
                ";s",
                function()
                    local builtin = require("telescope.builtin")
                    builtin.treesitter()
                end,
                desc = "Lists Function names, variables, from Treesitter",
            },
            {
                ";b",
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
        },
        config = function(_, opts)
            local telescope = require("telescope")
            local fb_actions = require("telescope").extensions.file_browser.actions

            telescope.setup({
                defaults = {
                    wrap_results = true,
                    layout_strategy = "horizontal",
                    layout_config = { prompt_position = "top" },
                    sorting_strategy = "ascending",
                    winblend = 0,
                    mappings = {
                        i = {
                            ['<C-q>'] = 'close',
                        },
                        n = {
                            ['q'] = 'close',
                        },
                    },
                },
                pickers = {
                    diagnostics = {
                        theme = "ivy",
                        initial_mode = "normal",
                        layout_config = {
                            preview_cutoff = 9999,
                        },
                    },
                },
                extentions = {
                    file_browser = {
                        theme = "dropdown",
                        -- disables netrw and use telescope-file-browser in its place
                        hijack_netrw = true,
                        mappings = {
                            ["i"] = {
                                -- your custom insert mode mappings
                            },
                            ["n"] = {
                                -- your custom normal mode mappings
                                ["N"] = fb_actions.create,
                                ["R"] = fb_actions.rename,
                                ["h"] = fb_actions.goto_parent_dir,
                                ["/"] = function()
                                    vim.cmd("startinsert")
                                end,
                                ["<C-u>"] = function(prompt_bufnr)
                                    for i = 1, 10 do
                                        require("telescope.actions").move_selection_previous(prompt_bufnr)
                                    end
                                end,
                                ["<C-d>"] = function(prompt_bufnr)
                                    for i = 1, 10 do
                                        require("telescope.actions").move_selection_next(prompt_bufnr)
                                    end
                                end,
                                ["<PageUp>"] = require("telescope.actions").preview_scrolling_up,
                                ["<PageDown>"] = require("telescope.actions").preview_scrolling_down,
                            },
                        },
                    },
                }
            })

            require("telescope").load_extension("fzf")
            require("telescope").load_extension("file_browser")
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter", -- tree-sitterを使ってコードをハイライトするプラグイン
        build = ":TSUpdate",

        config = function()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                ensure_installed = {
                    "c",
                    "lua",
                    "vim",
                    "vimdoc",
                    "query",
                    -- ↑この5つはデフォルトで入れた方がいいやつ
                    "bash",
                    "css",
                    "gitignore",
                    "go",
                    "go",
                    "graphql",
                    "http",
                    "javascript",
                    "json",
                    "markdown",
                    "php",
                    "scss",
                    "sql",
                    "sql",
                    "toml",
                    "typescript",
                    "xml",
                    "yaml",
                },
                sync_install = false,
                auto_install = true,
                highlight = {
                    enable = true,
                },
                indent = {
                    enable = true,
                    disable = {},
                },
                autotag = {
                }
            })
        end
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
    },
    {
        "neovim/nvim-lspconfig",
        cmd = { "LspInfo", "LspLog" },
        event = { "BufRead" },
        config = function()
        end,
    },
    {
        "williamboman/mason.nvim", -- LSPサーバー管理
        cmd = { "Mason", "MasonInstall" },
        event = { "WinNew", "WinLeave", "BufRead" },
        config = function()
        end,
    },
    { "williamboman/mason-lspconfig.nvim" },
    { "WhoIsSethDaniel/mason-tool-installer.nvim"},

    { "L3MON4D3/LuaSnip" },

    { "hrsh7th/nvim-cmp" }, -- 補完エンジン
    { "hrsh7th/cmp-nvim-lsp" },
    { "hrsh7th/cmp-buffer" },
    { "saadparwaiz1/cmp_luasnip" },
    {
        'nvimdev/lspsaga.nvim',
        config = function()
            require('lspsaga').setup({})
        end,
        dependencies = {
            'nvim-treesitter/nvim-treesitter', -- optional
            'nvim-tree/nvim-web-devicons',     -- optional
        },
    },

    { "petertriho/nvim-scrollbar" }
}

require('lazy').setup(
    merge_tables(common_plugins, is_vscode and vscode_plugins or neovim_plugins)
)


local on_attach = function(client, bufnr)
    -- LSPサーバーのフォーマット機能を無効にするには下の行をコメントアウト
    -- 例えばtypescript-language-serverにはコードのフォーマット機能が付いているが代わりにprettierでフォーマットしたいときなど
    -- client.resolved_capabilities.document_formatting = false

    local set = vim.keymap.set
    set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
    set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
    set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
    set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
    set("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
    set("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>")
    set("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>")
    set("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")
    set("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
    set("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
    set("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
    set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
    set("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>")
    set("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
    set("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")
    set("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>")
    set("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>")
end

require("mason").setup()
require('mason-tool-installer').setup {
    ensure_installed = {
        "bash-language-server", -- bash lsp
        "css-lsp", -- css lsp
        "docker_compose_language_service", -- docker composer file lsp
        "dockerfile-language-server", -- docker file lsp
        "html-lsp", -- html lsp
        "intelephense", -- php lsp
        "json-lsp", -- json lsp
        "lua-language-server",
        "stylua", -- lua formatter
        "php-cs-fixer", -- php fomatter
        "phpmd", -- php linter
        "prettier", -- javascript linter
        "selene", -- lua linter
        "shellcheck", -- shell lint
        "tailwindcss-language-server", -- tailwind lsp
        "typescript-language-server", -- typescript lsp
    },
    auto_update = false,
}
require("mason-lspconfig").setup_handlers {
    function (server_name)
        require("lspconfig")[server_name].setup {
            on_attach = on_attach
        }
    end,
}
require("lspconfig").lua_ls.setup {
    settings = {
        Lua = {
            diagnostics = {
                -- Get the language server to recognize the `vim` global
                globals = {
                  'vim',
                  'require'
                },
            },
        }
    },
}

-- Indent blank lineの設定
local highlight = {
    "Gray",
}

local hooks = require "ibl.hooks"
-- create the highlight groups in the highlight setup hook, so they are reset
-- every time the colorscheme changes
hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, "Gray", { fg = "#7d7d7d" })
end)

require("ibl").setup {
    indent = {
        char = "╎",
        highlight = highlight
    }
}

-- bufferlineの設定
vim.opt.termguicolors = true
require("bufferline").setup{}

-- petertriho/nvim-scrollbarの設定
local colors = require("tokyonight.colors").setup()
require("scrollbar").setup({
    handle = {
        color = colors.bg_highlight,
    },
    marks = {
        Search = { color = colors.orange },
        Error = { color = colors.error },
        Warn = { color = colors.warning },
        Info = { color = colors.info },
        Hint = { color = colors.hint },
        Misc = { color = colors.purple },
    }
})

