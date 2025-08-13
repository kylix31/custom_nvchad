require "nvchad.autocmds"

-- Prevent .env grab lsp - see https://github.com/LazyVim/LazyVim/discussions/4027
local lsp_hacks = vim.api.nvim_create_augroup("LspHacks", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufReadPost" }, {
  group = lsp_hacks,
  pattern = ".env*",
  callback = function(e)
    vim.diagnostic.enable(false, { bufnr = e.buf })
  end,
})
