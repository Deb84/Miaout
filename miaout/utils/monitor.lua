local Utils = require("miaout.utils.utils")

local Monitor = {} ---@class MonitorUtils


function Monitor.GetMonitorsOrdered()
    local monitors = hl.get_monitors()
    local monitorsAscending = Utils.CopyTable(monitors)

    table.sort(monitorsAscending, function (a, b)
        return a.id < b.id
    end)

    return monitorsAscending, #monitors
end

function Monitor.GetMonitorOrderedId(monitorId)
    local monitors = Monitor.GetMonitorsOrdered()

    for id, monitor in ipairs(monitors) do
        if monitor.id == monitorId then
            return id
        end
    end

    return nil
end

function Monitor.GetMonitorFromOrderedId(monitorId)
    local monitors = Monitor.GetMonitorsOrdered()

    return monitors[monitorId]
end

function Monitor:GetTargetMonitor(func)
    local monitor = hl.get_active_monitor()
    if not monitor then return end

    local monitorsLen = #hl.get_monitors()
    if monitorsLen == 0 then return end

    local monitorId = self.GetMonitorOrderedId(monitor.id)
    if not monitorId then return end

    local nextMonitorId = func(monitorId, monitorsLen)
    local nextMonitor = self.GetMonitorFromOrderedId(nextMonitorId)

    return nextMonitor
end

function Monitor:GetNextMonitor()
    local func = function (monitorId, monitorsLen)
        return ((monitorId + 1 + 1) % monitorsLen) + 1
    end

    return self:GetTargetMonitor(func)
end

function Monitor:GetPrevMonitor()
    local func = function (monitorId, monitorsLen)
        return ((monitorId + 1 - 1) % monitorsLen) + 1
    end

    return self:GetTargetMonitor(func)
end





return Monitor