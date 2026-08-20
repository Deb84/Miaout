---@meta

---@class WindowState
---@field fullscreenState FullscreenState
---@field size integer|table

---@class WindowRepo
---@field new fun(): WindowRepo
---@field private windowStates table<integer, WindowState>
---@field SaveState fun(self: WindowRepo, windowId: integer, state: WindowState)
---@field GetState fun(self: WindowRepo, windowId: integer): WindowState?
---@field RemoveState fun(self: WindowRepo, windowId: integer)

---@class WindowManager
---@field new fun(): WindowManager
---@field private repo WindowRepo
---@field private windows Window[]
---@field NewWindow fun(self: WindowManager, hlw: HL.Window): Window
---@field GetWindow fun(self: WindowManager, windowId: integer): Window?
---@field GetOrNewWindow fun(self: WindowManager, hlw: HL.Window): Window
---@field RemoveWindow fun(self: WindowManager, windowId: integer)

---@class Window
---@field new fun(repo: WindowRepo, hlWindow: HL.Window): Window
---@field private repo WindowRepo
---@field private hlw HL.Window
---@field id integer
---@field GetHlObject fun(self: Window): HL.Window
---@field UpdateState fun(self: Window)
---@field LoadState fun(self: Window)
---@field Focus fun(self: Window)
---@field SetFullscreenState fun(self: Window, state: FullscreenState)
---@field GetFullscreenState fun(self: Window): FullscreenState
---@field SwapWindow fun(self: Window, window: Window)
---@field MoveToWorkspace fun(self: Window, workspace: Workspace)
---@field MoveToMonitor fun(self: Window, monitor: HL.Monitor)
---@field ReSize fun(self: Window, x: integer, y: integer)

---@alias MoveToWorkspaceLambda fun(self: WorkspaceUtils, workspace: Workspace, monitor: HL.Monitor?)

---@class WindowLogic
---@field new fun(log: Log, config: MiaoutConfig, windowManager: WindowManager, workspaceManager: WorkspaceManager): WindowLogic
---@field private log Log
---@field private config MiaoutConfig
---@field private windowManager WindowManager
---@field private workspaceManager WorkspaceManager
---@field private MoveToMonitor fun(self:WindowLogic, window: Window, monitor: HL.Monitor?)
---@field private MoveToWorkspace fun(self: WindowLogic, window: Window, func: MoveToWorkspaceLambda)
---@field MoveToNextWorkspace fun(self:WindowLogic, window: Window)
---@field MoveToPrevWorkspace fun(self:WindowLogic, window: Window)
---@field MoveToNextMonitorWorkspace fun(self:WindowLogic, window: Window)
---@field MoveToPrevMonitorWorkspace fun(self:WindowLogic, window: Window)
---@field MoveToNextMonitor fun(self:WindowLogic, window: Window)
---@field MoveToPrevMonitor fun(self:WindowLogic, window: Window)
---@field private ChangeScreenState fun(self: WindowLogic, window: Window, state: FullscreenState, toggle: FullscreenState?)
---@field SetScreenDefault fun(self: WindowLogic, window: Window)
---@field Maximise fun(self: WindowLogic, window: Window)
---@field SetFullscreen fun(self: WindowLogic, window: Window)
---@field SwapWindows fun(self: WindowLogic, activeWindow: Window, lastWindow: Window)
---@field ReSize fun(self: WindowLogic, window: Window, ratio: number)
---@field UpScale fun(self: WindowLogic, window: Window)
---@field DownScale fun(self: WindowLogic, window: Window)

---@alias WindowFacadeMethod fun(self: WindowFacade, hlWindow: HL.Window)

---@class WindowFacade
---@field new fun(log: Log, windowLogic: WindowLogic, windowManager: WindowManager): WindowFacade
---@field private log Log
---@field private windowLogic WindowLogic
---@field private windowManager WindowManager
---@field public current CurrentWindowFacade
---@field MoveToNextWorkspace WindowFacadeMethod
---@field MoveToPrevWorkspace WindowFacadeMethod
---@field MoveToNextMonitorWorkspace WindowFacadeMethod
---@field MoveToPrevMonitorWorkspace WindowFacadeMethod
---@field DefaultScreen WindowFacadeMethod
---@field Maximise WindowFacadeMethod
---@field Fullscreen WindowFacadeMethod
---@field SwapWindows fun(self: WindowFacade, hlWindowA: HL.Window, hlWindowA: HL.Window)
---@field UpScale fun(self: WindowFacade, hlWindow: HL.Window)
---@field DownScale fun(self: WindowFacade, hlWindow: HL.Window)

---@alias CurrentWindowFacadeMethod fun(self: CurrentWindowFacade)
---@alias WithActiveWindowCallback fun(self: WindowFacade, hlWindow: HL.Window, ...: any?)

---@class CurrentWindowFacade
---@field new fun(windowFacade: WindowFacade, log: Log): CurrentWindowFacade
---@field private log Log
---@field private facade WindowFacade
---@field private withActiveWindow fun(self: CurrentWindowFacade, func: WithActiveWindowCallback, ...: any?)
---@field MoveToNextWorkspace CurrentWindowFacadeMethod
---@field MoveToPrevWorkspace CurrentWindowFacadeMethod
---@field MoveToNextMonitorWorkspace CurrentWindowFacadeMethod
---@field MoveToPrevMonitorWorkspace CurrentWindowFacadeMethod
---@field DefaultScreen CurrentWindowFacadeMethod
---@field Maximise CurrentWindowFacadeMethod
---@field Fullscreen CurrentWindowFacadeMethod
---@field UpScale CurrentWindowFacadeMethod
---@field DownScale CurrentWindowFacadeMethod

