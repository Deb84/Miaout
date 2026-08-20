
---@class Window
local Window = {}
Window.__index = Window

-- TODO
-- GetWorkspace (workspace miaout obj)

function Window.new(repo, hlWindow)
    local self = setmetatable({}, Window)

    self.repo = repo
    self.hlw = hlWindow
    self.id = hlWindow.stable_id

    return self
end

function Window:GetHlObject()
    return self.hlw
end

function Window:UpdateState()
    local state = {
        fullscreenState = {
            internal = self.hlw.fullscreen,
            client = self.hlw.fullscreen_client
        },
        size = self.hlw.size
    }

    self.repo:SaveState(self.id, state)
end

function Window:LoadState()
    local state = self.repo:GetState(self.id)

    if not state then return end

    self:SetFullscreenState(state.fullscreenState)
end

function Window:Focus()
    hl.dispatch(hl.dsp.focus({
        window = self.hlw
    }))
end

function Window:SetFullscreenState(state)
    hl.dispatch(hl.dsp.window.fullscreen_state(state))
end

function Window:GetFullscreenState()
    return {internal = self.hlw.fullscreen, client = self.hlw.fullscreen_client}
end

function Window:SwapWindow(window)
    hl.dispatch(hl.dsp.window.swap({target = window:GetHlObject()}))
end

function Window:MoveToWorkspace(workspace)
    hl.dispatch(hl.dsp.window.move({ workspace = workspace:GetHlObject() }))
end

function Window:MoveToMonitor(monitor)
    hl.dispatch(hl.dsp.window.move({ monitor = monitor.name, window = self.hlw }))
end

function Window:ReSize(x, y)
    hl.dispatch(hl.dsp.window.resize({x = x, y = y, window = self.hlw}))
end

return Window