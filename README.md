# Steam-BSD-Runtime

## Steam on FreeBSD has never been easier!

## Dependencies: 
```pkg install wine-proton wine winetricks zenity```

### Installation
Straight from github: ```fetch https://raw.githubusercontent.com/es-j3/Steam-BSD-Runtime/main/steam-bsd-runtime-installer && chmod +x steam-bsd-runtime-installer && ./steam-bsd-runtime-installer```
From ports (when it's available): ```pkg install -y steam-bsd-runtime && steam-bsd-runtime-installer```

### Configuration
You can configure Steam-BSD-Runtime with the ```steam-bsd-runtime-configurator``` script
Straight from github: ```fetch https://raw.githubusercontent.com/es-j3/Steam-BSD-Runtime/main/steam-bsd-runtime-configurator && chmod +x steam-bsd-runtime-configuratior && ./steam-bsd-runtime-configurator```
From ports (when it's available): ```steam-bsd-runtime configurator```

### Uninstallation
You can uninstall Steam-BSD-Runtime with the ```steam-bsd-runtime-uninstaller``` script
Straight from github: ```fetch https://raw.githubusercontent.com/es-j3/Steam-BSD-Runtime/main/steam-bsd-runtime-uninstaller && chmod +x steam-bsd-runtime-uninstaller && ./steam-bsd-runtime-uninstaller```
From ports (when it's available): ```steam-bsd-runtime-uninstaller && pkg remove steam-bsd-runtime```

## Current Limitations
- No Steam overlay
- Steam might randomly crash when not active in window (doesn't apply if you're playing a steam game and active in that)


> (C) 2025 es-j3

## Acknowledgements:

Two lines and general inspiration of the script are from Alexander Vereeken's Mizutamari: https://codeberg.org/Alexander88207/Mizutamari

Wine-proton by shkhln: https://www.freshports.org/emulators/wine-proton/

Proton patched for UE games from: https://gitlab.winehq.org/wine/wine/-/merge_requests/5213/diffs
