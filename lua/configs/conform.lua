local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    -- css = { "prettier" },
    -- html = { "prettier" },
    css = { "stylelint", "prettierd" },
    scss = { "stylelint", "prettierd" },
    markdown = { "markdownlint", "mdformat" },
    yaml = { "yamlfix", "prettierd" },
    typescript = { "eslint_d", "prettierd" },
    typescriptreact = { "eslint_d", "prettierd" },
    javascript = { "eslint_d", "prettierd" },
    javascriptreact = { "eslint_d", "prettierd" },
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
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
