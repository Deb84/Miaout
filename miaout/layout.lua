local Instance = {}
Instance.__index = Instance

function Instance.new(hl)
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
    self.hl = hl
    self.layouts = layouts
    self.layoutIndex = layoutIndex

    self.defaultLayout = defaultLayout
    self.lastLayout = defaultLayout

    return self
end

function GetIndexFromLayout(layoutIndex, layout)
    return layoutIndex[layout]
end

function Instance:GetCurrentLayout()
    return self.hl.get_config("general.layout")
end

function Instance:ChangeLayout(newLayout)
    self.hl.config({
        general = {layout = newLayout}
    })
end

function Instance:SwitchNextLayout()
    self.lastLayout = self:GetCurrentLayout()

    local nextLayoutIndex = self.layoutIndex[self.lastLayout] + 1

    if nextLayoutIndex > #self.layouts then
        nextLayoutIndex = 1
    end

    local nextLayout = self.layouts[nextLayoutIndex]

    self:ChangeLayout(nextLayout)
end

function Instance:SwitchPrevLayout()
    self.lastLayout = self:GetCurrentLayout()

    local nextLayoutIndex = self.layoutIndex[self.lastLayout] - 1

    if nextLayoutIndex == 0 then
        nextLayoutIndex = #self.layouts
    end

    local nextLayout = self.layouts[nextLayoutIndex]

    self:ChangeLayout(nextLayout)
end

function Instance:SwitchLastLayout()
    local nextLastLayout = self:GetCurrentLayout()

    self:ChangeLayout(self.lastLayout)

    self.lastLayout = nextLastLayout
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

    self:ChangeLayout(newLayout)
end

return Instance
