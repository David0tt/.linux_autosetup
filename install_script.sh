################################################################################
################################ Install script ################################
################################################################################


echo "Make sure this repository is stored under ~/.linux_autosetup "

echo "Before running this script, make sure that the appropriate graphics drivers are installed, e.g. by running"
echo ''
echo '    # Nvidia Drivers: (following https://docs.nvidia.com/datacenter/tesla/driver-installation-guide/index.html -> Ubuntu -> Network Repository Installation)  '
echo ''
echo '    sudo apt install linux-headers-$(uname -r)'
echo '    export distro="ubuntu2404"'
echo '    export arch="x86_64"'
echo '    wget https://developer.download.nvidia.com/compute/cuda/repos/$distro/$arch/cuda-keyring_1.1-1_all.deb'
echo '    sudo dpkg -i cuda-keyring_1.1-1_all.deb'
echo '    sudo apt update'
echo '    sudo apt install nvidia-open'
echo ''
echo '    # Install CUDA Toolkit (https://developer.nvidia.com/cuda-downloads)'
echo '    sudo apt-get -y install cuda-toolkit-12-9'

################################################################################
########${1/(.*)/testtitle/}${1/(.*)/testtitle/}########
################################################################################



# Command tracing, to show the commands that are run
set -x

# Starting:
# mkdir ~/system_installation
cd ~/.linux_autosetup
mkdir -p program_installation
cd ~/.linux_autosetup/program_installation


################################################################################
###  Basic Programs (always required)
################################################################################
sudo apt install build-essential -y
# KeePassXC (Password Manager)
sudo apt install keepassxc -y
# Standard CLI tools
sudo apt install curl -y
sudo apt install gawk -y
sudo apt install git -y
# Set my git credentials
git config --global user.email "david.ott@uni-tuebingen.de"
git config --global user.name "David Ott"
# Set VSCode as git difftool (show diffs with git difftool <file>)
git config --global diff.tool vscode
git config --global difftool.vscode.cmd 'code --wait --diff "$LOCAL" "$REMOTE"'
git config --global difftool.prompt true
# gparted (partition manager, easily allows partitioning in a graphical interface)
sudo apt install gparted -y 
# Diodon (Clipboard Manager)
sudo apt install diodon -y
set +x 
echo "YOU MANUALLY HAVE TO EDIT THE DIODON SETTINGS"
echo "In Diodon Preferences: (Diodon Hotkey->Preferences)"
echo "check Use primary selection (-> Enables paste in Command lines)"
echo "check Add Images to clipboard history (-> now also have images in history, but RAM intensive)"
set -x

# Nextcloud
sudo apt install nextcloud-desktop -y

################################################################################
###  Terminal
################################################################################
# NOTE: To change the terminal emulator change the one here, and also modify the 
#     `sudo update-alternatives --set x-terminal-emulator` command below

# sudo apt install terminator -y
# sudo apt install alacritty -y
sudo apt install kitty -y
echo '
# Key bindings for font size change with hotkeys ctrl+plus/minus
map ctrl+plus      increase_font_size
map ctrl+minus     decrease_font_size' >>  ~/.config/kitty/kitty.conf

# (st) minimal terminal (always used for fzf program search (with mod+d))
sudo apt update
sudo apt install build-essential libx11-dev libxft-dev libxext-dev libfontconfig1-dev libfreetype6-dev -y
git clone https://git.suckless.org/st
cd st

CONFIG_FILE='config.def.h'
# Change font size from 12 to 30
sed -i 's/static char \*font = "Liberation Mono:pixelsize=12:antialias=true:autohint=true";/static char *font = "Liberation Mono:pixelsize=30:antialias=true:autohint=true";/' "$CONFIG_FILE"
# Change keybindings to allow zooming with ctrl +/-
sed -i 's/{ TERMMOD, XK_Prior, zoom, {.f = +1} },/{ ControlMask, XK_plus, zoom, {.f = +1} },/' "$CONFIG_FILE"
sed -i 's/{ TERMMOD, XK_Next, zoom, {.f = -1} },/{ ControlMask, XK_minus, zoom, {.f = -1} },/' "$CONFIG_FILE"
sudo make clean install
# Local installation (into ~/.local/bin):
# make clean install PREFIX=$HOME/.local
# echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc

# add st to available terminal emulators:
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/local/bin/st 50
cd ~/.linux_autosetup/program_installation

