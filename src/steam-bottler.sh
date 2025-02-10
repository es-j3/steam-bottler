#!/bin/sh

if [ "$(id -u)" = 0 ]; then
  echo "Don't run this as root, root will be called once needed."
  exit 1
fi

COMMAND="$1"
PROTON_DIR="~/.proton"

case "$COMMAND" in
  "")
    if [ ! -d "$PROTON_DIR" ]; then
      echo "Looks like steam-bottler isn't installed yet. Install it with 'steam-bottler install'"
      exit 1
    fi
    sh -c 'WINEPREFIX=~/.proton WINE=/usr/local/wine-proton/bin/wine winetricks sound=pulse && WINEPREFIX=~/.proton /usr/local/wine-proton/bin/wine ~/.proton/drive_c/Program\ Files\ \(x86\)/Steam/steam.exe -cef-disable-sandbox -cef-disable-gpu-compositing -cef-in-process-gpu'
    ;;
  "oss")
    if [ ! -d "$PROTON_DIR" ]; then
      echo "Looks like steam-bottler isn't installed yet. Install it with 'steam-bottler install'"
      exit 1
    fi
    sh -c 'WINEPREFIX=~/.proton WINE=/usr/local/wine-proton/bin/wine winetricks sound=oss && WINEPREFIX=~/.proton /usr/local/wine-proton/bin/wine ~/.proton/drive_c/Program\ Files\ \(x86\)/Steam/steam.exe -cef-disable-sandbox -cef-disable-gpu-compositing -cef-in-process-gpu'
    ;;

  "install")
    if [ -d "$PROTON_DIR" ]; then
      if ! zenity --question --text="This appears to be already installed. Continue?"; then
        exit 0
      fi
    fi
    sh -c '
# Launches steam-bottler configurator application
configurator_shortcut() {
    fetch -o ~ https://raw.githubusercontent.com/es-j3/steam-bottler/refs/heads/main/src/icon.png
    xdg-icon-resource install --size 256 ~/icon.png steam-bottler-configurator --novendor
    touch ~/.local/share/applications/steam-bottler-Configurator.desktop
    chmod +x ~/.local/share/applications/steam-bottler-Configurator.desktop
    sh -c 'echo "[Desktop Entry]
Comment=Launches steam-bottler configurator application
Exec=steam-bottler configure
Icon=steam-bottler-configurator
Categories=Game;
Name=Steam Bottler Configurator
StartupNotify=false
Terminal=false
TerminalOptions=
Type=Application" > ~/.local/share/applications/steam-bottler-Configurator.desktop'
    rm -rf ~/icon.png
}

# Launches Steam with OSS instead of Pulse (for source games)
oss_shortcut() {
    touch ~/.local/share/applications/steam-bottler-OSS.desktop
    chmod +x ~/.local/share/applications/steam-bottler-OSS.desktop
    sh -c 'echo "[Desktop Entry]
Comment=Video game store and digital distribution platform among other services (OSS sound service)
Exec=steam-bottler oss
Icon=steam
Categories=Game;
Name=Steam (OSS)
StartupNotify=false
Terminal=false
TerminalOptions=
Type=Application" > ~/.local/share/applications/steam-bottler-OSS.desktop'
}

zenity --info --text="Steam will be downloaded to /tmp."

# Downloads Steam to the /tmp directory
fetch -o /tmp/SteamSetup.exe https://cdn.fastly.steamstatic.com/client/installer/SteamSetup.exe

zenity --info --text="Let's install DXVK and required fonts for Steam and video games to function properly, along with creating our prefix."

# Calls the Proton prefix and the Wine path to be used, then installs dxvk to get 3D acceleration, and corefonts so the Steam UI works properly.
WINEPREFIX=~/.proton WINE=/usr/local/bin/wine winetricks dxvk corefonts

zenity --info --text="The next step will install Steam."

# Calls proton prefix and then tells default wine to run SteamSetup.exe in /tmp directory.
WINEPREFIX=~/.proton /usr/local/bin/wine /tmp/SteamSetup.exe

# Detects when SteamSetup.exe closes and then opens a window that prompt you to click OK when the first Updating Steam is finished to kill Wine.
while pgrep -f "SteamSetup.exe" > /dev/null; do
    sleep 1
done

zenity --info --text="Please click OK 5-10 seconds after the Updating Steam window closes!"

# Kills everything wine-related
pkill -f "wineserver"
pkill -f "system32"
pkill -f "Steam.exe"
pkill -f "steam.exe"
pkill -f "steamwebhelper.exe"

zenity --info --text="Now, let's add a local shortcut for Steam."

# Creates the local applications directory if it doesn't exist already
mkdir -p ~/.local/share/applications

# Creates the local application shortcut
touch ~/.local/share/applications/steam-bottler.desktop

# Makes it executable
chmod +x ~/.local/share/applications/steam-bottler.desktop

# Echoes the contents of the application shortcut to make it point to the script
sh -c 'echo "[Desktop Entry]
Comment=Video game store and digital distribution platform among other services
Exec=steam-bottler
Icon=steam
Categories=Game;
Name=Steam
StartupNotify=false
Terminal=false
TerminalOptions=
Type=Application" > ~/.local/share/applications/steam-bottler.desktop'

if zenity --question --text="Would you like to add an extra application shortcut that launches Steam using the OSS sound server? (Necessary for Audio on many SOURCE games)"; then
    oss_shortcut
else
    zenity --info --text="Alright, let's move on."
