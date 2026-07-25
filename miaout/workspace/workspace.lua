local Utils = require("miaout.utils.utils")

---@class Workspace
local Workspace = {}
Workspace.__index = Workspace

-- TODO
-- GetWorkspace (workspace miaout obj)

function Workspace.new(repo, hlWorkspace)
    local self = setmetatable({}, Workspace)

    self.repo = repo
    self.hlw = hlWorkspace
    self.id = hlWorkspace.id

    if not self.repo:GetState(self.id) then
        self:UpdateState()
    end

    return self
end

function Workspace:GetHlObject()
    return self.hlw
end

function Workspace:UpdateState(state)
    if not state then
        state = {
            layout = self.hlw.tiled_layout
        }
    end

    self.repo:SaveState(self.id, state)
end

function Workspace:LoadState()
    local state = self.repo:GetState(self.id)

    if not state then
        return
    end

    hl.workspace_rule({workspace = self.hlw.name, layout = state.layout})

    self:Focus()
end

function Workspace:Focus()
    local selector = self.hlw or self.id

    hl.dispatch(hl.dsp.focus({
        workspace = selector
    }))
end

function Workspace:MoveToMonitor(monitor)
    hl.dispatch(hl.dsp.workspace.move({monitor = monitor.name, workspace = self.hlw}))
end

function Workspace:ChangeLayout(layout)
    local _state = self.repo:GetState(self.id)
    local state

    if _state then
        state = Utils.CopyTable(_state)
    else
        state.layout = layout
    end

    state.layout = layout

    self:UpdateState(state)
end

function Workspace:GetLayout()
    return self.repo:GetState(self.id).layout
end

return Workspace