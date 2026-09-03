#!/usr/bin/env bash

# cd ~/
# git clone https://github.com/David0tt/.linux_autosetup
# Optional: switch to appropriate branch
# bash cachyOS_install.sh

# Command tracing, to show the commands that are run
set -x


sudo pacman -Syu

packages=(
    # basics
    git code ncdu htop alacritty micro fish curl wget


    # file managemers
    dolphin kio pcmanfm

    # Cloud Services
    rclone opencloud-desktop nextcloud-client

    # General Usage
    keepassxc blender mpv libreoffice-still texlive-meta qbittorrent zotero thunderbird thunderbird-i18n-de

    # Communication
    teamspeak3 discord spotify-launcher
    
    # MISC
    docker docker-compose
    openrgb
    xorg-xeyes

    # Build dependencies for st
    base-devel libx11 libxft fontconfig
)

sudo pacman -S --needed "${packages[@]}"

# openrgb: To manage my LED keyboard
# rclone: for google drive sync
# paru -S visual-studio-code-bin # The microsoft distributed version
# sudo pacman -S zed # alternative text editor
# sudo pacman -S iotop # show disk usage
# sudo pacman -S pdfarranger # Combine PDF document pages

# File Manager options: thunar, PCManFM, dolphin
# After some benchmarking, i found PCManFM and thunar are an order of magnitude faster than dolphin
# PCManFin appears to be ~20% faster than thunar


################################################################################
###  st terminal
################################################################################
cd ~/.linux_autosetup
mkdir -p program_installation
cd ~/.linux_autosetup/program_installation

# (st) minimal terminal (always used for fzf program search (with mod+d))
git clone https://git.suckless.org/st
cd st

CONFIG_FILE='config.def.h'
# Change font size from 12 to 30
sed -i 's/static char \*font = "Liberation Mono:pixelsize=12:antialias=true:autohint=true";/static char *font = "Liberation Mono:pixelsize=18:antialias=true:autohint=true";/' "$CONFIG_FILE"
# Change keybindings to allow zooming with ctrl +/-
sed -i 's/{ TERMMOD, XK_Prior, zoom, {.f = +1} },/{ ControlMask, XK_plus, zoom, {.f = +1} },/' "$CONFIG_FILE"
sed -i 's/{ TERMMOD, XK_Next, zoom, {.f = -1} },/{ ControlMask, XK_minus, zoom, {.f = -1} },/' "$CONFIG_FILE"
sudo make clean install
# Local installation (into ~/.local/bin):
# make clean install PREFIX=$HOME/.local
# echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc



# Python (miniforge)
wget "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
bash Miniforge3-$(uname)-$(uname -m).sh -b -u
rm Miniforge3-$(uname)-$(uname -m).sh

# Initialize shell
~/miniforge3/bin/conda init
~/miniforge3/bin/conda init fish

# If conda startup is slow might want to wrap the conda initialization in a `function conda_init` and set the `alias mamab_init=conda_init`


################################################################################
###  General Settings
################################################################################

# Docker
sudo systemctl enable docker.socket # Note: docker.socket starts docker on use, while docker.service starts it at boot time
sudo systemctl start docker.socket
sudo usermod -aG docker "$USER"

# Set my git credentials
git config --global user.email "david.ott@uni-tuebingen.de"
git config --global user.name "David Ott"
# Set VSCode as git difftool (show diffs with git difftool <file>)
git config --global diff.tool vscode
git config --global difftool.vscode.cmd 'code --wait --diff "$LOCAL" "$REMOTE"'
git config --global difftool.prompt false


# Set Screen Scaling:
kscreen-doctor --outputs # To find the screen
kscreen-doctor output.DP-3.scale.1.8
kscreen-doctor output.DP-2.scale.1.8


# Settings:
mkdir -p ~/.config/fish
rm -f ~/.config/fish/config.fish
ln -s ~/.linux_autosetup/config_files/fish/config.fish ~/.config/fish/config.fish

# Alacritty
mkdir -p ~/.config/alacritty/
rm -rf ~/.config/alacritty/
mkdir -p ~/.config/alacritty/
ln -s ~/.linux_autosetup/config_files/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml

# Micro text editor: install the Atom Dark theme with a darker background
mkdir -p ~/.config/micro/colorschemes
ln -sfn ~/.linux_autosetup/config_files/micro/colorschemes/atom-dark.micro ~/.config/micro/colorschemes/atom-dark.micro
ln -sfn ~/.linux_autosetup/config_files/micro/bindings.json ~/.config/micro/bindings.json
ln -sfn ~/.linux_autosetup/config_files/micro/init.lua ~/.config/micro/init.lua
if [[ ! -f ~/.config/micro/settings.json ]]; then
    printf '{\n    "colorscheme": "atom-dark"\n}\n' > ~/.config/micro/settings.json
