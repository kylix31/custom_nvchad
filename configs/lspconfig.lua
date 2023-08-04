local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

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
}

capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true,
}

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
      on_attach = on_attach,
      capabilities = capabilities,
    }
  end
end

require("ufo").setup()
--
-- lspconfig.pyright.setup { blabla}
