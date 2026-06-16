local Instance = {}
Instance.__index = Instance

local function subscribleEvents(self)
    local hl = self.hl


    -- the behaviour is weird here, active workspace is actually the last workspace
    hl.on("monitor.focused", function (monitor)
        local lastWorkspace = hl.get_active_workspace() -- dont ask me how but it works
        self:SaveWorkspaceState(lastWorkspace)

        local workspace = monitor.active_workspace

        self:LoadWorkspaceLayout(workspace)
    end)

    hl.on("workspace.active", function (workspace)
        local lastWorkspace = hl.get_last_workspace()
        self:SaveWorkspaceState(lastWorkspace)

        self:LoadWorkspaceLayout(workspace)
    end)
end

function Instance.new(hl, layout)
    local self = setmetatable({}, Instance)
    self.hl = hl
    self.layout = layout
    self.workspaceStates = {}

    subscribleEvents(self)

    return self
end

function Instance:SaveWorkspaceState(workspace)
    self.workspaceStates[workspace.id] = {
        layout = self.hl.get_config("general.layout")
    }
end

function Instance:LoadWorkspaceLayout(workspace)
    local workspaceState = self.workspaceStates[workspace.id]

    if workspaceState then
        self.layout:UpdateLayout(workspaceState.layout)
    end
end

function Instance:SwitchToWorkspace(workspaceSelector)
    local hl = self.hl

    hl.dispatch(hl.dsp.focus({workspace = workspaceSelector}))

    local workspace = hl.get_active_workspace()
    return workspace
end

function Instance:NewWorkspace()
    local workspaces = self.hl.get_workspaces()
    local workspace = self:SwitchToWorkspace(workspaces[#workspaces].id + 1)
    return workspace
end

function Instance:SwapWorkspaceMonitor()
    local hl = self.hl

    local monitors = hl.get_monitors()
    local monitorsPerId = {}

    local maxId = 0
    for _, v in ipairs(monitors) do
        monitorsPerId[v.id] = v
        if v.id > maxId then
            maxId = v.id
        end
    end

    local currentMonitor = hl.get_active_window().monitor
    local nextMonitorId = currentMonitor.id - 1
    local nextMonitor = monitorsPerId[nextMonitorId]


    if not nextMonitor then
        local id = 0
        while id <= maxId do
            id = id +1
            nextMonitor = monitorsPerId[id]
            if nextMonitor then break end
        end
    end


    hl.dispatch(hl.dsp.workspace.move({monitor = nextMonitor.name }))
end

function Instance:SwitchNextWorkspace()
    self:SwitchToWorkspace("e+1")
end

function Instance:SwitchPreviousWorkspace()
    self:SwitchToWorkspace("e-1")
end

function Instance:SwitchNextMonitorWorkspace()
    self:SwitchToWorkspace("m+1")
end

function Instance:SwitchPreviousMonitorWorkspace()
    self:SwitchToWorkspace("m-1")
end

return Instance
