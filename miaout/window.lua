local Instance = {}
Instance.__index = Instance

function Instance.new()
    local self = setmetatable({}, Instance)

    -- memory
    self.windowInitialFullscreenState = {}

    return self
end

function Instance:MoveToNextWorkspace()
    local workspaceMove = "e+1"
    hl.dispatch(hl.dsp.window.move({ workspace = workspaceMove}))
end

function Instance:MoveToPrevWorkspace()
    local workspaceMove = "e-1"
    hl.dispatch(hl.dsp.window.move({ workspace = workspaceMove}))
end

function Instance:SwapWindows()
    local last = hl.get_last_window()

    hl.dispatch(hl.dsp.window.swap({target = last}))
    hl.dispatch(hl.dsp.window.bring_to_top())
end

function Instance:MoveWindowMonitor()
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


    hl.dispatch(hl.dsp.window.move({monitor = nextMonitor.name }))
end

local function changeFullscreenState(self, internal, client)
    local window = hl.get_active_window()
    if not window then return end

    local initalState = self.windowInitialFullscreenState[window.stable_id]
    self.windowInitialFullscreenState[window.stable_id] = {internal = window.fullscreen, client = window.fullscreen_client}

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

function Instance:FocusWindow(window)
    hl.dispatch(hl.dsp.focus({ window = window}))
end

function Instance:SetFullscreenState(state)
    hl.dispatch(hl.dsp.window.fullscreen_state(state))
end

return Instance