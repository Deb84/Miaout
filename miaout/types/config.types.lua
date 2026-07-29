---@meta

-- Config
---@class MiaoutConfig
---@field new fun(): MiaoutConfig
---@field window WindowConfig
---@field workspace WorkspaceConfig
---@field notifications NotificationConfig

---@class WindowConfig
---@field default FullscreenState
---@field maximise FullscreenState
---@field fullscreen FullscreenState

---@class WorkspaceConfig
---@field nextWorkspaceSelector HL.WorkspaceSelector
---@field prevWorkspaceSelector HL.WorkspaceSelector
---@field nextMonitorWorkspaceSelector HL.WorkspaceSelector
---@field prevMonitorWorkspaceSelector HL.WorkspaceSelector
---@field defaultLayout string
---@field layouts string[]

---@class NotificationConfig
---@field prefix string
---@field displayTimeMs integer
