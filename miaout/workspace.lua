local Instance = {}
Instance.__index = Instance

function Instance.new(hl, layout)
    local self = setmetatable({}, Instance)
    self.hl = hl
    self.layout = layout
    self.workspaceLayouts = {}

    return self
end


function Instance:SaveWorkspaceLayout(workspaceID, layout)
    self.workspaceLayouts[workspaceID] = layout
end

function Instance:SaveWorkspaceState()
    local workspace = self.hl.get_active_workspace()
    self:SaveWorkspaceLayout(workspace.id, self.hl.get_config("general.layout"))
end

function Instance:SwitchWorkspaceLayout(workspaceID)
    self.layout:ChangeLayout(self.workspaceLayouts[workspaceID])
end

function Instance:SwitchWorkspace(workspaceID)
    self:SaveWorkspaceState()
    self.hl.dispatch(self.hl.dsp.focus({workspace = workspaceID}))

    local workspace = self.hl.get_active_workspace()

    self:SwitchWorkspaceLayout(workspace.id)
end

function Instance:NewWorkspace()
    local workspaces = self.hl.get_workspaces()
    self.hl.notification.create({text = #workspaces, timeout = 1000})
    self:SwitchWorkspace(#workspaces + 1)
end

function Instance:SwitchNextWorkspace()
    self:SwitchWorkspace("e+1")
end

function Instance:SwitchPreviousWorkspace()
    self:SwitchWorkspace("e-1")
end


return Instance
