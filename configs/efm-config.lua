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

local stylelint = require "efmls-configs.linters.stylelint"
local markdownlint = require "efmls-configs.linters.markdownlint"
local yamllint = require "efmls-configs.linters.yamllint"

local eslint_d = require "efmls-configs.formatters.eslint_d"
local prettier_d = require "efmls-configs.formatters.prettier_d"
local terraform_fmt = require "efmls-configs.formatters.terraform_fmt"
-- local black = require "efmls-configs.formatters.black"

local adicional_languages = {
  -- "python",
  -- "go",
  "lua",
  "html",
}

local efm_languages = {
  css = { stylelint },
  scss = { stylelint },
  markdown = { markdownlint },
  yaml = { yamllint },
  typescript = { eslint_d, prettier_d },
  typescriptreact = { eslint_d, prettier_d },
  javascript = { eslint_d, prettier_d },
  javascriptreact = { eslint_d, prettier_d },
  terraform = { terraform_fmt },
  -- python = { black },
}

local M = {}

M.languages = vim.tbl_extend("force", default_languages, efm_languages)

M.filetypes = getKeysAsStrings(efm_languages, adicional_languages)

return M
