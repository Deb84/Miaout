local Utils = require("miaout.utils.utils")

local WorkspaceUtils = {} ---@class WorkspaceUtils


function WorkspaceUtils.GetTargetedWorkspace(workspaces, func, workspace)
    if not workspaces then return end

    table.sort(workspaces, function (a, b)
        return a.id < b.id
    end)

    local currentIndex

    for i, w in ipairs(workspaces) do
        if w.id == workspace.id then
            currentIndex = i
            break
        end
    end
    if not currentIndex then return end

    local nextWorkspaceId = func(currentIndex, #workspaces)

    return workspaces[nextWorkspaceId]
end

function WorkspaceUtils.CalculateNextWorksace(workspaceIndex, workspaceLen)
    return ((workspaceIndex - 1 + 1) % workspaceLen) + 1
end

function WorkspaceUtils.CalculatePrevWorkspace(workspaceIndex, workspaceLen)
    return ((workspaceIndex - 1 - 1) % workspaceLen) + 1
end

function WorkspaceUtils:GetNextWorkspace(workspace)
    local workspaces = hl.get_workspaces()
    return self.GetTargetedWorkspace(workspaces, self.CalculateNextWorksace, workspace)
end

function WorkspaceUtils:GetPrevWorkspace(workspace)
    local workspaces = hl.get_workspaces()
    return self.GetTargetedWorkspace(workspaces, self.CalculatePrevWorkspace, workspace)
end

function WorkspaceUtils.GetMonitorWorkspaces(monitor)
    local workspaces = hl.get_workspaces()
    local monitorWorkspaces = {}

    for _, v in ipairs(workspaces) do
        if v.monitor.id == monitor.id then
            table.insert(monitorWorkspaces, v)
        end
    end

    if not next(monitorWorkspaces) then return end
    return monitorWorkspaces
end

function WorkspaceUtils:GetNextMonitorWorkspace(workspace, monitor)
    local workspaces = self.GetMonitorWorkspaces(monitor)
    return self.GetTargetedWorkspace(workspaces, self.CalculateNextWorksace, workspace)
end

function WorkspaceUtils:GetPrevMonitorWorkspace(workspace, monitor)
    local workspaces = self.GetMonitorWorkspaces(monitor)
    return self.GetTargetedWorkspace(workspaces, self.CalculatePrevWorkspace, workspace)
end


return WorkspaceUtils