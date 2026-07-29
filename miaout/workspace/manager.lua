local Workspace = require("miaout.workspace.workspace") ---@type Workspace
local Events = require("miaout.workspace.events")

---@class WorkspaceRepo
local WorkspaceRepo = {}
WorkspaceRepo.__index = WorkspaceRepo

---@class WorkspaceManager
local WorkspaceManager = {}
WorkspaceManager.__index = WorkspaceManager

-- WorkspaceRepo
function WorkspaceRepo.new()
    local self = setmetatable({}, WorkspaceRepo) ---@type WorkspaceRepo

    self.workspaceStates = {}

    return self
end

function WorkspaceRepo:RemoveState(workspaceId)
    self.workspaceStates[workspaceId] = nil
end

function WorkspaceRepo:SaveState(workspaceId, workspaceState)
    self.workspaceStates[workspaceId] = workspaceState
end

function WorkspaceRepo:GetState(workspaceId)
    return self.workspaceStates[workspaceId]
end


-- WorkspaceManager
function WorkspaceManager.new()
    local self = setmetatable({}, WorkspaceManager) ---@type WorkspaceManager

    self.repo = WorkspaceRepo.new()

    self.workspaces = {}

    Events.Subscribe(self)

    return self
end

function WorkspaceManager:NewWorkspace(hlw)
    local workspace = Workspace.new(self.repo, hlw)

    self.workspaces[workspace.id] = workspace

    return workspace
end

function WorkspaceManager:GetWorkspace(workspaceId)
    return self.workspaces[workspaceId]
end

function WorkspaceManager:GetOrNewWorkspace(hlw)
    local workspace = self:GetWorkspace(hlw.id)

    if workspace then
        return workspace
    end

    return self:NewWorkspace(hlw)
end

function WorkspaceManager:RemoveWorkspace(workspaceId)
    self.workspaces[workspaceId] = nil
    self.repo:RemoveState(workspaceId)
end

return WorkspaceManager