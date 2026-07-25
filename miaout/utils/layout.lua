local Layout = {} ---@class LayoutUtils


function Layout.GetTargetLayout(layouts, layout, func)
    local layoutId

    for i, v in ipairs(layouts) do
        if v == layout then
            layoutId = i
        end
    end

    local nextLayoutId = func(layoutId, #layouts)

    return layouts[nextLayoutId]
end

function Layout:GetNextLayout(layouts, layout)
    local func = function (layoutId, layoutsLen)
        return ((layoutId - 1 + 1) % layoutsLen) + 1
    end

    return self.GetTargetLayout(layouts, layout, func)
end

function Layout:GetPrevLayout(layouts, layout)
    local func = function (layoutId, layoutsLen)
        return ((layoutId - 1 - 1) % layoutsLen) + 1
    end

    return self.GetTargetLayout(layouts, layout, func)
end


return Layout