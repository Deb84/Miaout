local Events = {}

---@param wm WorkspaceManager
function Events.Subscribe(wm)
    hl.on("workspace.active", function(hlw) ---@param hlw HL.Workspace
        wm:GetOrNewWorkspace(hlw):LoadState()
    end)

    hl.on("workspace.removed", function(hlw) ---@param hlw HL.Workspace
        wm:RemoveWorkspace(hlw.id)
    end)

    hl.on("workspace.move_to_monitor", function(hlw) ---@param hlw HL.Workspace
        wm:GetOrNewWorkspace(hlw):LoadState()
    end)

    hl.on("workspace.created", function(hlw) ---@param hlw HL.Workspace
        wm:GetOrNewWorkspace(hlw):UpdateState()
    end)
end

return Events