fi

if zenity --question --text="Would you like to add a shortcut for the Steam Bottler Configurator?"; then
    configurator_shortcut
else
    zenity --info --text="Alright, let's move on."
fi

if zenity --question --text="Do you want to enable DX12 support?"; then
    WINEPREFIX=~/.proton WINE=/usr/local/wine-proton/bin/wine winetricks vkd3d
else
    zenity --info --text="Alright, let's move on."
fi

# Removes the nonfunctioning shortcut automatically created by Wine
rm -rf ~/.local/share/applications/wine/Programs/Steam/

zenity --info --text="Hello! It appears you have reached the end of the Steam Bottler installer. If you experience any issues, please report them at https://github.com/es-j3/steam-bottler/issues. Thanks for using this program :D"

# Sets the Wineprefix to use pulseaudio instead of ALSA / OSS
WINEPREFIX=~/.proton WINE=/usr/local/wine-proton/bin/wine winetricks sound=pulse

# Patches to make games open in steam (Ripped from Mizutamari)
WINEPREFIX=~/.proton /usr/local/wine-proton/bin/wine $WINEBIN reg.exe ADD "HKEY_CURRENT_USER\Software\Wine\DllOverrides" /v "gameoverlayrenderer" /t "REG_SZ" /d "" /f
WINEPREFIX=~/.proton /usr/local/wine-proton/bin/wine $WINEBIN reg.exe ADD "HKEY_CURRENT_USER\Software\Wine\DllOverrides" /v "gameoverlayrenderer64" /t "REG_SZ" /d "" /f



# Launches Steam finally.
WINEPREFIX=~/.proton /usr/local/wine-proton/bin/wine ~/.proton/drive_c/Program\ Files\ \(x86\)/Steam/steam.exe -cef-disable-sandbox -cef-disable-gpu-compositing -cef-in-process-gpu 
'
    ;;

  "configure")
    if [ ! -d "$PROTON_DIR" ]; then
      echo "Looks like steam-bottler isn't installed yet. Install it with 'steam-bottler install'"
      exit 1
    fi
    sh -c '
    ICO="~/.local/share/icons/hicolor/256x256/apps/steam-bottler-configurator.png"

while true; do
    CHOICE=$(zenity --ok-label="Continue" --cancel-label="Exit" \
        --list --radiolist --window-icon="$ICO" --height=300 --width=400 \
        --title="Steam BSD Runtime Configurator" \
        --text="Configure Steam Bottler with one of the following options" \
        --hide-header \
        --column "Select" --column "Option" \
        FALSE "Uninstall" \
        FALSE "Run an EXE" \
        FALSE "Run winetricks" \
        FALSE "Kill Steam Bottler if it's frozen" \
        FALSE "Refresh the prefix (make sure wine isn't running)")

    if [ -z "$CHOICE" ]; then
        exit 0  # User pressed Exit or closed the window
    fi

    case "$CHOICE" in
        "Uninstall")
            /usr/local/bin/steam-bottler-uninstaller
            ;;

        "Run an EXE")
            EXECUTABLE=$(zenity --file-selection --title="Choose an executable to run")
            if [ -n "$EXECUTABLE" ]; then
                WINEPREFIX=~/.proton /usr/local/wine-proton/bin/wine "$EXECUTABLE" -no-cef-sandbox
            fi
            ;;

        "Run winetricks")
            WINEPREFIX=~/.proton WINE=/usr/local/wine-proton/bin/wine winetricks
            ;;

        "Kill Steam Bottler if it's frozen")
            pkill -f "wineserver"
            pkill -f "system32"
            pkill -f "Steam.exe"
            pkill -f "steam.exe"
            pkill -f "steamwebhelper.exe"
            ;;

        "Refresh the prefix (make sure wine isn't running)")
            WINEPREFIX=~/.proton /usr/local/bin/wineboot -u
            WINEPREFIX=~/.proton /usr/local/wine-proton/bin/wineboot -u
            ;;
    esac
done
'
    ;;

  "remove")
    if [ ! -d "$PROTON_DIR" ]; then
      zenity --info --text="Maybe it was never installed in the first place."
      exit 0
    fi
    sh -c '
    remove_shortcuts() {
  cd ~/
  echo "Removing shortcuts..."
  rm -rf ~/.local/share/applications/steam-bottler-OSS.desktop ~/.local/share/applications/steam-bottler-OSS.desktop ~/.local/share/applications/steam-bottler-Configurator.desktop ~/.local/share/icons/hicolor/256x256/apps/steam-bottler-configurator.png
}
remove_proton() {
  cd ~/
  echo "Removing proton prefix..."
  rm -rf ~/.proton 
}

remove_everything() {
  su -l root -c 'pkg remove steam-bottler'
  rm -rf ~/steam-bottler-installer ~/steam-bottler-uninstaller ~/steam-bottler-configurator
}
if zenity --question --text="Are you sure you want to uninstall steam-bottler?"; then
    remove_shortcuts
else
    zenity --info --text="Uninstallation canceled."
fi

if zenity --question --text="Remove the Proton Prefix? Think twice, as this removes ALL of your Steam data."; then
    remove_proton
else
    sleep 1
fi

if zenity --question --text="Now finally, shall we remove the uninstaller and installer script?"; then
    remove_everything
else
    sleep 1
fi
'
    ;;

  *)
    echo "steam-bottler (run this plain to launch Steam) [oss|install|configure|remove]"
    exit 1
    ;;
esac