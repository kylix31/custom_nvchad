---@type MappingsTable
local M = {}

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
      "Close all buffers",
    },
  },
}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<Esc>"] = { ":noh <CR>", "cancel highlights" },

    ["<leader>jt"] = { ":set ft=json <CR>", "set filetype to json" },
    ["<leader>jf"] = { ":%!jq .<CR>", "format json" },
    ["<leader>jc"] = { ":%!jq -c .<CR>", "compact json" },
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

return M
