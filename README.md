![418460607-fb25d1d8-880c-42ab-8966-b8358d97319e](https://github.com/user-attachments/assets/0f05916d-229c-4ae5-ad59-7f61fdc21fd1)
### So, how does this work?
This project utilizes Proton to run the latest version of Steam on FreeBSD. It is installed with Wine, and ran with Proton.

Want to know more? Feel free to look at the source (It's quite basic).
### Installation

```fetch https://raw.githubusercontent.com/es-j3/steam-bottler/main/pkg/steam-bottler-1.0.6.pkg```

```pkg install ./steam-bottler-1.0.6.pkg```

```steam-bottler install```

If you want the absolute latest releases of the project, then run:

```fetch https://raw.githubusercontent.com/es-j3/steam-bottler/main/src/steam-bottler```

```cp steam-bottler /usr/local/bin/steam-bottler```

```chmod +x /usr/local/bin/steam-bottler```

### Uninstallation
```steam-bottler remove```

### HELP! Steam is closing/freezing randomly. What do I do?
Currently, there is no direct fix to this. So far, I have been able to narrow it down to something Pulseaudio-related.

While you are playing games or active in the Steam window, Steam shouldn't freeze.

If you are downloading a game or leaving it open long term, then close Steam and run ```steam-bottler configure``` < ```Launch Steam with no sound``` and your problems should _hopefully_ be fixed.

### Extras
[Working Games / Not working Games](https://github.com/es-j3/steam-bottler/blob/main/docs/Verified-Games.md)

Made by es-j3.
