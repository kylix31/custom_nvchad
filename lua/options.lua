-- Load NvChad default options
require "nvchad.options"

-- BASIC VIM OPTIONS --
local opt = vim.opt
local g = vim.g
local o = vim.o
local wo = vim.wo
local api = vim.api

opt.linebreak = true -- Wrap lines at convenient points for readability
opt.wrap = true -- Enable soft line wrapping
opt.hlsearch = false -- Disable persistent search highlighting
opt.incsearch = true -- Highlight matches as you type the search
opt.clipboard = "unnamed" -- Use system clipboard for copy/paste
opt.updatetime = 100 -- Reduce delay for CursorHold and swap file events
o.autoread = true -- Reload file automatically if changed externally
wo.relativenumber = true -- Show relative line numbers in window
opt.swapfile = false

opt.scrolloff = 8

g.skip_ts_context_commentstring_module = true -- Disable Treesitter context commentstring module

-- PLUGIN & FEATURE-SPECIFIC OPTIONS --

-- UFO: Enhanced Folding
o.foldcolumn = "1" -- Show foldcolumn
o.foldlevel = 99 -- Set high foldlevel to open most folds by default
o.foldlevelstart = 99 -- Start with high foldlevel
-- o.foldenable = true -- Enable folding

-- Treesitter: Syntax-based Folding
wo.foldmethod = "expr" -- Use expression folding
wo.foldexpr = "v:lua.vim.treesitter.foldexpr()" -- Treesitter fold expression
api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client:supports_method "textDocument/foldingRange" then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldexpr = "v:lua.vim.lsp.foldexpr()"
    end
  end,
})

-- Conform async format
api.nvim_create_user_command("Format", function(args)
  local range = nil
  if args.count ~= -1 then
    local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
    range = {
      start = { args.line1, 0 },
      ["end"] = { args.line2, end_line:len() },
    }
  end
  require("conform").format { async = true, lsp_format = "fallback", range = range }
end, { range = true })

-- Disable auto format for conform
api.nvim_create_user_command("FormatDisable", function(args)
  if args.bang then
    -- FormatDisable! will disable formatting just for this buffer
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = "Disable autoformat-on-save",
  bang = true,
})
vim.api.nvim_create_user_command("FormatEnable", function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = "Re-enable autoformat-on-save",
})

-- Uncomment below for customizations:
-- local o = vim.o -- Enable this for advanced cursorline options
-- o.cursorlineopt ='both' -- Enable both cursorline highlight modes
-- local autocmd = vim.api.nvim_create_autocmd
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
