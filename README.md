# Miaout
A really simple layout/workspace/window "manager" for hyprland lua config

## Setup
```lua
local miaout = require("miaout")
```

```lua
miaout = miaout.Init(hl)
```
> [!IMPORTANT]  
> **`hl.config({general = {layout = ...}})` need to be set before `miaout = miaout.Init(hl)`**

## Bind usage
```lua
hl.bind("KEY(S)", function()
  miaout.scope.func
end
```

## Functions

### Layout
```lua
miaout.layout:SwitchNextLayout()
```
Switch to the next layout
```lua
miaout.layout:SwitchLastLayout()
```
Switch to the last layout
```lua
miaout.layout:SwitchPrevLayout()
```
Switch to the previous layout
```lua
miaout.layout:SwitchDefaultLayout()
```
Switch to your default layout (see the the note above)

### Workspace
```lua
miaout.workspace:NewWorkspace()
```
Create a new workspace
```lua
miaout.workspace:SwitchNextWorkspace()
```
Switch to the next workspace (e+1)
```lua
miaout.workspace:SwitchPreviousWorkspace()
```
Switch to the next workspace (e-1)
```lua
miaout.workspace:SwitchNextMonitorWorkspace()
```
Switch to the next monitor workspace (m+1)
```lua
miaout.workspace:SwitchPrevMonitorWorkspace()
```
Switch to the next monitor workspace (m-1)
```lua
miaout.workspace:MoveWorkspaceMonitor()
```
Move the workspace to the next Monitor

### Window
```lua
miaout.window:MoveToNextWorkspace()
```
Move the active window to the next workspace
```lua
miaout.window:MoveToPrevWorkspace()
```
Move the active window to the previous workspace
```lua
miaout.window:SwapWindows()
```
Swap the active window with the last active window
```lua
miaout.window:SwapWindowMonitor()
```
Swap the active window to the next monitor
```lua
miaout.window:Fullscreen()
```
Puts the active window in full screen (toggle switch)
```lua
miaout.window:Maximise()
```
Maximise the active window (toggle switch)
```lua
miaout.window:Maximise()
```
Reset the window fullscreen state to the default value


