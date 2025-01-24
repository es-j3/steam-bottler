#!/bin/sh

# Installs dependencies if needed
install_dependencies() {
    su -l root -c 'pkg install -y wine-devel winetricks wine-proton'
    sh -c "/usr/local/share/wine/pkg32.sh install -y wine-proton wine-devel mesa-dri"
}

# Patches Proton for UE Games https://gitlab.winehq.org/wine/wine/-/merge_requests/5213/diffs#d5bcbaed4ae76fff7d2641017921e07798a7da0e_807_807
patch_proton() {
    cd /tmp
    fetch https://github.com/es-j3/Steam-BSD-Runtime/releases/download/proton-patch-v1.0.5/wine-proton-e.9.0.20250121-amd64.pkg
    fetch https://github.com/es-j3/Steam-BSD-Runtime/releases/download/proton-patch-v1.0.5/wine-proton-e.9.0.20250121-i386.pkg
    echo "Removing vanilla wine-proton..."
    su -l root -c 'pkg remove -y wine-proton'
    echo "Installing patched wine-proton..."
    su -l root -c 'pkg install -y /tmp/wine-proton-e.9.0.20250121-amd64.pkg' 
    cd
    echo "Removing vanilla wine-proton (i386)..."
    /usr/local/share/wine/pkg32.sh remove -y wine-proton
    echo "Installing patched wine-proton (i386)..."
    /usr/local/share/wine/pkg32.sh install -y /tmp/wine-proton-e.9.0.20250121-i386.pkg
}

# Launches Steam with OSS instead of Pulse (for source games)
oss_shortcut() {
    echo "Adding steam-bsd-runtime-oss to PATH..."
    su -l root -c 'touch /usr/local/bin/steam-bsd-runtime-oss'
    echo "Filling launcher contents..."
    su -l root -c 'echo "WINEPREFIX=~/.proton WINE=/usr/local/wine-proton/bin/wine winetricks sound=oss && WINEPREFIX=~/.proton /usr/local/wine-proton/bin/wine ~/.proton/drive_c/Program\ Files\ \(x86\)/Steam/steam.exe -cef-disable-sandbox -cef-disable-gpu-compositing -cef-in-process-gpu" > /usr/local/bin/steam-bsd-runtime-oss'
    echo "Making launcher executable..."
    su -l root -c 'chmod +x /usr/local/bin/steam-bsd-runtime-oss'
    touch ~/.local/share/applications/Steam-BSD-Runtime-OSS.desktop
    chmod +x ~/.local/share/applications/Steam-BSD-Runtime-OSS.desktop
    sh -c 'echo "[Desktop Entry]
Comment=Video game store and digital distribution platform among other services (OSS sound service)
Exec=steam-bsd-runtime-oss
Icon=steam
Categories=Game;
Name=Steam (OSS)
StartupNotify=false
Terminal=false
TerminalOptions=
Type=Application" > ~/.local/share/applications/Steam-BSD-Runtime-OSS.desktop'
}

if zenity --question --text="Would you like to install wine-devel, winetricks and wine-proton? They are dependencies needed."; then
    install_dependencies
else
    zenity --info --text="Installation canceled."
    exit 0
fi

if zenity --question --text="Would you like to install the experimental branch of Proton? (With UE Multithread Patch, FreeBSD 14.2) "; then
    patch_proton
else
    zenity --info --text="Alright, let's move on."
fi

zenity --info --text="Steam will be downloaded to /tmp."

# Downloads Steam to the /tmp directory
fetch -o /tmp/SteamSetup.exe https://cdn.fastly.steamstatic.com/client/installer/SteamSetup.exe

zenity --info --text="Let's install DXVK for Steam and video games to function properly, along with creating our prefix."

# Calls the Proton prefix and the Wine path to be used, then installs dxvk to get 3D acceleration in Wine.
WINEPREFIX=~/.proton WINE=/usr/local/bin/wine winetricks dxvk

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
pkill -f "Steam.exe
pkill -f "steam.exe"
pkill -f "steamwebhelper.exe"

zenity --info --text="Now, let's add a shortcut for Steam. You will get 3 consecutive root password prompts."

# Creates the local applications directory if it doesn't exist already
mkdir -p ~/.local/share/applications

# Calls super user permissions to create the steam-bsd-runtime application.
echo "Adding steam-bsd-runtime to PATH..."
su -l root -c 'touch /usr/local/bin/steam-bsd-runtime'

# Calls super user to echo the contents of the script.
echo "Filling launcher contents..."
su -l root -c 'echo "WINEPREFIX=~/.proton WINE=/usr/local/wine-proton/bin/wine winetricks sound=pulse && WINEPREFIX=~/.proton /usr/local/wine-proton/bin/wine ~/.proton/drive_c/Program\ Files\ \(x86\)/Steam/steam.exe -cef-disable-sandbox -cef-disable-gpu-compositing -cef-in-process-gpu" > /usr/local/bin/steam-bsd-runtime'

# Makes the script executable
echo "Making launcher executable..."
su -l root -c 'chmod +x /usr/local/bin/steam-bsd-runtime'

# Creates the local application shortcut
touch ~/.local/share/applications/Steam-BSD-Runtime.desktop

# Makes it executable
chmod +x ~/.local/share/applications/Steam-BSD-Runtime.desktop

# Echoes the contents of the application shortcut to make it point to the script
sh -c 'echo "[Desktop Entry]
Comment=Video game store and digital distribution platform among other services
Exec=steam-bsd-runtime
Icon=steam
Categories=Game;
Name=Steam
StartupNotify=false
Terminal=false
TerminalOptions=
Type=Application" > ~/.local/share/applications/Steam-BSD-Runtime.desktop'

if zenity --question --text="Would you like to add an extra application shortcut that launches Steam using the OSS sound server? (Necessary for Audio on many SOURCE games)"; then
    oss_shortcut
else
    zenity --info --text="Alright, let's move on."
fi

zenity --info --text="Hopefully, this next click will show the Steam login prompt! Give it 30 seconds at most. After that, everything should already be installed, so enjoy :)"

# Sets the Wineprefix to use pulseaudio instead of ALSA / OSS
WINEPREFIX=~/.proton WINE=/usr/local/wine-proton/bin/wine winetricks sound=pulse

# Installs corefonts to load fonts required by Steam.
WINEPREFIX=~/.proton WINE=/usr/local/wine-proton/bin/wine winetricks corefonts

# Patches to make games open in steam (Ripped from Mizutamari)
WINEPREFIX=~/.proton /usr/local/wine-proton/bin/wine $WINEBIN reg.exe ADD "HKEY_CURRENT_USER\Software\Wine\DllOverrides" /v "gameoverlayrenderer" /t "REG_SZ" /d "" /f
WINEPREFIX=~/.proton /usr/local/wine-proton/bin/wine $WINEBIN reg.exe ADD "HKEY_CURRENT_USER\Software\Wine\DllOverrides" /v "gameoverlayrenderer64" /t "REG_SZ" /d "" /f

# Removes the nonfunctioning shortcut automatically created by Wine
rm -rf ~/.local/share/applications/wine/Programs/Steam/

# Launches Steam finally.
WINEPREFIX=~/.proton /usr/local/wine-proton/bin/wine ~/.proton/drive_c/Program\ Files\ \(x86\)/Steam/steam.exe -cef-disable-sandbox -cef-disable-gpu-compositing -cef-in-process-gpu 
