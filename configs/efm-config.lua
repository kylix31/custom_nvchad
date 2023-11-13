local function getKeysAsStrings(obj)
  local keys = {}
  for key, _ in pairs(obj) do
    table.insert(keys, tostring(key))
  end
  return keys
end

local eslint_d = require "efmls-configs.formatters.eslint_d"
local prettier_d = require "efmls-configs.formatters.prettier_d"
local stylua = require "efmls-configs.formatters.stylua"

local efmLanguages = {
  typescript = { eslint_d, prettier_d },
  javascript = { eslint_d, prettier_d },
  typescriptreact = { eslint_d, prettier_d },
  javascriptreact = { eslint_d, prettier_d },
  lua = { stylua },
}

local M = {}

M.languages = efmLanguages

M.filetypes = getKeysAsStrings(efmLanguages)

return M
