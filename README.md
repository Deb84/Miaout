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
Switch to the next workspace (current workspace id + 1)
```lua
miaout.workspace:SwitchPreviousWorkspace()
```
Switch to the next workspace (current workspace id - 1)

### Window
```lua
miaout.window:MoveToNextWorkspace()
```
Move the active window to the next workspace
```lua
miaout.window:MoveToPrevWorkspace()
```
Move the active window to the previous workspace
