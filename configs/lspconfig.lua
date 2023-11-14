local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local navic = require "nvim-navic"
local efm_config = require "custom.configs.efm-config"

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
  "efm",
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

local custom_prisma_on_attach = function(client, bufnr)
  require("lsp-format").on_attach(client, bufnr)

  custom_on_attach(client, bufnr)
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
  elseif lsp == "efm" then
    lspconfig[lsp].setup {
      on_attach = require("lsp-format").on_attach,
      init_options = { documentFormatting = true },
      filetypes = efm_config.filetypes,
      settings = {
        rootMarkers = { ".git/" },
        languages = efm_config.languages,
      },
    }
  elseif lsp == "prismals" then
    lspconfig[lsp].setup {
      on_attach = custom_prisma_on_attach,
      capabilities = capabilities,
    }
  else
    lspconfig[lsp].setup {
      on_attach = custom_on_attach,
      capabilities = capabilities,
    }
  end
end