# Setup for bash:
# Install ble.sh -> Syntax highlighting, command suggestions, autocomplete
git clone --recursive --depth 1 --shallow-submodules https://github.com/akinomyoga/ble.sh.git
make -C ble.sh install PREFIX=~/.local
echo 'source ~/.local/share/blesh/ble.sh' >> ~/.bashrc

# add these to the ~/.bashrc # TODO not perfect yet
echo 'bleopt complete_auto_history=  ' >> ~/.bashrc
echo 'bleopt complete_ambiguous= ' >> ~/.bashrc

# # TheFuck (command autocorrect)
# # currently not installed, since it produces very bad bash startup times, and does not prove so useful (e.g. when AI assistants are also available)
# sudo snap install thefuck --edge --classic
# echo 'eval $(thefuck --alias)' >> ~/.bashrc

# sudo apt install fzf # this only installs an old version, rather install directly from git for shell integration
# Consider using a different install directory (~/.local/bin)
sudo apt purge fzf -y # Sometimes fzf is already installed by apt which is a very outdated version  
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf  
~/.fzf/install --all # -> should already add the correct entries to .bashrc
# mod+d: start program search
# ctrl+r: reverse command search
# alt+d: change to selected directory
# ctrl+t: insert selected file/directory
# eval "$(fzf --bash)" >> .bashrc # Not required


# Set the standard terminal emulator 
# this also makes the open terminal here dialogue in thunar work correctly:
sudo update-alternatives --set x-terminal-emulator /usr/bin/kitty # TODO or select different terminal emulator
# sudo update-alternatives --config x-terminal-emulator # to show the currently chosen terminal-emulator
sudo apt install xfce4-settings -y 
# this also allows running `xfce4-settings-manager`


################################################################################
###  i3 window manager specific
################################################################################
# Install i3-wm
sudo apt install i3 -y 
# thunar (File Manager):
sudo apt install thunar -y 
# Audio control:
# sudo apt install pavucontrol -y # GUI, but shows too much stuff
sudo apt install pulsemixer -y  # Minimal TUI
# flameshot (Screenshot Program)
sudo apt install flameshot -y




################################################################################
###  Replacements of standard shell commands
################################################################################
# Replacements for Basic Functionality (ls, cat, grep, ...)
# eza (better ls)
sudo apt install eza -y 
echo 'alias ls="eza"' >> ~/.bashrc
# bat (better cat)
sudo apt install bat -y 
echo 'alias cat="batcat --paging=never"' >> ~/.bashrc
# ripgrep (better grep)
sudo apt-get install ripgrep -y 
echo 'alias grep="rg"' >> ~/.bashrc
# cargo install xcp # cp alternative, however currently unstable and in beta, also no real performance gain over cp, only advantage is status bar
# TODO not sure if I need zoxide, if I already have fzf with alt+c
sudo apt install zoxide -y 
eval "$(zoxide init bash --cmd cd)"
# -> Use cdi for fuzzy search in zoxide cd, use cd similarly, but with memory and autocomplete
# Finding stuff
# ldconfig -p | grep <libraryname> # finding the location of libraries
# which # finding the location of executables
sudo apt install fd-find -y # fd is  a find replacement, that is faster and has better defaults
echo 'alias find="fdfind"' >> ~/.bashrc
# Disk usage (more intuitive than df / du)


################################################################################
###  Nice utilities
################################################################################
sudo apt install ncdu -y 
# Performance monitoring
# nvidia-smi # for GPU
# top # most minimal
sudo apt install htop -y
sudo apt install btop -y # also has performance graph. Notable alternative: bottom
sudo apt install speedtest-cli -y
# tree (for viewing filesystem tree) -> Not required, `eza -T` does the same and is more customizeable
# sudo apt install tree -y 


################################################################################
###  Development environment
################################################################################
# Docker (Instructions from https://docs.docker.com/engine/install/ubuntu/)
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
# Add the repository to Apt sources:
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y 
# sudo docker run hello-world # verify

# Conda + Python
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
bash Miniconda3-latest-Linux-x86_64.sh -b
~/miniconda3/bin/conda init

# Rust
# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
# Verify
# rustc --version
# cargo --version

################################################################################
###  Accept Conda TOS
################################################################################
conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/main
conda tos accept --override-channels --channel https://repo.anaconda.com/pkgs/r


################################################################################
###  i3WorkspaceIcons
################################################################################
source ~/miniconda3/bin/activate base
conda create -n i3WorkspaceIcons python==3.12 -y
conda activate i3WorkspaceIcons
git clone https://github.com/David0tt/i3-workspace-icons/
pip install i3-workspace-icons/


