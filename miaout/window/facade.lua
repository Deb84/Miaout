local WindowFacade = {} ---@class WindowFacade
WindowFacade.__index = WindowFacade

local Current = {} ---@class CurrentWindowFacade
Current.__index = Current

function Current.new(windowFacade, log)
    local self = setmetatable({}, Current)

    self.log = log
    self.facade = windowFacade

    return self
end

function Current:withActiveWindow(func, ...)
    local window = hl.get_active_window()

    if not window then
        self.log:Error("Unable to get the current window")
        return
    end

    func(self.facade, window, ...)
end

function Current:MoveToNextWorkspace()
    self:withActiveWindow(self.facade.MoveToNextWorkspace)
end

function Current:MoveToPrevWorkspace()
    self:withActiveWindow(self.facade.MoveToPrevWorkspace)
end

function Current:MoveToNextMonitorWorkspace()
    self:withActiveWindow(self.facade.MoveToNextMonitorWorkspace)
end

function Current:MoveToPrevMonitorWorkspace()
    self:withActiveWindow(self.facade.MoveToPrevMonitorWorkspace)
end

function Current:MoveToNextMonitor()
    self:withActiveWindow(self.facade.MoveToNextMonitor)
end

function Current:MoveToPrevMonitor()
    self:withActiveWindow(self.facade.MoveToPrevMonitor)
end

function Current:DefaultScreen()
    self:withActiveWindow(self.facade.DefaultScreen)
end

function Current:Maximise()
    self:withActiveWindow(self.facade.Maximise)
end

function Current:Fullscreen()
    self:withActiveWindow(self.facade.Fullscreen)
end

function Current:SwapWithLastWindow()
    local last = hl.get_last_window()
    if not last then
        self.log:Error("Unable to get the last window")
        return
    end

    self:withActiveWindow(self.facade.SwapWindows, last)
end


--- WindowFacade
function WindowFacade.new(log, windowLogic, windowManager)
    local self = setmetatable({}, WindowFacade)

    self.log = log
    self.windowLogic = windowLogic
    self.windowManager = windowManager

    self.current = Current.new(self, log)

    return self
end

function WindowFacade:MoveToNextWorkspace(hlWindow)
    local window = self.windowManager:NewWindow(hlWindow)
    self.windowLogic:MoveToNextWorkspace(window)
end

function WindowFacade:MoveToPrevWorkspace(hlWindow)
    local window = self.windowManager:NewWindow(hlWindow)
    self.windowLogic:MoveToPrevWorkspace(window)
end

function WindowFacade:MoveToNextMonitorWorkspace(hlWindow)
    local window = self.windowManager:NewWindow(hlWindow)
    self.windowLogic:MoveToNextMonitorWorkspace(window)
end

function WindowFacade:MoveToPrevMonitorWorkspace(hlWindow)
    local window = self.windowManager:NewWindow(hlWindow)
    self.windowLogic:MoveToPrevMonitorWorkspace(window)
end

function WindowFacade:MoveToNextMonitor(hlWindow)
    local window = self.windowManager:NewWindow(hlWindow)
    self.windowLogic:MoveToNextMonitor(window)
end

function WindowFacade:MoveToPrevMonitor(hlWindow)
    local window = self.windowManager:NewWindow(hlWindow)
    self.windowLogic:MoveToPrevMonitor(window)
end

function WindowFacade:DefaultScreen(hlWindow)
    local window = self.windowManager:NewWindow(hlWindow)
    self.windowLogic:SetScreenDefault(window)
end

function WindowFacade:Maximise(hlWindow)
    local window = self.windowManager:NewWindow(hlWindow)
    self.windowLogic:Maximise(window)
end

function WindowFacade:Fullscreen(hlWindow)
    local window = self.windowManager:NewWindow(hlWindow)
    self.windowLogic:SetFullscreen(window)
end

function WindowFacade:SwapWindows(hlWindowA, hlWindowB)
    local activeWindow = self.windowManager:GetOrNewWindow(hlWindowA)
    local lastWindow = self.windowManager:GetOrNewWindow(hlWindowB)

    self.windowLogic:SwapWindows(activeWindow, lastWindow)
end

return WindowFacade



