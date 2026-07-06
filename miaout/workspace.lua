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

    hl.on("window.move_to_workspace", function (window, workspace)
        for id, ws in ipairs(self.workspaceStates) do
            if workspace.id == id then return end
            if ws.activeWindowState.window.stable_id ~= window.stable_id then return end
            self.workspaceStates[id].activeWindowState = nil
        end
    end)

    hl.on("window.close", function (window)
        local workspaceState = self.workspaceStates[window.workspace.id]
        if not workspaceState then return end
        self.workspaceStates[window.workspace.id].activeWindowState = nil
    end)

    hl.on("workspace.removed", function (workspace)
        local workspaceState = self.workspaceStates[workspace.id]
        if not workspaceState then return end
        self.workspaceStates[workspace.id] = nil
    end)
end

function Instance.new(layout, window)
    local self = setmetatable({}, Instance)
    self.layout = layout
    self.window = window
    self.workspaceStates = {}
    self.lock = 0

    subscribleEvents(self)

    return self
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

function timer(fun, timeout)
    hl.timer(function(...)
        fun(...)
    end, { timeout = timeout, type = "oneshot" })
end

function Instance:LoadWindowState(windowState)
    if windowState.window.stable_id == hl.get_active_window().stable_id then return end
    self.window:FocusWindow(windowState.window)
    self.window:SetFullscreenState({internal = windowState.fullscreen, client = windowState.fullscreen_client})

end

function Instance:LazyLoadWindowState(windowState)
    self.lock = self.lock + 1
    local lock = self.lock

    timer(function ()
        if self.lock ~= lock then return end
        self:LoadWindowState(windowState)
    end, 1)
end

function Instance:LoadWorkspaceState(workspace)
    local workspaceState = self.workspaceStates[workspace.id]
    if not workspaceState then return end

    if workspaceState.activeWindowState then
        self:LazyLoadWindowState(workspaceState.activeWindowState) -- need to load window state after the workspace loading
        hl.notification.create({text = workspace.id, timeout = 3000})
    end

    self.layout:UpdateLayout(workspaceState.layout)
end

function Instance:SwitchToWorkspace(workspaceSelector)
    hl.dispatch(hl.dsp.focus({workspace = workspaceSelector}))


    local workspace = hl.get_active_workspace()
    return workspace
end

function Instance:NewWorkspace()
    local max = 0

    for _, ws in ipairs(hl.get_workspaces()) do
        if ws.id > max then
            max = ws.id
        end
    end
    return self:SwitchToWorkspace(max + 1)
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