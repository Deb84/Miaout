local Events = {}

---@param wm WindowManager
function Events.Subscribe(wm)
    hl.on("window.active", function(hlw) ---@param hlw HL.Window
        -- Hl trigger this event two time, first without an stable_id, second with id
        if not hlw.stable_id then
            return
        end

        wm:GetOrNewWindow(hlw):LoadState()
    end)

    hl.on("window.close", function(hlw) ---@param hlw HL.Window
        wm:RemoveWindow(hlw.stable_id)
    end)

    hl.on("window.fullscreen", function(hlw) ---@param hlw HL.Window
        wm:GetOrNewWindow(hlw):UpdateState()
    end)

    hl.on("window.open", function(hlw) ---@param hlw HL.Window
        wm:GetOrNewWindow(hlw):UpdateState()
    end)

    hl.on("window.pin", function(hlw) ---@param hlw HL.Window
        wm:GetOrNewWindow(hlw):UpdateState()
    end)

    hl.on("window.update_rules", function(hlw) ---@param hlw HL.Window
        wm:GetOrNewWindow(hlw):UpdateState()
    end)
end

return Events
