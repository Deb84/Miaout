local Config = {} ---@class MiaoutConfig
Config.__index = Config

function Config.new()
    local self = setmetatable({}, Config)

    Config.window = {
        default = {client = 0, internal = 0},
        maximise = {client = 1, internal = 1},
        fullscreen = {client = 1, internal = 2},
    }

    Config.workspace = {
        nextWorkspaceSelector = "e+1",
        prevWorkspaceSelector = "e-1",
        nextMonitorWorkspaceSelector = "m+1",
        prevMonitorWorkspaceSelector = "m-1" ,
        defaultLayout = hl.get_config("general.layout"),
        layouts = {
            "dwindle",
            "master",
            "scrolling",
            "monocle"
        }
    }

    Config.notifications = {
        prefix = "MIAOUT ",
        displayTimeMs = 3000,
    }

    return self
end

return Config