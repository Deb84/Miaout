local workspace = require("miaout.workspace")
local layout = require("miaout.layout")
local window = require("miaout.window")

local M = {}

function M.Init()
    local Instances = {}

    Instances.layout = layout.new()
    Instances.window = window.new()
    Instances.workspace = workspace.new(Instances.layout, Instances.window)

    return Instances
end

return M