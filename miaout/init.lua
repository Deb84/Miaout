local workspace = require("miaout.workspace")
local layout = require("miaout.layout")
local window = require("miaout.window")

local M = {}

function M.Init(hl)
    local Instance = {}

    Instance.layout = layout.new(hl)
    Instance.workspace = workspace.new(hl, Instance.layout)
    Instance.window = window.new(hl, Instance.workspace)

    return Instance
end

return M
