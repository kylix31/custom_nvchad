local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local navic = require "nvim-navic"

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = {
  "html",
  "cssls",
  "tsserver",
  "clangd",
  "eslint",
  "cssmodules_ls",
  "pylsp",
  "tailwindcss",
  "phpactor",
  "yamlls",
  "jdtls",
  "lemminx",
  "sqlls",
  "terraform_lsp",
  "prismals",
  "bashls",
}

-- capabilities.textDocument.foldingRange = {
--   dynamicRegistration = false,
--   lineFoldingOnly = true,
-- }

local custom_on_attach = function(client, bufnr)
  if client.server_capabilities["documentSymbolProvider"] then
    navic.attach(client, bufnr)
  end

  on_attach(client, bufnr)
end

for _, lsp in ipairs(servers) do
  if lsp == "html" then
    lspconfig[lsp].setup {
      on_attach = on_attach,
      capabilities = capabilities,
      init_options = {
        provideFormatter = false,
      },
    }
  else
    lspconfig[lsp].setup {
      on_attach = custom_on_attach,
      capabilities = capabilities,
    }
  end
end

--
-- lspconfig.pyright.setup { blabla}
