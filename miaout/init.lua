local workspace = require("miaout.workspace")
local layout = require("miaout.layout")
local window = require("miaout.window")

local M = {}

function M.Init(hl)
    local Instances = {}

    Instances.layout = layout.new(hl)
    Instances.workspace = workspace.new(hl, Instances.layout)
    Instances.window = window.new(hl, Instances.workspace)

    return Instances
end

return M
