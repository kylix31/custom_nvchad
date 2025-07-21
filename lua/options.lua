-- Load NvChad default options
require "nvchad.options"

-- BASIC VIM OPTIONS --
local opt = vim.opt
local g = vim.g

opt.linebreak = true         -- Wrap lines at convenient points for readability
opt.wrap = true              -- Enable soft line wrapping
opt.hlsearch = false         -- Disable persistent search highlighting
opt.incsearch = true         -- Highlight matches as you type the search
opt.clipboard = "unnamed"   -- Use system clipboard for copy/paste
opt.updatetime = 100         -- Reduce delay for CursorHold and swap file events
vim.o.autoread = true        -- Reload file automatically if changed externally
vim.wo.relativenumber = true -- Show relative line numbers in window

g.skip_ts_context_commentstring_module = true -- Disable Treesitter context commentstring module

-- PLUGIN & FEATURE-SPECIFIC OPTIONS --

-- UFO: Enhanced Folding
vim.o.foldcolumn = "1"         -- Show foldcolumn
vim.o.foldlevel = 99           -- Set high foldlevel to open most folds by default
vim.o.foldlevelstart = 99      -- Start with high foldlevel
vim.o.foldenable = true        -- Enable folding

-- Treesitter: Syntax-based Folding
vim.wo.foldmethod = "expr"                   -- Use expression folding
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Treesitter fold expression

-- PERFORMANCE
vim.loader.enable(false)       -- Disable experimental Lua loader for stability

-- Uncomment below for customizations:
-- local o = vim.o -- Enable this for advanced cursorline options
-- o.cursorlineopt ='both' -- Enable both cursorline highlight modes
-- local autocmd = vim.api.nvim_create_autocmd
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
