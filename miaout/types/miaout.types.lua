---@meta

---@class Log
---@field new fun(config: MiaoutConfig): Log
---@field private config NotificationConfig
---@field private format fun(self: Log, level: string, ...: string): string
---@field Error fun(self: Log, ...: string)
---@field Info fun(self: Log, ...: string)

-- Utils

---@generic CopyTableT
---@alias CopyTable fun(t: CopyTableT): CopyTableT

---@class Utils
---@field CopyTable CopyTable
---@field TableLength fun(t: table): integer

---@alias GetMonitorLambda fun(monitorId: integer, monitorsLen: integer): integer

---@class MonitorUtils
---@field GetMonitorsOrdered fun(): HL.Monitor[], integer
---@field GetMonitorOrderedId fun(monitorId: integer): integer|nil
---@field GetMonitorFromOrderedId fun(monitorId: integer): HL.Monitor|nil
---@field GetTargetMonitor fun(self: MonitorUtils, func: GetMonitorLambda): HL.Monitor?
---@field GetNextMonitor fun(self: MonitorUtils): HL.Monitor?
---@field GetPrevMonitor fun(self: MonitorUtils): HL.Monitor?

---@alias GetLayoutLambda fun(layoutId: integer, layoutsLen: integer): integer

---@class LayoutUtils
---@field GetTargetLayout fun(layouts: string[], layout: string, func: GetLayoutLambda): string
---@field GetNextLayout fun(self: LayoutUtils, layouts: string[], layout: string): string
---@field GetPrevLayout fun(self: LayoutUtils, layouts: string[], layout: string): string

---@class WindowUtils
---@field CompareFullscreenState fun(a: FullscreenState, b:FullscreenState): boolean

---@alias GetWorkspaceLambda fun(workspaceIndex: integer, workspaceLen: integer): integer

---@class WorkspaceUtils
---@field private GetTargetedWorkspace fun(workspaces: HL.Workspace[]|nil, func: GetWorkspaceLambda, workspace: Workspace): HL.Workspace|nil
---@field private CalculateNextWorksace GetWorkspaceLambda
---@field private CalculatePrevWorkspace GetWorkspaceLambda
---@field GetNextWorkspace fun(self: WorkspaceUtils, workspace: Workspace): HL.Workspace|nil
---@field GetPrevWorkspace fun(self: WorkspaceUtils, workspace: Workspace): HL.Workspace|nil
---@field GetMonitorWorkspaces fun(monitor: HL.Monitor): HL.Workspace[]|nil
---@field GetNextMonitorWorkspace fun(self: WorkspaceUtils, workspace: Workspace, monitor: HL.Monitor): HL.Workspace|nil
---@field GetPrevMonitorWorkspace fun(self: WorkspaceUtils, workspace: Workspace, monitor: HL.Monitor): HL.Workspace|nil

-- Miaout Init
---@class Modules
---@field window WindowFacade
---@field workspace WorkspaceFacade

---@class Miaout
---@field Init fun(): Modules
