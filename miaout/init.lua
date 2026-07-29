local Log = require("miaout.log") ---@class Log
local Config = require("miaout.config") ---@class MiaoutConfig

local WindowManager = require("miaout.window.manager") ---@class WindowManager
local WindowLogic = require("miaout.window.logic")  ---@class WindowLogic
local WindowFacade = require("miaout.window.facade") ---@class WindowFacade

local WorkspaceManager = require("miaout.workspace.manager") ---@class WorkspaceManager
local WorkspaceLogic = require("miaout.workspace.logic")  ---@class WorkspaceLogic
local WorkspaceFacade = require("miaout.workspace.facade") ---@class WorkspaceFacade


local Miaout = {}

---@return Modules
function Miaout.Init()
    local config = Config.new()
    local log = Log.new(config)

    local workspaceManager = WorkspaceManager.new()
    local workspaceLogic = WorkspaceLogic.new(log, config, workspaceManager)
    local workspaceFacade = WorkspaceFacade.new(log, workspaceLogic, workspaceManager)

    local windowManager = WindowManager.new()
    local windowLogic = WindowLogic.new(log, config, windowManager, workspaceManager)
    local windowFacade = WindowFacade.new(log, windowLogic, windowManager)

    local Modules = {}

    Modules.window = windowFacade
    Modules.workspace = workspaceFacade

    return Modules
end

return Miaout