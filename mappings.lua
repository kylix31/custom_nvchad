local M = {}

M.fugitive = {
   n = {
      ["<leader>gh"] = { ":diffget //2 <CR>", "fugitive diffget 2" },
      ["<leader>gl"] = { ":diffget //3 <CR>", "fugitive diffget 3" },
      ["<leader>gs"] = { ":Git <CR>", "fugitive open" },
      ["<leader>gb"] = { ":Git blame <CR>", "fugitive blame" },
   },
}

M.json = {
   n = {
      ["<leader>jt"] = { ":set ft=json <CR>", "json set type" },
      ["<leader>jf"] = { ":%!jq .<CR>", "json format" },
      ["<leader>jc"] = { ":%!jq -c .<CR>", "json compac" },
   },
}

return M
