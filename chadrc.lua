-- Just an example, supposed to be placed in /lua/custom/

-- remove this if you dont use custom.init.lua at all
-- require "custom"

local M = {}

-- make sure you maintain the structure of `core/default_config.lua` here,
-- example of changing theme:

M.ui = {
   theme = "tokyodark",
}

M.plugins = {
   user = require "custom.plugins",

   override = {
      ["nvim-treesitter/nvim-treesitter"] = {
         ensure_installed = {
            "html",
            "css",
            "javascript",
            "json",
            "json5",
            "php",
            "regex",
            "scss",
            "tsx",
            "lua",
            "python",
            "typescript",
         },
         autotag = { enable = true },
      },
   },
}

M.mappings = require "custom.mappings"

return M
