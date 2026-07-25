local WorkspaceFacade = {} ---@class WorkspaceFacade
WorkspaceFacade.__index = WorkspaceFacade

local Current = {} ---@class CurrentWorkspaceFacade
Current.__index = Current

function Current.new(workspaceFacade, log)
    local self = setmetatable({}, Current)

    self.log = log
    self.facade = workspaceFacade

    return self
end

function Current:withActiveWorkspace(func, ...)
    local hlWorkspace = hl.get_active_workspace()

    if not hlWorkspace then
        self.log:Error("Unable to get the current workspace")
        return
    end

    func(self.facade, hlWorkspace, ...)
end

function Current:MoveToMonitor(monitor)
    self:withActiveWorkspace(self.facade.MoveToMonitor, monitor)
end

function Current:MoveToNextMonitor()
    self:withActiveWorkspace(self.facade.MoveToNextMonitor)
end

function Current:MoveToPrevMonitor()
    self:withActiveWorkspace(self.facade.MoveToPrevMonitor)
end

function Current:NextLayout()
    self:withActiveWorkspace(self.facade.NextLayout)
end

function Current:PrevLayout()
    self:withActiveWorkspace(self.facade.PrevLayout)
end

function Current:DefaultLayout()
    self:withActiveWorkspace(self.facade.DefaultLayout)
end


--- WindowFacade
function WorkspaceFacade.new(log, workspaceLogic, workspaceManager)
    local self = setmetatable({}, WorkspaceFacade)

    self.log = log
    self.workspaceLogic = workspaceLogic
    self.workspaceManager = workspaceManager

    self.current = Current.new(self, log)

    return self
end


function WorkspaceFacade:NewWorkspace()
    self.workspaceLogic:NewWorkspace()
end

function WorkspaceFacade:NextWorkspace()
    self.workspaceLogic:NextWorkspace()
end

function WorkspaceFacade:PrevWorkspace()
    self.workspaceLogic:PrevWorkspace()
end

function WorkspaceFacade:NextMonitorWorkspace()
    self.workspaceLogic:NextMonitorWorkspace()
end

function WorkspaceFacade:PrevMonitorWorkspace()
    self.workspaceLogic:PrevMonitorWorkspace()
end

function WorkspaceFacade:MoveToMonitor(hlWorkspace, monitor)
    local workspace = self.workspaceManager:GetOrNewWorkspace(hlWorkspace)
    self.workspaceLogic:MoveToMonitor(workspace, monitor)
end

function WorkspaceFacade:MoveToNextMonitor(hlWorkspace)
    local workspace = self.workspaceManager:GetOrNewWorkspace(hlWorkspace)
    self.workspaceLogic:MoveToNextMonitor(workspace)
end

function WorkspaceFacade:MoveToPrevMonitor(hlWorkspace)
    local workspace = self.workspaceManager:GetOrNewWorkspace(hlWorkspace)
    self.workspaceLogic:MoveToPrevMonitor(workspace)
end

function WorkspaceFacade:NextLayout(hlWorkspace)
    local workspace = self.workspaceManager:GetOrNewWorkspace(hlWorkspace)
    self.workspaceLogic:NextLayout(workspace)
end

function WorkspaceFacade:PrevLayout(hlWorkspace)
    local workspace = self.workspaceManager:GetOrNewWorkspace(hlWorkspace)
    self.workspaceLogic:PrevLayout(workspace)
end

function WorkspaceFacade:DefaultLayout(hlWorkspace)
    local workspace = self.workspaceManager:GetOrNewWorkspace(hlWorkspace)
    self.workspaceLogic:DefaultLayout(workspace)
end



return WorkspaceFacade