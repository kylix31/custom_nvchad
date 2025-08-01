require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- Fugitive
map("n", "<leader>gh", ":diffget //2 <CR>", { desc = "git diff" })
map("n", "<leader>gl", ":diffget //3 <CR>", { desc = "git diff" })
map("n", "<leader>gs", ":Git <CR>", { desc = "git" })
map("n", "<leader>gb", ":Git blame <CR>", { desc = "git blame" })

-- DAP mappings
map("n", "<F5>", function()
  require("dap").continue()
end, { desc = "dap continue" })
map("n", "<F10>", function()
  require("dap").step_over()
end, { desc = "dap step over" })
map("n", "<F11>", function()
  require("dap").step_into()
end, { desc = "dap step into" })
map("n", "<F12>", function()
  require("dap").step_out()
end, { desc = "dap step out" })
map("n", "<leader>b", function()
  require("dap").toggle_breakpoint()
end, { desc = "dap toggle breakpoint" })

--General mappings
map("n", "<Esc>", ":noh <CR>", { desc = "cancel highlights" })
map("n", "<leader>jt", ":set ft=json <CR>", { desc = "set filetype to json" })
map("n", "<leader>jf", ":%!jq .<CR>", { desc = "format json" })
map("n", "<leader>jc", ":%!jq -c .<CR>", { desc = "compact json" })
map("n", "<leader>yt", ":set ft=yaml <CR>", { desc = "set filetype to yaml" })
map("n", "sly", '"+yy', { desc = "system line yank" })
map("n", "swy", '"+yiw', { desc = "system word yank" })
map("v", "sy", '"+y', { desc = "system yank" })
map("x", "<leader>ss", '"zy<Cmd>Telescope live_grep<CR><C-r>z', { desc = "grep selected text" })
--
-- Trouble mappings
map("n", "<leader>tt", ":TroubleToggle <CR>", { desc = "toggle trouble" })

-- LSP
map("n", "<leader>ls", function()
  vim.diagnostic.open_float()
end, { desc = "LSP signature help" })
map("n", "<leader>ca", function()
  vim.lsp.buf.code_action()
end, { desc = "LSP signature help" })

-- Buffer management
map("n", "<leader>xa", function()
  require("nvchad.tabufline").closeAllBufs(true)
end, { desc = "Close all buffers" })
map("n", "<leader>xo", function()
  require("nvchad.tabufline").closeAllBufs(false)
end, { desc = "Close all other buffers" })

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
