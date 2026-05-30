local Instance = {}
Instance.__index = Instance

function Instance.new(hl, workspace)
    local self = setmetatable({}, Instance)
    self.hl = hl
    self.workspace = workspace

    return self
end

function Instance:MoveToNextWorkspace()
    local workspaceMove = "e+1"
    self.hl.dispatch(self.hl.dsp.window.move({ workspace = workspaceMove}))
    self.workspace:SwitchWorkspace(workspaceMove)
end

function Instance:MoveToPrevWorkspace()
    local workspaceMove = "e-1"
    self.hl.dispatch(self.hl.dsp.window.move({ workspace = workspaceMove}))
    self.workspace:SwitchWorkspace(workspaceMove)
end

function Instance:SwapWindow()
    local hl = self.hl

    local last = hl.get_last_window()

    hl.dispatch(hl.dsp.window.swap({target = last}))
    hl.dispatch(hl.dsp.window.bring_to_top())
end

return Instance
