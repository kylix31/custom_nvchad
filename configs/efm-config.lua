local function getKeysAsStrings(obj, additionalStrings)
  local keys = {}
  for key, _ in pairs(obj) do
    table.insert(keys, tostring(key))
  end
  if additionalStrings then
    for _, str in ipairs(additionalStrings) do
      table.insert(keys, str)
    end
  end
  return keys
end

local default_languages = require("efmls-configs.defaults").languages()

local eslint_d = require "efmls-configs.formatters.eslint_d"
local prettier_d = require "efmls-configs.formatters.prettier_d"
local beautysh = require "efmls-configs.formatters.beautysh"

local stylelint = require "efmls-configs.linters.stylelint"

local adicional_languages = {
  "python",
  "php",
  "go",
  "lua",
  "prisma",
}

local efm_languages = {
  typescript = { eslint_d, prettier_d },
  javascript = { eslint_d, prettier_d },
  typescriptreact = { eslint_d, prettier_d },
  javascriptreact = { eslint_d, prettier_d },
  sh = { beautysh },
  zsh = { beautysh },
  css = { stylelint, prettier_d },
  scss = { stylelint, prettier_d },
}

local M = {}

M.languages = vim.tbl_extend("force", default_languages, efm_languages)

M.filetypes = getKeysAsStrings(efm_languages, adicional_languages)

return M
