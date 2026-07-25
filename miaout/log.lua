

---@class Log
local Log = {}
Log.__index = Log

function Log.new(config)
    local self = setmetatable({}, Log)

    self.config = config.notifications

    return self
end


---@param level string
---@param ... string
function Log:format(level, ...)
    local text = string.format("%s %s", self.config.prefix, level, ...)
    return text
end

function Log:Error(...)
    local text = self:format(...)
    hl.notification.create({text = text, timeout = self.config.displayTimeMs, color = "0xffff0000"})
end

function Log:Info(...)
    local text = self:format(...)
    hl.notification.create({text = text, timeout = self.config.displayTimeMs})
end

return Log