return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*!" Never!
    debug = true,
    -- commit = "ae06698c307f09dd979f4094458b16e12ab72351",
    opts = {
      -- System prompt using mcphub if available
      system_prompt = function()
        local hub = require("mcphub").get_hub_instance()
        return hub and hub:get_active_servers_prompt() or ""
      end,
      -- Custom tools using mcphub extension (function form to avoid early require)
      custom_tools = function()
        return {
          require("mcphub.extensions.avante").mcp_tool(),
        }
      end,
      windows = {
        input = {
          height = 14,
        },
      },
      provider = "copilot",
      providers = {
        copilot = {
          model = "gpt-4.1",
        },
      },
      rag_service = {
        enabled = false,
        host_mount = os.getenv "HOME",
        runner = "docker",
        llm = {
          provider = "ollama",
          endpoint = "http://172.17.0.1:11434",
          api_key = "",
          model = "llama2",
          extra = nil,
        },
        embed = {
          provider = "ollama",
          endpoint = "http://172.17.0.1:11434",
          api_key = "",
          model = "nomic-embed-text",
          extra = {
            embed_batch_size = 10,
          },
        },
      },
      --[[
      behaviour = {
        enable_claude_text_editor_tool_mode = true,
      },
      --]]
      -- Add additional options here
    },

    build = "make",
    -- For Windows: build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"

    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      -- Optional dependencies for file selector and completion
      "echasnovski/mini.pick",
      "nvim-telescope/telescope.nvim",
      "hrsh7th/nvim-cmp",
      "ibhagwan/fzf-lua",
      "nvim-tree/nvim-web-devicons",
      "zbirenbaum/copilot.lua",
      -- Image pasting support
      {
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            use_absolute_path = true,
          },
        },
      },
      -- MCPHub integration
      {
        "ravitemer/mcphub.nvim",
        dependencies = {
          "nvim-lua/plenary.nvim",
        },
        -- build = "npm install -g mcp-hub@latest",
        config = function()
          require("mcphub").setup {
            extensions = {
              avante = {
                make_slash_commands = true,
              },
            },
          }
        end,
      },
      -- Markdown rendering support
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
}
