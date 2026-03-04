return {
  {
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
      "Gdiffsplit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "GMove",
      "GDelete",
      "GBrowse",
      "GRemove",
      "GRename",
      "Glgrep",
      "Gedit",
    },
    ft = { "fugitive" },
  },

  {
    "folke/trouble.nvim",
    opts = {}, -- for default options, refer to the configuration section for custom setup.
    cmd = "Trouble",
    keys = {
      {
        "<leader>xx",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Diagnostics (Trouble)",
      },
      {
        "<leader>xX",
        "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
        desc = "Buffer Diagnostics (Trouble)",
      },
      {
        "<leader>cs",
        "<cmd>Trouble symbols toggle focus=false<cr>",
        desc = "Symbols (Trouble)",
      },
      {
        "<leader>cl",
        "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
        desc = "LSP Definitions / references / ... (Trouble)",
      },
      {
        "<leader>xL",
        "<cmd>Trouble loclist toggle<cr>",
        desc = "Location List (Trouble)",
      },
      {
        "<leader>xQ",
        "<cmd>Trouble qflist toggle<cr>",
        desc = "Quickfix List (Trouble)",
      },
    },
  },

  {
    "windwp/nvim-ts-autotag",
    ft = { "typescriptreact", "javascriptreact", "markdown", "html", "php" },
    config = function()
      require("nvim-ts-autotag").setup {
        opts = {
          -- Defaults
          enable_close = true, -- Auto close tags
          enable_rename = true, -- Auto rename pairs of tags
          enable_close_on_slash = true, -- Auto close on trailing </
        },
      }
    end,
  },

  {
    "stevearc/aerial.nvim",
    ft = { "javascript", "typescript", "php", "typescriptreact", "javascriptreact", "python" },
    config = function()
      require("aerial").setup()
    end,
  },

  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end,
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end,
  },

  {
    "mfussenegger/nvim-dap",
    config = function()
      require("configs.nvim-dap").dap()
    end,
    dependencies = {
      "suketa/nvim-dap-ruby",
      {
        "rcarriga/nvim-dap-ui",
        config = function()
          require("configs.nvim-dap").dap_ui()
        end,
        dependencies = { "nvim-neotest/nvim-nio" },
      },
      {
        "theHamsta/nvim-dap-virtual-text",
        config = function()
          require("nvim-dap-virtual-text").setup()
        end,
      },
    },
  },

  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    config = function()
      require("ts_context_commentstring").setup {
        enable_autocmd = false,
      }
    end,
    dependencies = {
      {
        "numToStr/Comment.nvim",
        opts = {
          pre_hook = function(ctx)
            local U = require "Comment.utils"

            -- Determine whether to use linewise or blockwise commentstring
            local type = ctx.ctype == U.ctype.linewise and "__default" or "__multiline"

            -- Determine the location where to calculate commentstring from
            local location = nil
            if ctx.ctype == U.ctype.blockwise then
              location = {
                ctx.range.srow - 1,
                ctx.range.scol,
              }
            elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
              location = require("ts_context_commentstring.utils").get_visual_start_location()
            end

            return require("ts_context_commentstring").calculate_commentstring {
              key = type,
              location = location,
            }
          end,
        },
      },
    },
    ft = { "javascriptreact", "typescriptreact" },
  },
  -- {
  --   "kevinhwang91/nvim-ufo",
  --   dependencies = "kevinhwang91/promise-async",
  --   config = function()
  --     require("ufo").setup {
  --       provider_selector = function(bufnr, filetype, buftype)
  --         return { "treesitter", "indent" }
  --       end,
  --     }
  --   end,
  --   lazy = false,
  -- },
  {
    "mfussenegger/nvim-dap-python",
    ft = { "python" },
    config = function()
      require("dap-python").setup "uv"
    end,
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },

  {
    "romgrk/nvim-treesitter-context",
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("treesitter-context").setup {}
    end,
    lazy = false,
  },

  {
    "gbprod/yanky.nvim",
    lazy = false,
    opts = {},
    dependencies = { "folke/snacks.nvim" },
    keys = {
      {
        "<leader>p",
        function()
          Snacks.picker.yanky()
        end,
        mode = { "n", "x" },
        desc = "Open Yank History",
      },
    },
  },

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
      bigfile = { enabled = true },
      indent = { enabled = true },
      quickfile = { enabled = true },
      dim = {},
      words = {},
      picker = {},
      explorer = {},
    },
    keys = {
      {
        "<leader><space>",
        function()
          Snacks.picker.smart()
        end,
        desc = "Smart Find Files",
      },
      {
        "<leader>,",
        function()
          Snacks.picker.buffers()
        end,
        desc = "Buffers",
      },
      {
        "<leader>/",
        function()
          Snacks.picker.grep()
        end,
        desc = "Grep",
      },
      {
        "<leader>:",
        function()
          Snacks.picker.command_history()
        end,
        desc = "Command History",
      },
      {
        "<leader>n",
        function()
          Snacks.picker.notifications()
        end,
        desc = "Notification History",
      },
      {
        "<leader>e",
        function()
          Snacks.explorer()
        end,
        desc = "File Explorer",
      },
    },
  },
  -- {
  --   "azorng/goose.nvim",
  --   lazy = false,
  --   config = function()
  --     require("goose").setup {}
  --   end,
  --   dependencies = {
  --     "nvim-lua/plenary.nvim",
  --     {
  --       "MeanderingProgrammer/render-markdown.nvim",
  --       opts = {
  --         anti_conceal = { enabled = false },
  --       },
  --     },
  --   },
  -- },
  {
    "pwntester/octo.nvim",
    cmd = "Octo",
    opts = {
      -- or "fzf-lua" or "snacks" or "default"
      picker = "telescope",
      -- bare Octo command opens picker of commands
      enable_builtin = true,
    },
    keys = {
      {
        "<leader>oi",
        "<CMD>Octo issue list<CR>",
        desc = "List GitHub Issues",
      },
      {
        "<leader>op",
        "<CMD>Octo pr list<CR>",
        desc = "List GitHub PullRequests",
      },
      {
        "<leader>od",
        "<CMD>Octo discussion list<CR>",
        desc = "List GitHub Discussions",
      },
      {
        "<leader>on",
        "<CMD>Octo notification list<CR>",
        desc = "List GitHub Notifications",
      },
      {
        "<leader>os",
        function()
          require("octo.utils").create_base_search_command { include_current_repo = true }
        end,
        desc = "Search GitHub",
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
      -- OR "ibhagwan/fzf-lua",
      -- OR "folke/snacks.nvim",
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "gennaro-tedesco/nvim-jqx",
    event = { "BufReadPost" },
    ft = { "json", "yaml" },
  },
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    keys = {
      {
        "[f",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@function.inner", "textobjects")
        end,
        desc = "inner function",
        mode = { "n", "x", "o" },
      },
      {
        "]f",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@function.outer", "textobjects")
        end,
        desc = "outer function",
        mode = { "n", "x", "o" },
      },
      {
        "]c",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@class.outer", "textobjects")
        end,
        desc = "outer class",
        mode = { "n", "x", "o" },
      },
      {
        "[c",
        function()
          require("nvim-treesitter-textobjects.select").select_textobject("@class.inner", "textobjects")
        end,
        desc = "inner class",
        mode = { "n", "x", "o" },
      },
    },

    init = function()
      -- Disable entire built-in ftplugin mappings to avoid conflicts.
      -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
      vim.g.no_plugin_maps = true

      -- Or, disable per filetype (add as you like)
      -- vim.g.no_python_maps = true
      -- vim.g.no_ruby_maps = true
      -- vim.g.no_rust_maps = true
      -- vim.g.no_go_maps = true
    end,
    config = function()
      -- put your config here
    end,
  },
}