################################################################################
###  Basic GUI Programs
################################################################################
sudo apt install firefox -y
sudo apt install gimp -y
sudo apt install kdenlive -y
sudo apt install remmina -y
sudo apt install thunderbird -y 
sudo snap install libreoffice
sudo snap install vlc
sudo snap install irfanview


# VSCode
# from https://code.visualstudio.com/docs/setup/linux
sudo apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg
sudo apt install apt-transport-https -y 
sudo apt update
sudo apt install code -y 
# VSCode programatically install all the extensions:
#!/bin/bash
# List of VSCode extension IDs to install
extensions=(
  "ms-python.python"
  "ms-python.pylint" # could also look into ruff for python linting in the future: charliermarsh.ruff
  "ms-python.black-formatter"
  "ms-vscode.cpptools"
  "rust-lang.rust-analyzer"
  "ms-toolsai.jupyter"
  "james-yu.latex-workshop"
  "yzhang.markdown-all-in-one"
  "yzane.markdown-pdf"
  "ms-vscode-remote.vscode-remote-extensionpack"
)
# Loop through the list and install each extension
for extension in "${extensions[@]}"; do
  echo "Installing $extension..."
  code --install-extension "$extension" --force
done
echo "All VSCode extensions installed."

# FreeCAD
mkdir freecad
cd freecad
wget https://github.com/FreeCAD/FreeCAD/releases/download/1.0.1/FreeCAD_1.0.1-conda-Linux-x86_64-py311.AppImage
chmod +x FreeCAD_1.0.1-conda-Linux-x86_64-py311.AppImage
sudo ln -s ~/.linux_autosetup/freecad/FreeCAD_1.0.1-conda-Linux-x86_64-py311.AppImage /usr/local/bin/freecad
cd ..

# Blender
sudo snap install blender --classic -y 

# Rustdesk
sudo apt install libxdo3 -y 
wget https://github.com/rustdesk/rustdesk/releases/download/1.4.0/rustdesk-1.4.0-x86_64.deb
sudo dpkg -i rustdesk-1.4.0-x86_64.deb


# Zotero (using the deb wrapper: https://github.com/retorquere/zotero-deb)
wget -qO- https://raw.githubusercontent.com/retorquere/zotero-deb/master/install.sh | sudo bash
sudo apt update
sudo apt install zotero -y

# TexLive
sudo apt install texlive-full -y


################################################################################
###  Optional Programs for home PC
################################################################################
sudo snap install spotify
sudo snap install discord
# TeamSpeak # TODO maybe get newer version
mkdir teamspeak
cd teamspeak
wget https://files.teamspeak-services.com/releases/client/3.6.2/TeamSpeak3-Client-linux_amd64-3.6.2.run
chmod +x TeamSpeak3-Client-linux_amd64-3.6.2.run
./TeamSpeak3-Client-linux_amd64-3.6.2.run --accept # TODO somehow automatically read / accept the license -> Creates directory for TS
sudo ln -s ~/teamspeak/TeamSpeak3-Client-linux_amd64/ts3client_runscript.sh /usr/local/bin/teamspeak
rm ./TeamSpeak3-Client-linux_amd64-3.6.2.run
cd ..
# Mullvad
# Download the Mullvad signing key
sudo curl -fsSLo /usr/share/keyrings/mullvad-keyring.asc https://repository.mullvad.net/deb/mullvad-keyring.asc
# Add the Mullvad repository server to apt
echo "deb [signed-by=/usr/share/keyrings/mullvad-keyring.asc arch=$( dpkg --print-architecture )] https://repository.mullvad.net/deb/stable stable main" | sudo tee /etc/apt/sources.list.d/mullvad.list
# Install the package
sudo apt update
sudo apt install mullvad-vpn -y 







################################################################################
###  Config files via symlink
################################################################################
# Put all the config files
rm -r ~/.config/i3/
mkdir -p ~/.config/i3/
ln -s ~/.linux_autosetup/config_files/i3/config ~/.config/i3/config
ln -s ~/.linux_autosetup/config_files/i3/i3_grid.sh ~/.config/i3/i3_grid.sh
ln -s ~/.linux_autosetup/config_files/i3/i3status.conf ~/.config/i3/i3status.conf
ln -s ~/.linux_autosetup/config_files/i3/open_website_in_firefox.sh ~/.config/i3/open_website_in_firefox.sh
ln -s ~/.linux_autosetup/config_files/i3/start_docker_workspace.sh ~/.config/i3/start_docker_workspace.sh
# rm -r ~/.config/alacritty/
mkdir -p ~/.config/alacritty/
ln -s ~/.linux_autosetup/config_files/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml

