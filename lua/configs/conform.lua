local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    -- css = { "prettier" },
    -- html = { "prettier" },
    css = { "stylelint", "prettierd" },
    scss = { "stylelint", "prettierd" },
    markdown = { "markdownlint", "mdformat" },
    yaml = { "yamlfix", "prettierd" },
    typescript = { "prettierd", "eslint_d" },
    typescriptreact = { "prettierd", "eslint_d" },
    javascript = { "prettierd", "eslint_d" },
    javascriptreact = { "prettierd", "eslint_d" },
    terraform = { "terraform_fmt" },
    python = { "ruff_format", "ruff_organize_imports", "ruff_fix" },
    sh = { "shellcheck", "shfmt" },
    dockerfile = { "hadolint" },
    proto = { "buf" },
  },
  formatters = {
    hadolint = {
      -- Reads from stdin, outputs fixes to stdout
      command = "hadolint --formatter diff -",
    },
  },
  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 1000,
    lsp_format = "fallback",
  },
}

return options
