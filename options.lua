local opt = vim.opt
local g = vim.g

opt.scrolloff = 8
opt.relativenumber = true

g.vimspector_enable_mappings = "HUMAN"

opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevelstart = 99