fi

# Put the VSCode - OSS config files into the appropriate locations
mkdir -p ~/.config/Code\ -\ OSS/User
rm -f ~/.config/Code\ -\ OSS/User/keybindings.json
ln -s ~/.linux_autosetup/config_files/VSCode/vscode_linux_keybindings.json ~/.config/Code\ -\ OSS/User/keybindings.json
rm -f ~/.config/Code\ -\ OSS/User/settings.json
ln -s ~/.linux_autosetup/config_files/VSCode/settings.json ~/.config/Code\ -\ OSS/User/settings.json
# Snippets:
rm -rf ~/.config/Code\ -\ OSS/User/snippets
ln -s ~/.linux_autosetup/config_files/VSCode/snippets ~/.config/Code\ -\ OSS/User/snippets
# Prompts:
rm -rf ~/.config/Code\ -\ OSS/User/prompts
ln -s ~/.linux_autosetup/config_files/VSCode/prompts ~/.config/Code\ -\ OSS/User/prompts

# # Put the VSCode config files into the appropriate locations
# rm ~/.config/Code/User/keybindings.json
# ln -s ~/.linux_autosetup/config_files/VSCode/vscode_linux_keybindings.json ~/.config/Code/User/keybindings.json
# rm ~/.config/Code/User/settings.json
# ln -s ~/.linux_autosetup/config_files/VSCode/settings.json ~/.config/Code/User/settings.json
# # Snippets:
# ln -s ~/.linux_autosetup/config_files/VSCode/snippets ~/.config/Code/User/snippets
# # Prompts:
# ln -s ~/.linux_autosetup/config_files/VSCode/prompts ~/.config/Code/User/prompts


# enable ctrl+backspace removal of words
echo '"\C-h": backward-kill-word' >> ~/.inputrc 


# Set alacritty as terminal:
kwriteconfig6 --file kdeglobals --group General --key TerminalApplication alacritty
kwriteconfig6 --file kdeglobals --group General --key TerminalService Alacritty.desktop
kbuildsycoca6


################################################################################
###  Sway installation
################################################################################
packages=(
    sway

    # sway basics
    swaybg swayidle swaylock gtklock

    # Status bar
    waybar network-manager-applet blueman pavucontrol playerctl

    # Alternative: i3status as status bar:
    # i3status dex network-manager-applet brightnessctl flameshot

    # Screenshots
    grim slurp 

    # clipboard
    wl-clipboard cliphist wtype

    j4-dmenu-desktop # Needed for st+fzf program search menu
    bc # Needed for sway_grid.sh
    dex # Used to automatically start programs specified in ~/.config/autostart/ and /etc/xdg/autostart/
    qt5-wayland qt6-wayland # Install wayland plugins for qt, to make e.g. keepass start using wayland, not X11/XWayland

    mako # notification daemon, alternative: dunst

    # External monitor brightness popup slider:
    ddcutil yad

)

sudo pacman -S --needed "${packages[@]}"

# Sway config
rm -rf ~/.config/sway/
# mkdir -p ~/.config/sway/
ln -s ~/.linux_autosetup/config_files/sway/ ~/.config/
# cat ~/.Xresources >> ~/.Xdefaults

rm -rf ~/.config/waybar/
# mkdir -p ~/.config/waybar/
ln -s ~/.linux_autosetup/config_files/waybar/ ~/.config/


################################################################################
###  Fixes for Wayland
################################################################################

# Make programs more likely to start using Wayland instead of XWayland (e.g. discord)
# When started from terminal
fish -c 'set -Ux ELECTRON_OZONE_PLATFORM_HINT wayland'
# fish -c 'set -Ue ELECTRON_OZONE_PLATFORM_HINT' # undo

# When started from anywhere else
mkdir -p ~/.config/environment.d/
echo "ELECTRON_OZONE_PLATFORM_HINT=wayland" > ~/.config/environment.d/90-electron-wayland.conf
# rm ~/.config/environment.d/90-electron-wayland.conf # undo

# Force spotify to run on wayland (for this the DISPLAY env variable neetds to be unset)
mkdir -p ~/.local/bin
printf '#!/usr/bin/env sh\nexec env -u DISPLAY /usr/bin/spotify-launcher "$@"\n' > ~/.local/bin/spotify-launcher
chmod +x ~/.local/bin/spotify-launcher





################################################################################
###  Development tools
################################################################################


# # Copilot-Cli
# curl -fsSL https://gh.io/copilot-install | bash

# OpenAI Codex:
curl -fsSL https://chatgpt.com/codex/install.sh | sh

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Sway workspace icon daemon
conda_init
cd ~/.linux_autosetup/program_installation
conda create -n swayWorkspaceIcons python==3.12 -y
conda activate swayWorkspaceIcons
git clone https://github.com/David0tt/sway-workspace-icons/
pip install sway-workspace-icons/


