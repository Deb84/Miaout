local Window = require("miaout.window.window") ---@type Window
local Events = require("miaout.window.events")

---@class WindowRepo
local WindowRepo = {}
WindowRepo.__index = WindowRepo

---@class WindowManager
local WindowManager = {}
WindowManager.__index = WindowManager

-- WindowRepo
function WindowRepo.new()
    local self = setmetatable({}, WindowRepo)

    self.windowStates = {}

    return self
end

function WindowRepo:RemoveState(windowId)
    self.windowStates[windowId] = nil
end

function WindowRepo:SaveState(windowId, windowState)
    self.windowStates[windowId] = windowState
end

function WindowRepo:GetState(windowId)
    return self.windowStates[windowId]
end


-- WindowManager
function WindowManager.new()
    local self = setmetatable({}, WindowManager)

    self.repo = WindowRepo.new()

    self.windows = {}

    Events.Subscribe(self)

    return self
end

function WindowManager:NewWindow(hlw)
    local window = Window.new(self.repo, hlw)

    self.windows[window.id] = window

    return window
end

function WindowManager:GetWindow(windowId)
    return self.windows[windowId]
end

function WindowManager:GetOrNewWindow(hlw)
    local window = self:GetWindow(hlw.stable_id)

    if window then
        return window
    end

    return self:NewWindow(hlw)
end

function WindowManager:RemoveWindow(windowId)
    self.windows[windowId] = nil
    self.repo:RemoveState(windowId)
end

return WindowManager