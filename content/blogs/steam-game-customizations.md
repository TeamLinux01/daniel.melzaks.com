+++
title = 'Steam game customizations'
date = 2023-03-24T12:00:00-04:00
draft = false
+++

This post is going to be used so I don't forget what settings and other tweaks I use for my desktops and Steam Deck.

# Generic

## Final Fantasy XIII

### Steam Properties

Launch Options: `PROTON_FORCE_LARGE_ADDRESS_AWARE=1 DXVK_ASYNC=1 %command%`

### Modifications

[FF13Fix](https://github.com/rebtd7/FF13Fix/releases)

FF13Fix.ini

```
[Options]
PresentationInterval = 0
TripleBuffering = -1
FullScreenRefreshRate = 0
SwapEffect = -1
AlwaysActive = false
AutoFix = true
Multisample = 0
HideCursor = false
ForceHideCursor = false
BehaviorFlags = 0

[FFXIII]
IngameFrameRateLimit = 0
DiscardUIVertexBuffer = false
DisableIngameControllerHotSwapping = true
EnableControllerVibration = true
VibrationStrengthFactor = 2.000000

[Adapter]
Adapter = false
VendorId = 0
DeviceId = 0

[Window]
TopMost = false
WindowClass =
WindowName =

[Borderless]
Borderless = false
ForceWindowedMode = false
AllWindows = false

[Version]
Config = 6
```

# Gaming PC (Intel Core i7 4790, AMD Radeon RX 580 8GB)

Any time there is a symbolic link that needs to be created, delete the folder first.

## Battle.net Game Settings

Install the Launcher and each game to `Z:\home\dmelzak\Games\Steam\`

### Battle.net

#### App

ON GAME LAUNCH: `Exit Battle.net completely`
Show a brief countdown instead of closing immediately: `unchecked`
WHEN CLICKING X (CLOSE WINDOW): `Exit Battle.net completely`
Launch Battle.net when I start my computer: `unchecked`

#### Downloads

DEFAULT INSTALL DIRECTORY: `Z:\home\dmelzak\Games\Steam\`
Automatically create a desktop icon for games during installation: `unchecked`
Automatic Updates: `Never automatically apply updates`

### Battle.net Steam Properties

#### Battle.net

```
"/home/dmelzak/Games/Steam/Battle.net/Battle.net.exe"
/home/dmelzak/Games/Steam/Battle.net/
STEAM_COMPAT_DATA_PATH=/home/dmelzak/Games/Steam/Prefixes/Battle.net gamemoderun %command%
```

#### Diablo III

```
"/home/dmelzak/Games/Steam/Battle.net/Battle.net.exe" --exec="launch D3"
/home/dmelzak/Games/Steam/Battle.net/
STEAM_COMPAT_DATA_PATH=/home/dmelzak/Games/Steam/Prefixes/Battle.net gamemoderun %command%
```

#### Hearthstone

```
"/home/dmelzak/Games/Steam/Battle.net/Battle.net.exe" --exec="launch WTCG"
/home/dmelzak/Games/Steam/Battle.net/
STEAM_COMPAT_DATA_PATH=/home/dmelzak/Games/Steam/Prefixes/Battle.net gamemoderun %command%
```

#### Heroes of the Storm

```
"/home/dmelzak/Games/Steam/Battle.net/Battle.net.exe" --exec="launch Hero"
/home/dmelzak/Games/Steam/Battle.net/
STEAM_COMPAT_DATA_PATH=/home/dmelzak/Games/Steam/Prefixes/Battle.net gamemoderun %command%
```

#### Overwatch 2

```
"/home/dmelzak/Games/Steam/Battle.net/Battle.net.exe" --exec="launch Pro"
/home/dmelzak/Games/Steam/Battle.net/
STEAM_COMPAT_DATA_PATH=/home/dmelzak/Games/Steam/Prefixes/Battle.net gamemoderun %command%
```

#### StarCraft

```
"/home/dmelzak/Games/Steam/Battle.net/Battle.net.exe" --exec="launch S1"
/home/dmelzak/Games/Steam/Battle.net/
STEAM_COMPAT_DATA_PATH=/home/dmelzak/Games/Steam/Prefixes/Battle.net gamemoderun %command%
```

#### StarCraft 2

```
"/home/dmelzak/Games/Steam/Battle.net/Battle.net.exe" --exec="launch S2"
/home/dmelzak/Games/Steam/Battle.net/
STEAM_COMPAT_DATA_PATH=/home/dmelzak/Games/Steam/Prefixes/Battle.net gamemoderun %command%
```
