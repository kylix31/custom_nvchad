local opt = vim.opt
local lsp = vim.lsp

-- local autocmd = vim.api.nvim_create_autocmd

opt.linebreak = true
opt.wrap = true

opt.hlsearch = false
opt.incsearch = true
-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })

lsp.set_log_level "debug"
