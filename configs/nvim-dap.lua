local dap, dapui, dapvirtualtext = require "dap", require "dapui", require "nvim-dap-virtual-text"
local M = {}

M.dap_ui = function()
  dapui.setup()

  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end
end

M.dap_virtual_text = function()
  dapvirtualtext.setup()
end

M.dap = function()
  dap.adapters.node2 = {
    type = "executable",
    command = "node",
    args = { os.getenv "HOME" .. "/dev/microsoft/vscode-node-debug2/out/src/nodeDebug.js" },
  }
  dap.configurations.typescript = {
    {
      -- name = "Launch",
      -- type = "node",
      -- request = "launch",
      -- program = "${file}",
      -- cwd = vim.fn.getcwd(),
      -- sourceMaps = true,
      -- protocol = "inspector",
      -- console = "integratedTerminal",
      name = "Docker: Attach to Node",
      type = "node2",
      request = "launch",
      port = 9229,
      remoteRoot = "/var/www/html",
      localRoot = "${workspaceFolder}",
      trace = true,
    },
  }
end

return M
