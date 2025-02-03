# Steam-BSD-Runtime

## Steam on FreeBSD has never been easier!

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
if Steam crashes for you often, go to Steam Settings < Interface < Untick "Enable Hardware video Decoding"

## Patched Proton
Do some of your games not work? You may want to try the prebuilt Proton Experimental versions available in the releases tab, which also provides a patch for Unreal Engine games on FreeBSD. 

> Make sure wine is COMPLETELY killed before running this.
Don't make your home directory a mess: ```cd /tmp```

Fetch the 64 bit release: ```fetch https://github.com/es-j3/Steam-BSD-Runtime/releases/download/proton-patch-v1.0.5/wine-proton-e.9.0.20250121-amd64.pkg```

Fetch the 32 bit release: ```fetch https://github.com/es-j3/Steam-BSD-Runtime/releases/download/proton-patch-v1.0.5/wine-proton-e.9.0.20250121-i386.pkg```

Remove vanilla wine-proton: ```su -l root -c 'pkg remove -y -f wine-proton'```

Install patched Proton Experimental: ```su -l root -c 'pkg install -y /tmp/wine-proton-e.9.0.20250121-amd64.pkg'``` 

Remove vanilla wine-proton (32 bit): ```/usr/local/share/wine/pkg32.sh remove -y wine-proton```

Install patched Proton Experimenal (32 bit): ```/usr/local/share/wine/pkg32.sh install -y /tmp/wine-proton-e.9.0.20250121-i386.pkg```

Now, we will need to refresh our prefix because of a different version of Proton:

![image](https://github.com/user-attachments/assets/f458f447-3d64-447d-89c7-bc9444ac8606)

Cheers!

## Credits:
Two lines and general inspiration of the script are from Alexander Vereeken's Mizutamari: https://codeberg.org/Alexander88207/Mizutamari

Wine-proton by shkhln: https://www.freshports.org/emulators/wine-proton/

Proton patched for UE games by Katharine Chui: https://gitlab.winehq.org/wine/wine/-/merge_requests/5213/diffs https://gitlab.winehq.org/katharinechui

> (C) 2025 es-j3
