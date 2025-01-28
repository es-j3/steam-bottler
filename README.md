# Steam-BSD-Runtime

## Steam on FreeBSD has never been easier!

Requirements: Zenity, the GUI frontend used by this project

```pkg install zenity```

1. ```fetch https://raw.githubusercontent.com/coolerguy71/Steam-BSD-Runtime/main/steam-bsd-runtime-install```

2. ```chmod +x steam-bsd-runtime-install```

3. ```./steam-bsd-runtime-install```

4. ```setup (fully interactive)```

5. happy gaming!


## Current Limitations
- No Steam overlay
- Steam might randomly crash when not active in window (doesn't apply if you're playing a steam game and active in that)


## Uninstallation
1. ```rm -rf /usr/local/bin/steam-bsd-runtime /usr/local/bin/steam-bsd-runtime-oss```

2. ```rm -rf ~/.local/share/applications/Steam-BSD-Runtime-OSS.desktop ~/.local/share/applications/Steam-BSD-Runtime-OSS.desktop ~/steam-bsd-runtime-install```

3. ```rm -rf .proton``` this _removes_ all of your steam data! think twice!

4. ```pkg remove zenity wine-proton wine-devel```


(C) 2025 es-j3

Credit where it's due:

Two lines of the script are from Alexander Vereeken's Mizutamari

Proton patched for UE games from: https://gitlab.winehq.org/wine/wine/-/merge_requests/5213/diffs
