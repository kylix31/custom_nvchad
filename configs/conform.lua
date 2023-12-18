local M = {}
local slow_format_filetypes = {}

local formatters = {
  -- lua = { "stylua" },
  -- typescript = { "eslint_d", "prettierd" },
  -- javascript = { "eslint_d", "prettierd" },
  -- typescriptreact = { "prettierd", "eslint_d" },
  -- javascriptreact = { "eslint_d", "prettierd" },
  -- sh = { "beautysh" },
  -- zsh = { "beautysh" },
  -- css = { "prettierd" },
  -- scss = { "prettierd" },
  -- markdown = { "mdformat" },
  -- yaml = { "prettierd" },
  -- terraform = { "terraform_fmt" },
  php = { "php_cs_fixer" },
  -- html = { "prettierd" },
}

M.opts = {
  formatters_by_ft = formatters,
  format_on_save = function(bufnr)
    if slow_format_filetypes[vim.bo[bufnr].filetype] then
      return
    end
    local function on_format(err)
      if err and err:match "timeout$" then
        slow_format_filetypes[vim.bo[bufnr].filetype] = true
      end
    end

    return { timeout_ms = 200, lsp_fallback = true }, on_format
  end,

  format_after_save = function(bufnr)
    if not slow_format_filetypes[vim.bo[bufnr].filetype] then
      return
    end
    return { lsp_fallback = true }
  end,
  init = function()
    vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
  end,
}

return M
