local Utils = {} ---@class Utils

function Utils.CopyTable(t)
    local new = {}

    for i, v in ipairs(t) do
        new[i] = v
    end

    return new
end

function Utils.TableLength(t)
    local count = 0

    for _ in pairs(t) do
        count = count + 1
    end

    return count
end

return Utils