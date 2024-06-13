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
local hadolint = require "efmls-configs.linters.hadolint"

local eslint_d = require "efmls-configs.formatters.eslint_d"
local prettier_d = require "efmls-configs.formatters.prettier_d"
local prettier = require "efmls-configs.formatters.prettier"
local terraform_fmt = require "efmls-configs.formatters.terraform_fmt"
-- local autopep8 = require "efmls-configs.formatters.autopep8"
local yapf = require "efmls-configs.formatters.yapf"
local isort = require "efmls-configs.formatters.isort"

local adicional_languages = {
  "lua",
  "html",
}

local efm_languages = {
  css = { stylelint, prettier_d },
  scss = { stylelint, prettier_d },
  markdown = { markdownlint },
  yaml = { yamllint, prettier },
  typescript = { eslint_d, prettier_d },
  typescriptreact = { eslint_d, prettier_d },
  javascript = { eslint_d, prettier_d },
  javascriptreact = { eslint_d, prettier_d },
  terraform = { terraform_fmt },
  python = { yapf, isort },
  dockerfile = { hadolint },
}

local M = {}

M.languages = vim.tbl_extend("force", default_languages, efm_languages)

M.filetypes = getKeysAsStrings(efm_languages, adicional_languages)

return M
