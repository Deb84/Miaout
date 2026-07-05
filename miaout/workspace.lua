local Instance = {}
Instance.__index = Instance

local function subscribleEvents(self)

    -- the behaviour is weird here, active workspace is actually the last workspace
    hl.on("monitor.focused", function (monitor)
        local lastWorkspace = hl.get_active_workspace() -- dont ask me how but it works
        self:SaveWorkspaceState(lastWorkspace)

        local workspace = monitor.active_workspace

        self:LoadWorkspaceState(workspace)
    end)

    hl.on("workspace.active", function (workspace)
        local lastWorkspace = hl.get_last_workspace()
        self:SaveWorkspaceState(lastWorkspace)

        self:LoadWorkspaceState(workspace)
    end)

    hl.on("window.close", function (window)
        local workspaceState = self.workspaceStates[window.workspace.id]
        if not workspaceState then return end
        local activeWindowState = workspaceState.activeWindowState
        if not activeWindowState then return end
        self.workspaceStates[window.workspace.id].activeWindowState = nil
    end)
end

function Instance.new(layout, window)
    local self = setmetatable({}, Instance)
    self.layout = layout
    self.window = window
    self.workspaceStates = {}

    subscribleEvents(self)

    return self
end

function Instance:LazyLoadWindowState(windowState)
    hl.timer(function()
        self:LoadWindowState(windowState)
    end, { timeout = 1, type = "oneshot" })
end


function Instance:SaveWorkspaceState(workspace)
    local lastWindow = workspace.last_window

    local activeWindowState = nil
    if lastWindow then
        activeWindowState = {
            window = lastWindow;
            fullscreen = lastWindow.fullscreen,
            fullscreen_client = lastWindow.fullscreen_client,
            size = lastWindow.size,
        }
    end

    self.workspaceStates[workspace.id] = {
        layout = hl.get_config("general.layout"),
        activeWindowState = activeWindowState
    }
end

function Instance:LoadWindowState(windowState)
    self.window:FocusWindow(windowState.window)
    self.window:SetFullscreenState({internal = windowState.fullscreen, client = windowState.fullscreen_client})

end

function Instance:LoadWorkspaceState(workspace)
    local workspaceState = self.workspaceStates[workspace.id]
    if not workspaceState then return end

    if workspaceState.activeWindowState then
        self:LazyLoadWindowState(workspaceState.activeWindowState) -- need to load window state after the workspace loading
    end

    self.layout:UpdateLayout(workspaceState.layout)
end

function Instance:SwitchToWorkspace(workspaceSelector)
    hl.dispatch(hl.dsp.focus({workspace = workspaceSelector}))

    local workspace = hl.get_active_workspace()
    return workspace
end

function Instance:NewWorkspace()
    local workspaces = hl.get_workspaces()
    local workspace = self:SwitchToWorkspace(workspaces[#workspaces].id + 1)
    return workspace
end

function Instance:MoveWorkspaceMonitor()

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
        if not currentMonitor then return end

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

function Instance:SwitchPrevMonitorWorkspace()
    self:SwitchToWorkspace("m-1")
end

return Instance