# VSCode programmatically install all extensions
# ms-python.black-formatter \
extensions=(
  ms-python.python
  ms-python.pylint
  charliermarsh.ruff
  ms-vscode.cpptools
  rust-lang.rust-analyzer
  ms-toolsai.jupyter
  james-yu.latex-workshop
  yzhang.markdown-all-in-one
  yzane.markdown-pdf
  ms-vscode-remote.vscode-remote-extensionpack
  eamodio.gitlens
)

for extension in "${extensions[@]}"; do
    echo "Installing $extension..."
    code --install-extension "$extension" --force
done

echo "All VSCode extensions installed."


# # RustDesk
# sudo pacman -S paru
# paru -S rustdesk # CARE: this does not work non-interactively


# # Phoronix Test Suite (Optional for Benchmarking)
# paru -S phoronix-test-suite
# phoronix-test-suite benchmark unigine-heaven


################################################################################
###  Post installation settings
################################################################################
# - KDE Plasma Settings
#   - set alacritty as terminal shortcut in KDE: 
#     - Mod -> Search "shortcuts" -> Add New -> alacritty -> set ctrl+alt+T
#   - Enable HDR in KDE Plasma
#     - on the desktop, right-click -> Display configuration -> check Enable HDR
#     - calibrate HDR Brightness
#   
#   - Desktop setup:
#     - right click on desktop -> Desktop and Wallpaper 
#         -> Layout: Folder View
#         -> Wallpaper type: Plain Color -> Black
#   - Install KDE plasma integration in firefox:
#     - https://addons.mozilla.org/en-US/firefox/addon/plasma-integration/
#   - Hotkeys in KDE Plasma
#     - Can set hotkeys manually using the settings -> shortcuts utility
#     - Or use the symlinked config file:
#       - Settings change too much between KDE versions -> One needs to manually set the shortcuts
#         - rm ~/.config/kglobalshortcutsrc
#         - ln -s ~/.linux_autosetup/config_files/kde/kglobalshortcutsrc ~/.config/kglobalshortcutsrc
#   - Optional: Krohnkite setup for tiling WM like behavior in KDE Plasma:
#     - Search KWin Scripts -> Get New -> Krohnkite
#     - Go to Krohnkite settings ("Configure")
#       - Layouts: Set all to 0, except Binary Tree to 1
#       - Geometry: Set all gaps to 6px
# 
# - Set up Zotero login / file storage
# - Log into firefox account for sync
# - Log into NextCloud / OpenCloud


# # Correct Sway Startup:
# you need to manually add the --unsupported-gpu flag to the Exec command to prevent the 
# warning message, and you need to start with vulkan as renderer to enable HDR Win 
# 
#     sudo nano /usr/share/wayland-sessions/sway.desktop
# 
#     Exec=sway -> Exec=env WLR_RENDERER=vulkan sway --unsupported-gpu
#


# # On Surface Pro 9: Enable keyboard drivers at LUKS drive encryption unlock to enable keyboard input
# sudo nano /etc/mkinitcpio.conf
# # Edit the line MODULES=() to 
# # MODULES=(pinctrl_tigerlake intel_lpss intel_lpss_pci 8250_dw surface_aggregator surface_aggregator_registry surface_aggregator_hub surface_hid_core surface_hid)
# sudo limine-mkinitcpio
# # on next reboot it should work


# # WinApps (for Windows office apps almost natively in linux)
# # (following github.com/winapps-org/winapps and https://github.com/winapps-org/winapps/blob/main/docs/docker.md)
# # Get windows Docker Container:
# cd ~/.config/
# git clone https://github.com/winapps-org/winapps.git
# cd winapps
# docker compose --file ./compose.yaml up
# # Dependencies:
# sudo pacman -Syu --needed -y curl dialog freerdp git iproute2 libnotify openbsd-netcat
# # Create the winapps config file, following the tutorial
# nano ~/.config/winapps/winapps.conf
# # Safeguard the windows PW:
# chown $(whoami):$(whoami) ~/.config/winapps/winapps.conf
# chmod 600 ~/.config/winapps/winapps.conf
# # Adapt RDP_SCALE to 180, and choose some random RDP_PASS
# bash
# bash <(curl https://raw.githubusercontent.com/winapps-org/winapps/main/setup.sh)
# # Now in the RDP client (noVNC browser window), install Office365
# # Run application discovery again
# # To add additional folder locations edit the following line in ~/.config/winapps/winapps.conf
# # (e.g. i have added the mount for /data)
# # RDP_FLAGS="/cert:tofu /sound /microphone +home-drive /a:drive,data,/data"


