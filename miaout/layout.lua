local Instance = {}
Instance.__index = Instance

function Instance.new()
    local defaultLayout = hl.get_config("general.layout")

    local layouts = {
        [1] = "dwindle",
        [2] = "master",
        [3] = "scrolling",
        [4] = "monocle",
    }

    local layoutIndex = {}

    for i, v in ipairs(layouts) do
        layoutIndex[v] = i
    end

    local self = setmetatable({}, Instance)
    self.layouts = layouts
    self.layoutIndex = layoutIndex

    self.defaultLayout = defaultLayout
    self.lastLayout = defaultLayout

    return self
end

function Instance:GetCurrentLayout()
    return hl.get_config("general.layout")
end

function Instance:UpdateLayout(newLayout)
    hl.config({
        general = {layout = newLayout}
    })
end

function Instance:SwitchLayout(step)
    self.lastLayout = self:GetCurrentLayout()
    local currentIndex = self.layoutIndex[self.lastLayout]
    local layoutLength = #self.layouts

    local nextIndex =((currentIndex - 1 + step) % layoutLength) + 1

    self:UpdateLayout(self.layouts[nextIndex])
end

function Instance:SwitchNextLayout()
    self:SwitchLayout(1)
end

function Instance:SwitchPrevLayout()
    self:SwitchLayout(-1)
end

function Instance:SwitchLastLayout()
    local currentLayout = self:GetCurrentLayout()

    self:UpdateLayout(self.lastLayout)

    self.lastLayout = currentLayout
end

function Instance:SwitchDefaultLayout()
    local currentLayout = self:GetCurrentLayout()
    local newLayout

    if currentLayout ~= self.defaultLayout then

        newLayout = self.defaultLayout
        self.lastLayout = currentLayout
    else
        newLayout = self.lastLayout
        self.lastLayout = currentLayout
    end

    self:UpdateLayout(newLayout)
end

return Instance