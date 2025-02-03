---@type MappingsTable
local M = {}

M.disabled = {
  n = {
    ["<leader>fm"] = "",
  },
}

M.nvterm = {
  plugin = true,

  t = {
    -- toggle in terminal mode
    ["<C-i>"] = {
      function()
        require("nvterm.terminal").toggle "float"
      end,
      "Toggle floating term",
    },

    ["<C-h>"] = {
      function()
        require("nvterm.terminal").toggle "horizontal"
      end,
      "Toggle horizontal term",
    },

    ["<C-v>"] = {
      function()
        require("nvterm.terminal").toggle "vertical"
      end,
      "Toggle vertical term",
    },
  },
}

M.tabufline = {
  plugin = true,

  n = {
    ["<leader>xa"] = {
      function()
        require("nvchad.tabufline").closeAllBufs()
      end,
      "Close all buffers",
    },
    ["<leader>xo"] = {
      function()
        require("nvchad.tabufline").closeOtherBufs()
      end,
      "Close all others buffers",
    },
  },
}

M.general = {
  n = {
    -- [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<Esc>"] = { ":noh <CR>", "cancel highlights" },

    ["<leader>jt"] = { ":set ft=json <CR>", "set filetype to json" },
    ["<leader>jf"] = { ":%!jq .<CR>", "format json" },
    ["<leader>jc"] = { ":%!jq -c .<CR>", "compact json" },

    ["sly"] = { '"+yy', "system line yank" },
    ["swy"] = { '"+yiw', "system word yank" },
  },

  v = {
    ["sy"] = { '"+y', "system yank" },
  },

  x = {
    ["<leader>ss"] = { '"zy<Cmd>Telescope live_grep<CR><C-r>z', "grep selected text" },
  },
}

M.aerial = {
  n = {
    ["<leader>ta"] = { ":AerialToggle <CR>", "toggle aerial" },
  },
}

M.trouble = {
  n = {
    ["<leader>tt"] = { ":TroubleToggle <CR>", "toggle trouble" },
  },
}

M.fugitive = {
  plugin = true,

  n = {
    ["<leader>gh"] = { ":diffget //2 <CR>", "git diff" },
    ["<leader>gl"] = { ":diffget //3 <CR>", "git diff" },
    ["<leader>gs"] = { ":Git <CR>", "git" },
    ["<leader>gb"] = { ":Git blame <CR>", "git blame" },
  },
}

M.dap = {
  plugin = true,

  n = {
    ["<F5>"] = {
      function()
        require("dap").continue()
      end,
      "dap continue",
    },
    ["<F10>"] = {
      function()
        require("dap").step_over()
      end,
      "dap step over",
    },
    ["<F11>"] = {
      function()
        require("dap").step_into()
      end,
      "dap step into",
    },
    ["<F12>"] = {
      function()
        require("dap").step_out()
      end,
      "dap step out",
    },
    ["<leader>b"] = {
      function()
        require("dap").toggle_breakpoint()
      end,
      "dap toggle breakpoint",
    },
  },
}

M.custom_telescope = {
  n = {
    ["<leader>fv"] = {
      ":Telescope file_browser path=%:p:h select_buffer=true <CR>",
      "telescope file_browser",
    },
  },
}

M.conform = {
  n = {
    ["<leader>fm"] = {
      function()
        require("conform").format { async = true, lsp_fallback = true }
      end,
      "conform format",
    },
  },
}

M.copilot_chat = {
  n = {
    ["<leader>cch"] = {
      function()
        local actions = require "CopilotChat.actions"
        require("CopilotChat.integrations.telescope").pick(actions.help_actions())
      end,
      "CopilotChat - Help actions",
    },

    ["<leader>ccp"] = {
      function()
        local actions = require "CopilotChat.actions"
        require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
      end,
      "CopilotChat - Prompt actions",
    },

    ["<leader>ccq"] = {
      function()
        local input = vim.fn.input "Quick Chat: "
        if input ~= "" then
          require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
        end
      end,
      "CopilotChat - Quick chat",
    },
  },

  v = {
    ["<leader>cch"] = {
      function()
        local actions = require "CopilotChat.actions"
        require("CopilotChat.integrations.telescope").pick(actions.help_actions())
      end,
      "CopilotChat - Help actions",
    },

    ["<leader>ccp"] = {
      function()
        local actions = require "CopilotChat.actions"
        require("CopilotChat.integrations.telescope").pick(actions.prompt_actions())
      end,
      "CopilotChat - Prompt actions",
    },

    ["<leader>ccq"] = {
      function()
        local input = vim.fn.input "Quick Chat: "
        if input ~= "" then
          require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
        end
      end,
      "CopilotChat - Quick chat",
    },
  },
}

M.codecompanion = {
  n = {
    ["<C-a>"] = {
      "<cmd>CodeCompanionActions<cr>",
      "Open the codecompanion chat",
    },
    ["<leader>a"] = { "<cmd>CodeCompanionChat Toggle<cr>", "Toggle codecompanion chat" },
  },
  v = {
    ["<C-a>"] = {
      "<cmd>CodeCompanionActions<cr>",
      "Open the codecompanion chat",
    },
    ["<leader>a"] = { "<cmd>CodeCompanionChat Toggle<cr>", "Toggle codecompanion chat" },
    ["ga"] = {
      "<cmd>CodeCompanionChat Add<cr>",
      "Use the codecompanion chat add",
    },
  },
}

return M
