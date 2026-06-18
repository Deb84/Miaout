local Instance = {}
Instance.__index = Instance

function Instance.new(hl, workspace)
    local self = setmetatable({}, Instance)
    self.hl = hl
    self.workspace = workspace

    -- memory
    self.windowInitialFullscreenState = {}

    return self
end

function Instance:MoveToNextWorkspace()
    local workspaceMove = "e+1"
    self.hl.dispatch(self.hl.dsp.window.move({ workspace = workspaceMove}))
end

function Instance:MoveToPrevWorkspace()
    local workspaceMove = "e-1"
    self.hl.dispatch(self.hl.dsp.window.move({ workspace = workspaceMove}))
end

function Instance:SwapWindows()
    local hl = self.hl

    local last = hl.get_last_window()

    hl.dispatch(hl.dsp.window.swap({target = last}))
    hl.dispatch(hl.dsp.window.bring_to_top())
end

function Instance:MoveWindowMonitor()
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


    hl.dispatch(hl.dsp.window.move({monitor = nextMonitor.name }))
end

local function changeFullscreenState(self, internal, client)
    local hl = self.hl

    local window = hl.get_active_window()

    local initalState = self.windowInitialFullscreenState[window.pid]
    self.windowInitialFullscreenState[window.pid] = {internal = window.fullscreen, client = window.fullscreen_client}

    if not initalState or initalState.internal > 1 then
        initalState = {internal = 0, client = 1}
    end

    local state
    if window.fullscreen ~= internal then
        state = {internal = internal, client = client}
    else
        state = initalState
    end

    hl.dispatch(hl.dsp.window.fullscreen_state(state))
end

function Instance:Fullscreen()
    changeFullscreenState(self, 2, 1)
end

function Instance:Maximise()
    changeFullscreenState(self, 1, 1)
end

function Instance:Default()
    changeFullscreenState(self, 0, 0)
end

return Instance
