local Workspace = require("miaout.workspace.workspace") ---@class Workspace
local MonitorUtils = require("miaout.utils.monitor") ---@class MonitorUtils
local WindowUtils = require("miaout.utils.window") ---@class WindowUtils
local WorkspaceUtils = require("miaout.utils.workspace") ---@class WorkspaceUtils


-- TODO
-- GetWorkspace (workspace miaout obj)

---@class WindowLogic
local WindowLogic = {}
WindowLogic.__index = WindowLogic

function WindowLogic.new(log, config, windowManager, workspaceManager)
    local self = setmetatable({}, WindowLogic)

    self.config = config
    self.log = log
    self.windowManager = windowManager
    self.workspaceManager = workspaceManager

    return self
end

function WindowLogic:MoveToWorkspace(window, func)
    local hlWindow = window:GetHlObject()

    hl.notification.create({text = self.config.notifications.prefix, timeout = 3000})

    local currentWorkspace = self.workspaceManager:GetOrNewWorkspace(hlWindow.workspace)

    local nextHlWorkspace = func(WorkspaceUtils, currentWorkspace, hlWindow.monitor)
    if not nextHlWorkspace then return end

    local nextWorkspace = self.workspaceManager:GetOrNewWorkspace(nextHlWorkspace)

    window:MoveToWorkspace(nextWorkspace)
    window:Focus()
end

function WindowLogic:MoveToNextWorkspace(window)
    self:MoveToWorkspace(window, WorkspaceUtils.GetNextWorkspace)
end

function WindowLogic:MoveToPrevWorkspace(window)
    self:MoveToWorkspace(window, WorkspaceUtils.GetPrevWorkspace)
end

function WindowLogic:MoveToNextMonitorWorkspace(window)
    self:MoveToWorkspace(window, WorkspaceUtils.GetNextMonitorWorkspace)
end

function WindowLogic:MoveToPrevMonitorWorkspace(window)
    self:MoveToWorkspace(window, WorkspaceUtils.GetPrevMonitorWorkspace)
end

function WindowLogic:MoveToMonitor(window, monitor)
    if not monitor then
        self.log:Error("Unable to find the next monitor")
        return
    end

    window:MoveToMonitor(monitor)
    window:Focus()
end

function WindowLogic:MoveToNextMonitor(window)
    local nextMonitor = MonitorUtils:GetNextMonitor()

    self:MoveToMonitor(window, nextMonitor)
end

function WindowLogic:MoveToPrevMonitor(window)
    local prevMonitor = MonitorUtils:GetPrevMonitor()

    self:MoveToMonitor(window, prevMonitor)
end

function WindowLogic:ChangeScreenState(window, state, toggle)
    if toggle then
        local fullscreenState = window:GetFullscreenState()

        if WindowUtils.CompareFullscreenState(fullscreenState, state) then
            window:SetFullscreenState(toggle)
            return
        end
    end

    window:SetFullscreenState(state)
    window:UpdateState()
end

function WindowLogic:SetScreenDefault(window)
    self:ChangeScreenState(window, self.config.window.default)
end

function WindowLogic:Maximise(window)
    self:ChangeScreenState(window, self.config.window.maximise, self.config.window.default)
end

function WindowLogic:SetFullscreen(window)
    self:ChangeScreenState(window, self.config.window.fullscreen, self.config.window.default)
end

function WindowLogic:SwapWindows(activeWindow, lastWindow)
    activeWindow:SwapWindow(lastWindow)
    lastWindow:UpdateState()
    activeWindow:UpdateState()
end

function WindowLogic:ReSize(window, ratio)
    local size = window:GetHlObject().size

    local x = math.floor(size.x * ratio)
    local y = math.floor(size.y * ratio)

    window:ReSize(x, y)
end

function WindowLogic:UpScale(window)
    local ratio = self.config.window.upScaleRatio
    self:ReSize(window, ratio)
end

function WindowLogic:DownScale(window)
    local ratio = self.config.window.downScaleRatio
    self:ReSize(window, ratio)
end


return WindowLogic



