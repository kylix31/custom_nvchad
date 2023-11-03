---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
    ["<Esc>"] = { ":noh <CR>", "cancel highlights" },

    ["<leader>jt"] = { ":set ft=json <CR>", "set filetype to json" },
    ["<leader>jf"] = { ":%!jq .<CR>", "format json" },
    ["<leader>jc"] = { ":%!jq -c .<CR>", "compact json" },

    ["<leader>ta"] = { ":AerialToggle <CR>", "toggle aerial" },
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
