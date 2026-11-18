local Config = require "sidekick.config"
local Util = require "sidekick.util"

--- External sidekick session backend for CLI agents running in herdr panes.
--- Registered next to zellij because `cli.mux.backend` only accepts the built-in names.
---@class sidekick.cli.muxer.Herdr: sidekick.cli.Session
---@field herdr_pane_id string
local M = {}
M.__index = M
M.external = true
M.priority = 10

---@param cmd string[]
---@return table?
local function api(cmd)
  local _, out = Util.exec(cmd, { notify = false })
  local ok, decoded = pcall(vim.json.decode, out or "", { luanil = { object = true, array = true } })
  return ok and type(decoded) == "table" and decoded.result or nil
end

---@return table[]
local function agents()
  local result = api { "herdr", "agent", "list" }
  return result and result.agents or {}
end

---@return sidekick.cli.session.State[]
function M.sessions()
  local tools, ret = Config.tools(), {}
  for _, agent in ipairs(agents()) do
    local tool = tools[agent.agent]
    if tool then
      ret[#ret + 1] = {
        id = "herdr " .. agent.pane_id,
        cwd = agent.foreground_cwd or agent.cwd,
        tool = tool,
        herdr_pane_id = agent.pane_id,
        mux_session = agent.workspace_id,
      }
    end
  end
  return ret
end

function M:is_running()
  return vim.iter(agents()):any(function(agent)
    return agent.pane_id == self.herdr_pane_id
  end)
end

--- Typed text or Enter would answer a pending permission prompt, so refuse while herdr reports `blocked`.
---@return boolean
function M:blocked()
  local result = api { "herdr", "agent", "get", self.herdr_pane_id }
  local blocked = result and result.agent and result.agent.agent_status == "blocked" or false
  if blocked then
    Util.warn(
      ("`%s` in herdr pane %s is waiting for an answer, nothing sent"):format(self.tool.name, self.herdr_pane_id)
    )
  end
  return blocked
end

---@param text string
function M:send(text)
  if not self:blocked() then
    Util.exec { "herdr", "pane", "send-text", self.herdr_pane_id, text }
  end
end

function M:submit()
  if not self:blocked() then
    Util.exec { "herdr", "pane", "send-keys", self.herdr_pane_id, "enter" }
  end
end

return M
