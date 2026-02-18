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
    vue = { "prettierd", "eslint_d" },
    terraform = { "terraform_fmt" },
    python = { "ruff_format", "ruff_organize_imports", "ruff_fix" },
    sh = { "shellcheck", "shfmt" },
    dockerfile = { "hadolint" },
    proto = { "buf" },
    -- ruby = { "rubocop" },
    json = { "jq" },
  },
  formatters = {
    hadolint = {
      -- Reads from stdin, outputs fixes to stdout
      command = "hadolint --formatter diff -",
    },
    -- rubocop = {
    --   -- Rubocop can be slow on large files, so we extend the timeout
    --   timeout_ms = 5000,
    -- },
  },
  format_on_save = function(bufnr)
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    return { timeout_ms = 500, lsp_format = "fallback" }
  end,
}

return options
