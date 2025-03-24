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
  dap.adapters["pwa-node"] = {
    type = "server",
    host = "localhost",
    port = "${port}",
    executable = {
      command = "node",
      -- 💀 Make sure to update this path to point to your installation
      args = { "/usr/bin/js-debug-dap", "${port}" },
    },
  }
  dap.configurations.typescript = {
    {
      name = "Launch TypeScript with ts-node",
      type = "pwa-node",
      request = "launch",
      runtimeArgs = { "-r", "ts-node/register" },
      args = { "${file}" },
      sourceMaps = true,
      cwd = vim.fn.getcwd(),
      protocol = "inspector",
      resolveSourceMapLocations = {
        "${workspaceFolder}/**",
        "!**/node_modules/**",
      },
    },
    {
      name = "Docker: Attach to Node on Docker",
      type = "node2",
      request = "launch",
      port = 9229,
      remoteRoot = "/var/www/html",
      localRoot = "${workspaceFolder}",
      trace = true,
    },
    {
      name = "Launch Compiled JavaScript",
      type = "pwa-node",
      request = "launch",
      program = "${file}",
      cwd = "${workspaceFolder}",
      sourceMaps = true,
      -- resolveSourceMapLocations = {
      --   "${workspaceFolder}/**",
      --   "!**/node_modules/**",
      -- },
    },
  }
  dap.configurations.javascript = {
    {
      name = "Launch file",
      type = "pwa-node",
      request = "launch",
      program = "${file}",
      cwd = "${workspaceFolder}",
    },
  }
end

return M
