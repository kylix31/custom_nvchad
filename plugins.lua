local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {

  -- Override plugin definition options

  {
    "neovim/nvim-lspconfig",
    -- dependencies = {
    -- format & linting
    -- {
    --   "jose-elias-alvarez/null-ls.nvim",
    --   config = function()
    --     require "custom.configs.null-ls"
    --   end,
    -- },
    -- },
    config = function()
      require "plugins.configs.lspconfig"
      require "custom.configs.lspconfig"
    end,
    -- opts = {
    --   diagnostics = {
    --     underline = true,
    --     update_in_insert = false,
    --     virtual_text = {
    --       spacing = 4,
    --       source = "if_many",
    --       prefix = "●",
    --       -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
    --       -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
    --       -- prefix = "icons",
    --     },
    --     severity_sort = true,
    --     inlay_hints = {
    --       enabled = false,
    --     },
    --   },
    -- },
  },

  -- override plugin configs
  -- {
  --   "williamboman/mason.nvim",
  --   opts = overrides.mason,
  -- },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  -- {
  --   "max397574/better-escape.nvim",
  --   event = "InsertEnter",
  --   config = function()
  --     require("better_escape").setup()
  --   end,
  -- },

  {
    "tpope/vim-fugitive",
    init = function()
      require("core.utils").load_mappings "fugitive"
    end,
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
    "metakirby5/codi.vim",
    cmd = "Codi",
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

  -- {
  --   "andymass/vim-matchup",
  --   config = function()
  --     vim.g.matchup_matchparen_offscreen = { method = "popup" }
  --   end,
  --   ft = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  -- },

  {
    "stevearc/aerial.nvim",
    ft = { "javascript", "typescript", "php", "typescriptreact", "javascriptreact" },
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
      require("custom.configs.nvim-dap").dap()
    end,
    init = function()
      require("core.utils").load_mappings "dap"
    end,
    dependencies = {
      {
        "rcarriga/nvim-dap-ui",
        config = function()
          require("custom.configs.nvim-dap").dap_ui()
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

  -- To make a plugin not be loaded
  -- {
  --   "NvChad/nvim-colorizer.lua",
  --   enabled = false
  -- },

  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   event = "InsertEnter",
  --   config = function()
  --     require("copilot").setup {
  --       suggestion = {
  --         enabled = true,
  --         auto_trigger = true,
  --         debounce = 75,
  --         keymap = {
  --           accept = "<M-l>",
  --           accept_word = false,
  --           accept_line = false,
  --           next = "<M-]>",
  --           prev = "<M-[>",
  --           dismiss = "<C-]>",
  --         },
  --       },
  --     }
  --   end,
  -- },

  -- {
  --   "zbirenbaum/copilot-cmp",
  --   config = function()
  --     -- require("copilot_cmp").setup { opts = { event = nil } }
  --     require("copilot_cmp").setup {}
  --   end,
  --   event = "InsertEnter",
  --   dependencies = {
  --     {
  --       "zbirenbaum/copilot.lua",
  --       cmd = "Copilot",
  --       config = function()
  --         require("copilot").setup { suggestion = { enabled = false }, panel = { enabled = false } }
  --       end,
  --     },
  --   },
  -- },

  {
    "kevinhwang91/nvim-ufo",
    event = "VeryLazy",
    dependencies = { "kevinhwang91/promise-async" },
    branch = "main",
    commit = "7dcb8fea3e7b3ccdb50f2c3ae7c248cdf6fe1ae1",
    config = function()
      require "custom.configs.nvim-ufo"
    end,
  },

  -- override cmp default config sources
  -- {
  --   "hrsh7th/nvim-cmp",
  --   opts = overrides.cmp,
  -- },
  -- {
  --   "jackMort/ChatGPT.nvim",
  --   event = "VeryLazy",
  --   config = function()
  --     require "custom.configs.chatpgt"
  --   end,
  --   dependencies = {
  --     "MunifTanjim/nui.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "nvim-telescope/telescope.nvim",
  --   },
  -- },

  -- {
  --   "mfussenegger/nvim-jdtls",
  --   ft = { "java" },
  -- },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      require("telescope").load_extension "file_browser"
    end,
  },
  -- {
  --   "utilyre/barbecue.nvim",
  --   name = "barbecue",
  --   lazy = false,
  --   version = "*",
  --   dependencies = {
  --     "SmiteshP/nvim-navic",
  --     "nvim-tree/nvim-web-devicons", -- optional dependency
  --   },
  -- },

  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
    lazy = false,
    dependencies = {
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      require("telescope").load_extension "fzf"
    end,
  },

  -- For the current symbols
  {
    "utilyre/barbecue.nvim",
    lazy = false,
    name = "barbecue",
    version = "*",
    dependencies = {
      "SmiteshP/nvim-navic",
      "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    config = function()
      require("barbecue").setup {
        attach_navic = false, -- prevent barbecue from automatically attaching nvim-navic
      }
    end,
  },
  -- Memory leak
  -- {
  --   "barrett-ruth/import-cost.nvim",
  --   build = "sh install.sh yarn",
  --   -- if on windows
  --   -- build = 'pwsh install.ps1 yarn',
  --   ft = { "typescriptreact", "javascriptreact" },
  --   config = function()
  --     require("import-cost").setup()
  --   end,
  -- },

  --linter and format
  {
    "creativenull/efmls-configs-nvim",
    dependencies = { "neovim/nvim-lspconfig" },
  },

  {
    "mfussenegger/nvim-dap-python",
    ft = { "python" },
    config = function()
      require("dap-python").setup "/home/kylix/.virtualenvs/debugpy/bin/python"
    end,
  },

  {
    "lukas-reineke/lsp-format.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("lsp-format").setup {}
    end,
  },

  -- {
  --   "stevearc/conform.nvim",
  --   event = { "BufWritePre" },
  --   cmd = { "ConformInfo" },
  --   opts = require("custom.configs.conform").opts,
  -- },

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
    "robitx/gp.nvim",
    lazy = false,
    config = function()
      config = require("custom.configs.gp-config").config

      require("gp").setup(config)

      require("custom.configs.gp-config").mappings()

      -- or setup with your own config (see Install > Configuration in Readme)
      -- require("gp").setup(config)

      -- shortcuts might be setup here (see Usage > Shortcuts in Readme)
    end,
  },

  {
    "folke/zen-mode.nvim",
    lazy = false,
  },

  -- {
  --   "github/copilot.vim",
  --   lazy = false,
  -- },

  -- {
  --   "zbirenbaum/copilot.lua",
  --   cmd = "Copilot",
  --   event = "InsertEnter",
  --   config = function()
  --     require("copilot").setup {}
  --   end,
  -- },

  -- {
  --   "zbirenbaum/copilot-cmp",
  --   lazy = false,
  --   config = function()
  --     require("copilot_cmp").setup()
  --   end,
  -- },
  --
  -- {
  --   "hrsh7th/nvim-cmp",
  --   opts = require("custom.configs.cmp").config,
  -- },

  -- {
  --   "CopilotC-Nvim/CopilotChat.nvim",
  --   lazy = false,
  --   branch = "canary",
  --   dependencies = {
  --     { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
  --     { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
  --   },
  --   opts = {
  --     debug = true, -- Enable debugging
  --     -- See Configuration section for rest
  --   },
  --   -- See Commands section for default commands if you want to lazy load on them
  -- },

  -- {
  --   "pmizio/typescript-tools.nvim",
  --   dependencies = { "nvim-lua/plenary.nvim", "neovim/nvim-lspconfig" },
  --   opts = {},
  --   ft = { "javascriptreact", "typescriptreact", "javascript", "typescript" },
  -- },
  -- {
  --   "olimorris/codecompanion.nvim",
  --   dependencies = {
  --     "j-hui/fidget.nvim",
  --     "nvim-lua/plenary.nvim",
  --     "nvim-treesitter/nvim-treesitter",
  --     "hrsh7th/nvim-cmp", -- Optional: For using slash commands and variables in the chat buffer
  --     "nvim-telescope/telescope.nvim", -- Optional: For using slash commands
  --     { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } }, -- Optional: For prettier markdown rendering
  --     { "stevearc/dressing.nvim", opts = {} }, -- Optional: Improves `vim.ui.select`
  --   },
  --   config = function()
  --     require("codecompanion").setup {
  --       adapters = {
  --         openai = function()
  --           return require("codecompanion.adapters").extend("openai", {
  --             schema = {
  --               model = {
  --                 default = "o3-mini-2025-01-31",
  --               },
  --             },
  --           })
  --         end,
  --       },
  --       strategies = {
  --         chat = {
  --           slash_commands = {
  --             ["file"] = {
  --               callback = "strategies.chat.slash_commands.file",
  --               description = "Select a file using Telescope",
  --               opts = {
  --                 provider = "telescope", -- Other options include 'default', 'mini_pick', 'fzf_lua', snacks
  --                 contains_code = true,
  --               },
  --             },
  --             ["buffer"] = {
  --               callback = "strategies.chat.slash_commands.buffer",
  --               description = "Select a file using Telescope",
  --               opts = {
  --                 provider = "telescope", -- Other options include 'default', 'mini_pick', 'fzf_lua', snacks
  --                 contains_code = true,
  --               },
  --             },
  --           },
  --           adapter = "openai",
  --         },
  --         inline = {
  --           adapter = "openai",
  --         },
  --       },
  --     }
  --   end,
  --   init = function()
  --     require("custom.configs.fidget"):init()
  --   end,
  --   lazy = false,
  -- },
  {
    "AdiY00/copy-tree.nvim",
    cmd = { "CopyTree", "SaveTree" },
    config = function()
      require("copy-tree").setup()
    end,
    -- Example keymap
    -- vim.keymap.set("n", "<leader>ct", "<cmd>CopyTree<cr>", { desc = "Copy project structure from current directory" }),
  },
  { "echasnovski/mini.diff", version = "*" },
  {
    "j-hui/fidget.nvim",
    lazy = false,
    opts = {},
  },
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*"! Never!
    opts = {
      -- behaviour = {
      --   enable_claude_text_editor_tool_mode = true,
      -- },
      -- add any opts here
      -- for example
      provider = "openai",
      openai = {
        endpoint = "https://api.openai.com/v1",
        model = "o3-mini-2025-01-31", -- your desired model (or use gpt-4o, etc.)
        timeout = 30000, -- Timeout in milliseconds, increase this for reasoning models
        temperature = 0,
        max_completion_tokens = 8192, -- Increase this to include reasoning tokens (for reasoning models)
        --reasoning_effort = "medium", -- low|medium|high, only used for reasoning models
      },
    },
    -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
      {
        -- support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Make sure to set this up properly if you have lazy=true
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
}

return plugins
