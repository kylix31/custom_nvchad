local dap, dapui, dapvirtualtext = require "dap", require "dapui", require "nvim-dap-virtual-text"
local M = {}

M.dap_ui = function()
  dapui.setup()

  dap.listeners.before.attach.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.launch.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
  end
  dap.listeners.before.event_exited.dapui_config = function()
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
      command = "js-debug-dap",
      -- 💀 Make sure to update this path to point to your installation
      args = { "${port}" },
    },
  }

  dap.configurations.typescript = {
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
      name = "Attach to process",
      type = "node2",
      request = "attach",
      processId = require("dap.utils").pick_process,
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

  dap.configurations.python = {
    {
      -- Required attributes by nvim-dap:
      type = "python", -- links this configuration to the nvim-dap-python adapter
      request = "launch",
      name = "Launch FastAPI (general)",

      -- Launch uvicorn as a module:
      module = "uvicorn",
      args = {
        "main:app",
        "--host",
        "0.0.0.0",
        "--port",
        "8000",
        -- Do not use "--reload" when debugging; reloading spawns a child process which
        -- usually prevents the debugger from hitting breakpoints.
      },
      -- Set the working directory (adjust if needed)
      cwd = vim.fn.getcwd(),

      -- Optional: Specify which terminal to use:
      -- console = "integratedTerminal",

      -- (Optional) If you want to debug code in subprocesses:
      -- subProcess = true,

      -- (Optional) Set 'justMyCode' to false if you need to step into library code:
      -- justMyCode = false,
    },
  }

  -- Ruby adapter setup (must be done before configurations)
  require("dap-ruby").setup()

  dap.configurations.ruby = {
    {
      type = "ruby",
      name = "Attach to Sidekiq (Docker Whisper)",
      request = "attach",
      port = 38698,
      host = "127.0.0.1",
      waiting = 0, -- Don't wait for rdbg to launch (it's already running in Docker)
      options = { source_filetype = "ruby" },
      -- localfsMap is rdbg-specific: maps container paths to host paths
      -- Format: "/container_path:/host_path" (rdbg ignores localRoot/remoteRoot)
      localfsMap = "/app:" .. vim.fn.getcwd(),
    },
  }
end

return M
