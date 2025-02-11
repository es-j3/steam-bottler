# steam-bottler

## Steam on FreeBSD has never been easier!
> FreeBSD 13.2+ (FreeBSD 14.1 and up highly recommended)

<details>
<summary>Want to use Wine-Devel instead?</summary>

If you installed this previously with regular wine, please do a full uninstall with ```steam-bottler remove```

Dependencies: ```su -l root -c 'pkg install wine-proton wine-devel winetricks zenity git' && /usr/local/wine-proton/bin/pkg32.sh install wine-proton wine-devel mesa-dri```

Install steam-bottler (using wine-devel instead) in just 3 easy steps!

Run as root: ```git clone https://github.com/es-j3/steam-bottler.git ~/steam-bottler```

Run as root: ```cd ~/steam-bottler/games/steam-bottler-devel/ && make install clean && rm -rf ~/steam-bottler```

Run as regular user: ```steam-bottler install```

## Uninstallation
As regular user: ```steam-bottler remove```

</details>

## Dependencies
```su -l root -c 'pkg install wine-proton wine winetricks zenity git' && /usr/local/wine-proton/bin/pkg32.sh install wine-proton wine mesa-dri```

## Installation
Install steam-bottler in just 3 easy steps!

Run as root: ```git clone https://github.com/es-j3/steam-bottler.git ~/steam-bottler```

Run as root: ```cd ~/steam-bottler/games/steam-bottler/ && make install clean && rm -rf ~/steam-bottler```

Run as regular user: ```steam-bottler install```

## Uninstallation
As regular user: ```steam-bottler remove```

## Current Limitations
No steam overlay

If Steam crashes for you often, go to Steam Settings < Interface < Untick "Enable Hardware video Decoding"

## Extras
[Working Games / Not working Games](https://github.com/es-j3/steam-bottler/blob/main/docs/Verified-Games.md)

[Patched Proton](https://github.com/es-j3/FreeBSD-Proton-Experimental)

## Credits:
Two lines and general inspiration of the script are from Alexander Vereeken's Mizutamari: https://codeberg.org/Alexander88207/Mizutamari

Wine-proton by shkhln: https://www.freshports.org/emulators/wine-proton/

Proton patched for UE games by Katharine Chui: https://gitlab.winehq.org/wine/wine/-/merge_requests/5213/diffs https://gitlab.winehq.org/katharinechui

> (C) 2025 es-j3
