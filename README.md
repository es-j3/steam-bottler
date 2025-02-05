# Steam-BSD-Runtime

## Steam on FreeBSD has never been easier!
> FreeBSD 13.2+ (FreeBSD 14.1 and up highly recommended)

## Dependencies
```su -l root -c 'pkg install wine-proton wine zenity git' && /usr/local/wine-proton/bin/pkg32.sh install wine-proton wine mesa-dri```

## Installation
Install Steam BSD runtime in just 3 easy steps!

Run as root: ```git clone https://github.com/es-j3/Steam-BSD-Runtime.git ~/Steam-BSD-Runtime```

Run as root: ```cd ~/Steam-BSD-Runtime/games/Steam-BSD-Runtime/ && make install clean && rm -rf ~/Steam-BSD-Runtime```

Run as regular user: ```steam-bsd-runtime-installer```

## Uninstallation
As regular user: ```steam-bsd-runtime-uninstaller```

## Current Limitations
No steam overlay

If Steam crashes for you often, go to Steam Settings < Interface < Untick "Enable Hardware video Decoding"

## Extras
[Working Games / Not working Games](https://github.com/es-j3/Steam-BSD-Runtime/blob/main/docs/Verified-Games.md)

[Patched Proton](https://github.com/es-j3/Steam-BSD-Runtime/blob/main/docs/Patched-Proton.md)

## Credits:
Two lines and general inspiration of the script are from Alexander Vereeken's Mizutamari: https://codeberg.org/Alexander88207/Mizutamari

Wine-proton by shkhln: https://www.freshports.org/emulators/wine-proton/

Proton patched for UE games by Katharine Chui: https://gitlab.winehq.org/wine/wine/-/merge_requests/5213/diffs https://gitlab.winehq.org/katharinechui

> (C) 2025 es-j3
