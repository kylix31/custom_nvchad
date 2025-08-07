return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    version = false, -- Never set this value to "*!" Never!
    debug = true,
    -- commit = "f4f82a09d749da0bcd736600e621b0ed2a089635",
    opts = {
      behaviour = {
        enable_fastapply = true, -- Enable Fast Apply feature
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
      rag_service = {
        enabled = false, -- Enables the RAG service
        host_mount = os.getenv "HOME", -- Host mount path for the rag service (Docker will mount this path)
        runner = "docker", -- Runner for the RAG service (can use docker or nix)
        llm = { -- Language Model (LLM) configuration for RAG service
          provider = "openai", -- LLM provider
          endpoint = "https://api.openai.com/v1", -- LLM API endpoint
          api_key = "OPENAI_API_KEY", -- Environment variable name for the LLM API key
          model = "gpt-4o-mini", -- LLM model name
          extra = nil, -- Additional configuration options for LLM
        },
        embed = { -- Embedding model configuration for RAG service
          provider = "openai", -- Embedding provider
          endpoint = "https://api.openai.com/v1", -- Embedding API endpoint
          api_key = "OPENAI_API_KEY", -- Environment variable name for the embedding API key
          model = "text-embedding-3-large", -- Embedding model name
          extra = nil, -- Additional configuration options for the embedding model
        },
        docker_extra_args = "", -- Extra arguments to pass to the docker command
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
