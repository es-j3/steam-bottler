![418460607-fb25d1d8-880c-42ab-8966-b8358d97319e](https://github.com/user-attachments/assets/0f05916d-229c-4ae5-ad59-7f61fdc21fd1)

### So, how does this work?
This project utilizes Proton to run the latest version of Steam on FreeBSD. It is installed with Wine, and ran with Proton.
Currently, only x11 is confirmed to be stable enough with this project. Mileage with Wayland may vary.

Want to know more? Feel free to look at the source (It's quite basic).

### Installation

```fetch https://github.com/es-j3/steam-bottler/releases/download/1.0.7/steam-bottler-1.0.7.pkg```

```pkg install ./steam-bottler-1.0.7.pkg```

```steam-bottler install```

### Uninstallation
```steam-bottler remove```

### HELP! Steam is closing/freezing randomly. What do I do?
Currently, there is no direct fix to this. So far, I have been able to narrow it down to something Pulseaudio-related.

While you are playing games or active in the Steam window, Steam shouldn't freeze. However, if you move your cursor or resize your window too much, it startles Wine and may freeze Steam because of this.

To kill and reopen it, run ```steam-bottler configure``` < ```Kill steam-bottler if it's frozen```

If you are downloading a game or leaving it open long term, then close Steam and run ```steam-bottler configure``` < ```Launch Steam with no sound``` and your problems should _hopefully_ be fixed.

### Steam is no longer opening for me!
There are many reasons why this can happen. The most common reason I see is upgrading wine-proton or reinstalling it (or adding a patch). For problems like this, I have made a workaround that is available in the steam-bottler configurator window. It is essentially a skimmed installer that "soft-reinstalls" Steam.

To use it, run ```steam-bottler configure``` < ```Soft-reinstall Steam Client (game/save data is preserved)``` and hopefully 90% of your issues will be fixed.

### Extras
[Working Games / Not working Games](https://github.com/es-j3/steam-bottler/blob/main/docs/Verified-Games.md)

[Patched Proton Experimental](https://github.com/FreeBSD-Proton-Experimental-Porters/FreeBSD-Proton-Experimental)

Made by es-j3.
