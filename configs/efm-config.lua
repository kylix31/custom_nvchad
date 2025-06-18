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
-- local hadolint = require "efmls-configs.linters.hadolint"
local buf_lint = require "efmls-configs.linters.buf"
-- local pylint = require "efmls-configs.linters.pylint"
local ruff_lint = require "efmls-configs.linters.ruff"
local shellcheck = require "efmls-configs.linters.shellcheck"

local eslint_d = require "efmls-configs.formatters.eslint_d"
local prettier_d = require "efmls-configs.formatters.prettier_d"
local prettier = require "efmls-configs.formatters.prettier"
local terraform_fmt = require "efmls-configs.formatters.terraform_fmt"
-- local autopep8 = require "efmls-configs.formatters.autopep8"
-- local yapf = require("efmls-configs.formatters.yapf")
local stylua = require "efmls-configs.formatters.stylua"
local buf_formatter = require "efmls-configs.formatters.buf"
-- local cbfmt = require "efmls-configs.formatters.cbfmt"
local mdformat = require "efmls-configs.formatters.mdformat"
local ruff = require "efmls-configs.formatters.ruff"
local ruff_sort = require "efmls-configs.formatters.ruff_sort"
-- local beautysh = require "efmls-configs.formatters.beautysh"
local shfmt = require "efmls-configs.formatters.shfmt"
-- local php_cs_fixer = require "efmls-configs.formatters.php_cs_fixer"
-- local php_cs_fixer = require "efmls-configs.formatters.php_cs_fixer"
-- local djlint = require "efmls-configs.formatters.djlint"

local adicional_languages = {
  "lua",
  "html",
  "php",
}

local efm_languages = {
  css = { stylelint, prettier_d },
  scss = { stylelint, prettier_d },
  markdown = { markdownlint, mdformat },
  yaml = { yamllint, prettier },
  typescript = { eslint_d, prettier_d },
  typescriptreact = { eslint_d, prettier_d },
  javascript = { eslint_d, prettier_d },
  javascriptreact = { eslint_d, prettier_d },
  terraform = { terraform_fmt },
  python = { ruff, ruff_sort, ruff_lint },
  sh = { shellcheck, shfmt },
  -- dockerfile = { hadolint },
  lua = { stylua },
  proto = { buf_formatter, buf_lint },
  -- php = { php_cs_fixer },
}

local M = {}

M.languages = vim.tbl_extend("force", default_languages, efm_languages)

M.filetypes = getKeysAsStrings(efm_languages, adicional_languages)

return M
