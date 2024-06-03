local opt = vim.opt

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

opt.clipboard = "unnamed"

vim.g.skip_ts_context_commentstring_module = true
