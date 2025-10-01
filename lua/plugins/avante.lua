return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*!" Never!
    debug = true,
    -- commit = "9008fc4f419062c5874614217541c5d73039c769",
    opts = {
      behaviour = {
        auto_suggestions = false, -- Experimental stage
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = false,
        minimize_diff = true, -- Whether to remove unchanged lines when applying a code block
        enable_token_counting = true, -- Whether to enable token counting. Default to true.
        auto_approve_tool_permissions = false, -- Default: show permission prompts for all tools
      },
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
        morph = {
          model = "auto",
        },
      },
      acp_providers = {
        ["gemini-cli"] = {
          command = "gemini",
          args = { "--experimental-acp" },
          env = {
            NODE_NO_WARNINGS = "1",
            -- GEMINI_API_KEY = os.getenv "GEMINI_API_KEY",
          },
        },
      },
      rag_service = {
        enabled = true,
        host_mount = "/home/kylix/Handtalk",
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
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "echasnovski/mini.pick", -- for file_selector provider mini.pick
      "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
      "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
      "ibhagwan/fzf-lua", -- for file_selector provider fzf
      "stevearc/dressing.nvim", -- for input provider dressing
      "folke/snacks.nvim", -- for input provider snacks
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- for providers='copilot'
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
