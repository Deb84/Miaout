# Miaout
A really simple *overengeeneried* workspace/window "manager" for hyprland lua config

## Setup
```lua
local miaout = require("miaout")
```

```lua
miaout = miaout.Init()
```
> [!IMPORTANT]
> **`hl.config({...})` need to be set before `miaout = miaout.Init()`**

## Config
See config docs [Here](./Docs/CONFIG.md)

## Bind usage
```lua
hl.bind("KEY(S)", function()
  miaout.scope.func
end)
```

## Methods

### Workspace

**Some methods need a HL.Workspace as argument, to use the current workspace:**
```lua
miaout.workspace.current:method()
```

```lua
miaout.workspace:NewWorkspace()
```
Create a new workspace

#### Navigation

```lua
miaout.workspace:NextWorkspace()
```
Focus the next workspace (e+1)
```lua
miaout.workspace:PrevWorkspace()
```
Focus the next workspace (e-1)

```lua
miaout.workspace:NextMonitorWorkspace()
```
Focus the next monitor workspace (m+1)

```lua
miaout.workspace:PrevMonitorWorkspace()
```
Focus the next monitor workspace (m-1)

```lua
miaout.workspace:MoveToNextMonitor(workspace)
```
Move the workspace to the next monitor

```lua
miaout.workspace:MoveToPrevMonitor(workspace)
```
Move the workspace to the previous monitor

```lua
miaout.workspace:MoveToMonitor(workspace, monitor)
```
Move the workspace to a monitor

#### Layouts

```lua
miaout.workspace:NextLayout(workspace)
```
Apply next layout to a workspace

```lua
miaout.workspace:PrevLayout(workspace)
```
Apply previous layout to a workspace

```lua
miaout.workspace:DefaultLayout(workspace)
```
Apply the default layout to a workspace

### Window

**Some methods need a HL.Winfow as argument, to use the current window:**
```lua
miaout.window.current:method()
```
#### Navigation

```lua
miaout.window:MoveToNextWorkspace(window)
```
Move the window to the next workspace
```lua
miaout.window:MoveToPrevWorkspace(window)
```
Move the window to the previous workspace

```lua
miaout.window:MoveToNextMonitorWorkspace(window)
```
Move the window to the next monitor workspace

```lua
miaout.window:MoveToPrevMonitorWorkspace(window)
```
Move the window to the previous monitor workspace

```lua
miaout.window:MoveToNextMonitor(window)
```
Move the window to the next monitor

```lua
miaout.window:MoveToPrevMonitor(window)
```
Move the window to the previous monitor

```lua
miaout.window:SwapWindows(windowA, windowB)
```
Swap `windowA` with `windowB` (with current, swap with the last active window)

#### Fullscreen States

```lua
miaout.window:Fullscreen(window)
```
Puts the window in full screen (toggle switch)

```lua
miaout.window:Maximise(window)
```
Maximise the window (toggle switch)

```lua
miaout.window:Default(window)
```
Reset the window fullscreen state to the default value

```lua
miaout.window:UpScale(window)
```
Enlarge the window size according to the config

```lua
miaout.window:DownScale(window)
```
Reduce the window size according to the config
