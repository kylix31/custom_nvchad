local M = {}

M.setup_lsp = function(attach, capabilities)
   local lspconfig = require "lspconfig"

   -- lspservers with default config
   local servers = {
      "html",
      "cssls",
      "tsserver",
      "pylsp",
      "eslint",
      "prosemd_lsp",
      "jsonls",
      "graphql",
      "dockerls",
      "cssmodules_ls",
      "intelephense",
      "sqlls",
   }

   for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup {
         on_attach = attach,
         capabilities = capabilities,
      }
   end
end

return M
