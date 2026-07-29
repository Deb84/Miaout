local Workspace = require("miaout.workspace.workspace") ---@class Workspace
local MonitorUtils = require("miaout.utils.monitor") ---@class MonitorUtils
local LayoutUtils = require("miaout.utils.layout") ---@class LayoutUtils


---@class WorkspaceLogic
local WorkspaceLogic = {}
WorkspaceLogic.__index = WorkspaceLogic

function WorkspaceLogic.new(log, config, manager)
    local self = setmetatable({}, WorkspaceLogic)

    self.config = config
    self.log = log
    self.manager = manager

    return self
end

function WorkspaceLogic:NewWorkspace()
    local workspacesLen = #hl.get_workspaces()
    self:SwitchToWorkspace(workspacesLen + 1)
end

function WorkspaceLogic:SwitchToWorkspace(workspaceRef)
    if getmetatable(workspaceRef) == Workspace then
        ---@cast workspaceRef Workspace
        workspaceRef:Focus()
    else
        ---@cast workspaceRef HL.WorkspaceSelector
        hl.dispatch(hl.dsp.focus({workspace = workspaceRef}))
    end
end

function WorkspaceLogic:NextWorkspace()
    self:SwitchToWorkspace(self.config.workspace.nextWorkspaceSelector)
end

function WorkspaceLogic:PrevWorkspace()
    self:SwitchToWorkspace(self.config.workspace.prevWorkspaceSelector)
end

function WorkspaceLogic:NextMonitorWorkspace()
    self:SwitchToWorkspace(self.config.workspace.nextMonitorWorkspaceSelector)
end

function WorkspaceLogic:PrevMonitorWorkspace()
    self:SwitchToWorkspace(self.config.workspace.prevMonitorWorkspaceSelector)
end

function WorkspaceLogic:MoveToMonitor(workspace, monitor)
    if not monitor then
        self.log:Error("Unable to find the next monitor")
        return
    end

    workspace:MoveToMonitor(monitor)
    workspace:Focus()
end

function WorkspaceLogic:MoveToNextMonitor(workspace)
    local nextMonitor = MonitorUtils:GetNextMonitor()

    self:MoveToMonitor(workspace, nextMonitor)
end

function WorkspaceLogic:MoveToPrevMonitor(workspace)
    local prevMonitor = MonitorUtils:GetPrevMonitor()

    self:MoveToMonitor(workspace, prevMonitor)
end

function WorkspaceLogic:ChangeLayout(workspace, func)
    local layouts = self.config.workspace.layouts
    local layout = workspace:GetLayout()

    local nextLayout = func(layouts, layout)
    if not nextLayout then return end

    workspace:ChangeLayout(nextLayout)
    workspace:LoadState()
end

function WorkspaceLogic:NextLayout(workspace)
    self:ChangeLayout(workspace, function (layouts, layout)
        return LayoutUtils:GetNextLayout(layouts, layout)
    end)
end

function WorkspaceLogic:PrevLayout(workspace)
    self:ChangeLayout(workspace, function (layouts, layout)
        return LayoutUtils:GetPrevLayout(layouts, layout)
    end)
end

function WorkspaceLogic:DefaultLayout(workspace)
    workspace:ChangeLayout(self.config.workspace.defaultLayout)
    workspace:LoadState()
end



return WorkspaceLogic