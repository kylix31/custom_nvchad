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
    opts = {
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = "if_many",
          prefix = "●",
          -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
          -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
          -- prefix = "icons",
        },
        severity_sort = true,
        inlay_hints = {
          enabled = false,
        },
      },
    },
  },

  -- override plugin configs
  {
    "williamboman/mason.nvim",
    opts = overrides.mason,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = overrides.treesitter,
  },

  {
    "nvim-tree/nvim-tree.lua",
    opts = overrides.nvimtree,
  },

  -- Install a plugin
  {
    "max397574/better-escape.nvim",
    event = "InsertEnter",
    config = function()
      require("better_escape").setup()
    end,
  },

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
    cmd = "TroubleToggle",
  },

  {
    "metakirby5/codi.vim",
    cmd = "Codi",
  },

  {
    "windwp/nvim-ts-autotag",
    ft = { "typescriptreact", "javascriptreact", "markdown", "html", "php" },
    -- config = function()
    --   require("nvim-ts-autotag").setup()
    -- end,
  },

  {
    "andymass/vim-matchup",
    event = "CursorMoved",
    config = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end,
  },

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
      },
      {
        "theHamsta/nvim-dap-virtual-text",
        config = function()
          require("nvim-dap-virtual-text").setup()
        end,
      },
    },
  },

  -- {
  --   "JoosepAlviste/nvim-ts-context-commentstring",
  --   config = function()
  --     require("Comment").setup {
  --       pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
  --     }
  --   end,
  --   dependencies = { "numToStr/Comment.nvim" },
  --   ft = { "javascriptreact", "typescriptreact" },
  -- },

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
    config = function()
      require "custom.configs.nvim-ufo"
    end,
  },

  -- override cmp default config sources
  -- {
  --   "hrsh7th/nvim-cmp",
  --   opts = overrides.cmp,
  -- },
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      require "custom.configs.chatpgt"
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
  },

  {
    "mfussenegger/nvim-jdtls",
    ft = { "java" },
  },
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
    "lukas-reineke/lsp-format.nvim",
    dependencies = { "neovim/nvim-lspconfig" },
    config = function()
      require("lsp-format").setup {}
    end,
  },

  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    opts = require("custom.configs.conform").opts,
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

  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup {
        suggestion = { enabled = false },
        panel = { enabled = false },
      }
    end,
  },

  {
    "zbirenbaum/copilot-cmp",
    lazy = false,
    config = function()
      require("copilot_cmp").setup()
    end,
  },

  {
    "hrsh7th/nvim-cmp",
    opts = require("custom.configs.cmp").config,
  },

  {
    "CopilotC-Nvim/CopilotChat.nvim",
    lazy = false,
    branch = "canary",
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
      { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
    },
    opts = {
      debug = true, -- Enable debugging
      -- See Configuration section for rest
    },
    -- See Commands section for default commands if you want to lazy load on them
  },
}

return plugins
