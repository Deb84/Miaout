local WindowUtils = {} ---@class WindowUtils

function WindowUtils.CompareFullscreenState(a, b)
    return a.internal == b.internal and a.client == b.client
end

return WindowUtils