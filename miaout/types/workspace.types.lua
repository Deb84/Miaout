---@meta


---@class WorkspaceState: table
---@field layout string

---@class WorkspaceRepo
---@field new fun(): WorkspaceRepo
---@field private workspaceStates table<integer, WorkspaceState>
---@field RemoveState fun(self: WorkspaceRepo, workspaceId: integer)
---@field SaveState fun(self: WorkspaceRepo, workspaceId: integer, workspaceState: WorkspaceState)
---@field GetState fun(self: WorkspaceRepo, workspaceId: integer): WorkspaceState?

---@class WorkspaceManager
---@field new fun(): WorkspaceManager
---@field private repo WorkspaceRepo
---@field private workspaces Workspace[]
---@field NewWorkspace fun(self: WorkspaceManager, hlw: HL.Workspace): Workspace
---@field GetWorkspace fun(self: WorkspaceManager, workspaceId: integer): Workspace?
---@field GetOrNewWorkspace fun(self: WorkspaceManager, hlw: HL.Workspace): Workspace
---@field RemoveWorkspace fun(self: WorkspaceManager, workspaceId: integer)

---@class Workspace
---@field new fun(repo: WorkspaceRepo, hlWorkspace: HL.Workspace): Workspace
---@field private repo WorkspaceRepo
---@field private hlw HL.Workspace?
---@field public id integer
---@field GetHlObject fun(self: Workspace): HL.Workspace?
---@field UpdateState fun(self: Workspace, state: WorkspaceState?)
---@field LoadState fun(self: Workspace)
---@field Focus fun(self: Workspace)
---@field MoveToMonitor fun(self: Workspace, monitor: HL.Monitor)
---@field ChangeLayout fun(self: Workspace, layout: string)
---@field GetLayout fun(self: Workspace): string

---@alias ChangeLayoutLambda fun(layouts: string[], string): string

---@class WorkspaceLogic
---@field new fun(log: Log, config:  MiaoutConfig, manager: WorkspaceManager): WorkspaceLogic
---@field private config MiaoutConfig
---@field private log Log
---@field private manager WorkspaceManager
---@field NewWorkspace fun(self: WorkspaceLogic)
---@field SwitchToWorkspace fun(self: WorkspaceLogic, workspace: Workspace|HL.WorkspaceSelector)
---@field NextWorkspace fun(self: WorkspaceLogic)
---@field PrevWorkspace fun(self: WorkspaceLogic)
---@field NextMonitorWorkspace fun(self: WorkspaceLogic)
---@field PrevMonitorWorkspace fun(self: WorkspaceLogic)
---@field MoveToMonitor fun(self: WorkspaceLogic, workspace: Workspace, monitor: HL.Monitor?)
---@field MoveToNextMonitor fun(self: WorkspaceLogic, workspace: Workspace)
---@field MoveToPrevMonitor fun(self: WorkspaceLogic, workspace: Workspace)
---@field private ChangeLayout fun(self: WorkspaceLogic, workspace: Workspace, func: ChangeLayoutLambda)
---@field NextLayout fun(self: WorkspaceLogic, workspace: Workspace)
---@field PrevLayout fun(self: WorkspaceLogic, workspace: Workspace)
---@field DefaultLayout fun(self: WorkspaceLogic, workspace: Workspace)

---@alias WorkspaceFacadeMethod fun(self: WorkspaceFacade)

---@class WorkspaceFacade
---@field new fun(log: Log, workspaceLogic: WorkspaceLogic, workspaceManager: WorkspaceManager): WorkspaceFacade
---@field private log Log
---@field private workspaceLogic WorkspaceLogic
---@field private workspaceManager WorkspaceManager
---@field public current CurrentWorkspaceFacade
---@field NewWorkspace WorkspaceFacadeMethod
---@field NextWorkspace WorkspaceFacadeMethod
---@field PrevWorkspace WorkspaceFacadeMethod
---@field NextMonitorWorkspace WorkspaceFacadeMethod
---@field PrevMonitorWorkspace WorkspaceFacadeMethod
---@field MoveToMonitor fun(self: WorkspaceFacade, hlWorkspace: HL.Workspace, monitor: HL.Monitor)
---@field MoveToNextMonitor fun(self: WorkspaceFacade, hlWorkspace: HL.Workspace)
---@field MoveToPrevMonitor fun(self: WorkspaceFacade, hlWorkspace: HL.Workspace)
---@field NextLayout fun(self: WorkspaceFacade, hlWorkspace: HL.Workspace)
---@field PrevLayout fun(self: WorkspaceFacade, hlWorkspace: HL.Workspace)
---@field DefaultLayout fun(self: WorkspaceFacade, hlWorkspace: HL.Workspace)

---@alias CurrentWorkspaceFacadeMethod fun(self: CurrentWorkspaceFacade)
---@alias WithActiveWorkspaceCallback fun(self: WorkspaceFacade, hlWindow: HL.Workspace, ...: any?)

---@class CurrentWorkspaceFacade
---@field new fun(workspaceFacade: WorkspaceFacade, log: Log): CurrentWorkspaceFacade
---@field private log Log
---@field private facade WorkspaceFacade
---@field private WithActiveWorkspaceCallback
---@field MoveToMonitor fun(self: CurrentWorkspaceFacade, monitor: HL.Monitor)
---@field MoveToNextMonitor CurrentWorkspaceFacadeMethod
---@field MoveToPrevMonitor CurrentWorkspaceFacadeMethod
---@field NextLayout CurrentWorkspaceFacadeMethod
---@field PrevLayout CurrentWorkspaceFacadeMethod
---@field DefaultLayout CurrentWorkspaceFacadeMethod