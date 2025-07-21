require("nvchad.configs.lspconfig").defaults()

local servers = {
  "html",
  "cssls",
  "ts_ls",
  -- "clangd",
  "eslint",
  "cssmodules_ls",
  "pyright",
  "tailwindcss",
  "yamlls",
  "jdtls",
  "lemminx",
  "sqlls",
  "terraformls",
  "prismals",
  -- "efm",
  "phpactor",
  "gopls",
  "taplo",
  "kotlin_language_server",
  "protols",
  "dockerls",
  "ruff",
  "bashls",
  -- "pylsp",
}

vim.lsp.enable(servers)

-- read :h vim.lsp.config for changing options of lsp servers
