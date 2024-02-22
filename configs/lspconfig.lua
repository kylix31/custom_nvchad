local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities
local navic = require "nvim-navic"
local efm_config = require "custom.configs.efm-config"
local utils = require "core.utils"

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = {
  "html",
  "cssls",
  "tsserver",
  "clangd",
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
  "efm",
  "phpactor",
  "gopls",
  "taplo",
  "pylsp",
}

-- This function searches for a target value within an input array

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

local custom_on_attach_format = function(client, bufnr)
  require("lsp-format").on_attach(client, bufnr)

  utils.load_mappings("lspconfig", { buffer = bufnr })

  if client.server_capabilities.signatureHelpProvider then
    require("nvchad.signature").setup(client)
  end

  if not utils.load_config().ui.lsp_semantic_tokens and client.supports_method "textDocument/semanticTokens" then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

local default_setup = {
  on_attach = custom_on_attach,
  capabilities = capabilities,
}

for _, lsp in ipairs(servers) do
  local lsp_setup = default_setup

  if lsp == "html" then
    lsp_setup = {
      on_attach = on_attach,
      capabilities = capabilities,
      init_options = { provideFormatter = false },
    }
  elseif lsp == "efm" then
    lsp_setup = {
      on_attach = custom_on_attach_format,
      init_options = { documentFormatting = true, documentRangeFormatting = true },
      filetypes = efm_config.filetypes,
      settings = {
        rootMarkers = { ".git/" },
        languages = efm_config.languages,
      },
    }
  elseif lsp == "prismals" or lsp == "gopls" or lsp == "taplo" then
    lsp_setup = {
      on_attach = custom_on_attach_format,
      capabilities = capabilities,
    }
  elseif lsp == "pylsp" then
    lsp_setup = {
      on_attach = custom_on_attach_format,
      capabilities = capabilities,
      settings = {
        pylsp = {
          plugins = {
            autopep8 = {
              enabled = false,
            },
            rope_autoimport = {
              enabled = true,
            },
            isort = {
              enabled = true,
            },
          },
        },
      },
    }
  end

  lspconfig[lsp].setup(lsp_setup)
end