# Put the VSCode config files into the appropriate locations
rm ~/.config/Code/User/keybindings.json
ln -s ~/.linux_autosetup/config_files/VSCode/vscode_linux_keybindings.json ~/.config/Code/User/keybindings.json
rm ~/.config/Code/User/settings.json 
ln -s ~/.linux_autosetup/config_files/VSCode/settings.json ~/.config/Code/User/settings.json 
# Snippets:
ln -s ~/.linux_autosetup/config_files/VSCode/snippets ~/.config/Code/User/snippets
# Prompts:
ln -s ~/.linux_autosetup/config_files/VSCode/prompts ~/.config/Code/User/prompts

# NOTE: The .bashrc is explicitly not symlinked, since it is too specific for the concrete system


################################################################################
###  General Settings
################################################################################

# Adapt Window scaling:
echo '*dpi: 140
Xft.dpi: 140' >> ~/.Xresources

# Set dark theme for all applications using GTK
echo '[Settings]
gtk-theme-name = Adwaita-dark
gtk-icon-theme-name = Adwaita
gtk-application-prefer-dark-theme = true' >> ~/.config/gtk-3.0/settings.ini

# enable ctrl+backspace removal of words
echo '"\C-h": backward-kill-word' >> ~/.inputrc 

# Enable x-server for docker to show gui applications from inside containers# xhost +local:docker # minimal
echo 'if command -v xhost >/dev/null 2>&1 && [ -n "$DISPLAY" ]; then
    xhost +local:docker >/dev/null 2>&1
fi' >> ~/.bashrc


################################################################################
### custom bash alises
################################################################################
echo 'alias nn="code ~/Nextcloud/INN/nn/"' >> ~/.bashrc
echo 'alias rr="code ~/Nextcloud/RobotReplicationDockerfiles/"' >> ~/.bashrc
echo 'alias th="thunar . &"' >> ~/.bashrc
# echo 'alias th="nautilus . &"' >> ~/.bashrc
echo 'alias ebv="cd /cshome/share/ott/EBV_stuff"' >> ~/.bashrc
echo 'alias ebvc="code /cshome/share/ott/EBV_stuff"' >> ~/.bashrc
echo 'alias ds="~/.config/i3/start_docker_workspace.sh"' >> ~/.bashrc # start up a docker container with multiple terminals



# Shared bash history between sessions: # TODO this might slow down the terminal session substantially
echo 'shopt -s histappend
# After each command, save history to the file and reload it
PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
# Optional: increase history size
HISTSIZE=10000
HISTFILESIZE=20000
# Ignore duplicate commands and commands starting with space
HISTCONTROL=ignoredups:ignorespace' >> ~/.bashrc


# TODO cleanup
# - remove all the created intermediate files -> there are none that need to be removed 


################################################################################
###  Post Installation TODO message
################################################################################
set +x
echo "What you should do now: "
echo ' - start nextcloud file syncing'
echo ' - Log into firefox account -> should install all addons, and maybe some settings'
echo ' - set up thunderbird'
echo ' - set up zotero file storage via nextcloud'
echo ' - set up rustdesk login and permanent password'
echo ' - set up ssh keys'
echo ' - log into VSCode Copilot'
echo ' - create conda environment'
echo ' - OPTIONAL: change the dpi scaling in ~/.Xresources'
echo ' '
echo "YOU MANUALLY HAVE TO EDIT THE DIODON SETTINGS"
echo "In Diodon Preferences: (Diodon Hotkey->Preferences)"
echo "check Use primary selection (-> Enables paste in Command lines)"
echo "check Add Images to clipboard history (-> now also have images in history, but RAM intensive)"

echo "TODO: replace xterm-color|*-256color) color_prompt=yes;; with     xterm-color|*-256color|alacritty|xterm-kitty) color_prompt=yes;; in ~/.bashrc"


# TODO put GNOME hotkeys from https://github.com/David0tt/MyShortcuts



# TODO maybe make optional installations via user prompt / command line arguments. Alternatively users can just manually comment out what they don't like from this file

# TODO compare shortcuts with https://github.com/David0tt/MyShortcuts -> TODO make a check in the setup file, if we are under i3 make shortcuts using bindsym, otherwise make them using the dconf way (optionally make both, for dual desktop setups)
# latex go to current location in pdf
# bluetooth driver
# TODO make alias to open file explorer at current location