# # rclone (for Google Drive mount)
# rclone config
# -> new remote
# -> name: google_drive
# -> storage: drive
# -> create a client id following the link
# # After the last step it will say that verification is needed, but this can be skipped and will produce a warning in the OAuth authentication later, which can be ignored
# Then continue through the whole setup
# Afterwards you can test the connection using: rclone lsd google_drive:
#
# # Create the local sync folder and clone: 
# mkdir -p ~/GoogleDrive
#
# # Just mount (this is like streaming mode)
# rclone mount google_drive: ~/GoogleDrive
#
# # To just download everything:
#     rclone sync gdrive: ~/GoogleDrive \
#         --progress \
#         --transfers 8 \
#         --checkers 16
#
# # Make this a persistent automatic mount at startup:
# mkdir -p ~/.config/systemd/user
# nano ~/.config/systemd/user/rclone-google-drive.service
# # Put this: 
# 
# [Unit]
# Description=Google Drive rclone mount
# Wants=network-online.target
# After=network-online.target
# 
# [Service]
# Type=simple
# 
# ExecStart=/usr/bin/rclone mount google_drive: %h/GoogleDrive \
#     --config=%h/.config/rclone/rclone.conf \
#     --cache-dir=%h/.cache/rclone \
#     --vfs-cache-mode=full
# 
# ExecStop=/usr/bin/fusermount3 -u %h/GoogleDrive
# 
# Restart=on-failure
# RestartSec=5
# 
# [Install]
# WantedBy=default.target
# 
# # Run:
# systemctl --user daemon-reload
# systemctl --user enable --now rclone-google-drive.service
# 
# Check: 
# systemctl --user enable --now rclone-google-drive.service
# ls ~/GoogleDrive



# # Virtualization (linux lite)
# # Instructions following: https://chatgpt.com/c/6a985071-0ddc-83ed-a8af-bfc5e3ee8bc7
# # Prerequisites: 
# # lscpu | grep Virtualization # check VT-x or AMD-V is available
# # lsmod | grep kvm # check kvm and kvm_intel or kvm_amd is available
# 
# # Dependencies:
# # qemu-full (Quick Emulator): Machine Emulator and Virtualizer
# # virt-manager (Virtual Machine Manager): desktop user interface for managing VMs through libvirt
# # edk2-ovmf: UEFI firmware package for virtual machines
# # swtpm (Software Trusted Platform Module) is optional, and only really needed for Windows VMs
# sudo pacman -S qemu-full virt-manager libvirt dnsmasq edk2-ovmf swtpm
# 
# # Enable libvirt
# sudo systemctl enable --now libvirtd.service
# sudo systemctl enable --now libvirtd.socket
# # verify: systemctl status libvirtd.service
# # Add user to libvirt group
# sudo usermod -aG libvirt $USER
# 
# # Set up libvirt networking
# sudo virsh net-start default
# sudo virsh net-autostart default
# 
# # launch virt-manager (Virtual Machine Manager)
# # -> New Virtual Machine
# # -> Go through all the setup, Maybe select a different location for the virtual disk
# 
# # Fix: allow traffic from the vm through ufw
# sudo ufw allow in on virbr0
# sudo ufw route allow in on virbr0
# sudo ufw reload
# 
# # -> Update the VM -> Install anything I want 
# 
# # Shared Folder setup:
# # Use a shared folder on the host
# # Shut down the VM
# cd /data
# mkdir -p VMShare
# # In virt-manager: for the VM, Show virtual hardware details
# # Memory -> enable Shared Memory
# # Add Hardware -> Filesystem (Driver: virtiofs; Source path: PATH/TO/VMShare; Target path: hostshare) # Note that `hostshare` is a mount tag and needs to be called exactly that
# # Start the VM; in the VM:
# sudo mkdir -p /mnt/hostshare
# sudo mount -t virtiofs hostshare /mnt/hostshare
# sudo nano /etc/fstab 
# # Add: 
# # hostshare  /mnt/hostshare  virtiofs  defaults  0  0
# sudo mount -a # test before rebooting
# 
# # Shared Clipboard
# # in the VM:
# sudo apt update
# sudo apt install spice-vdagent
# # Power off
# # In VM settings (hardware configuration):
# # Should have Display Spice, rather than VNC; Should also have SPICE agent channel: Channel spice or Channel spicevmc


# # Set up openrgb for my LED keyboard:
# Start openrgb
# Set the profile as you want it
# Save the profile  as "default_startup"


# # Meta Quest 3 Setup NOT YET WORKING!
# # install steam
# sudo pacman -S steam
# 
# # Then in steam, install SteamVR
# 
# 
# # Install cuda (needed as alvr dependency)
# sudo pacman -S cuda
# 
# # Install alvr
# paru -S alvr-git
# 
# Add ~/.local/share/Steam/steamapps/common/SteamVR/bin/vrmonitor.sh %command% to the launch options of SteamVR (SteamVR -> Manage/Right Click -> Properties -> General -> Launch Options).
