
git clone https://github.com/David0tt/.linux_autosetup


sudo pacman -Sy git

sudo pacman -Sy code 
# paru -S visual-studio-code-bin # The microsoft distributed version

sudo pacman -Sy keepassxc
sudo pacman -Sy teamspeak3
sudo pacman -Sy thunderbird thunderbird-i18n-de 
sudo pacman -Sy discord
sudo pacman -Sy spotify-launcher
sudo pacman -Sy alacritty
sudo pacman -Sy ncdu
sudo pacman -Sy nextcloud-client
sudo pacman -Sy kio
sudo pacman -Sy htop
sudo pacman -Sy mpv
sudo pacman -Sy blender
# sudo pacman -Sy libreoffice


# rustdesk

# Zotero

# Texlive-full

cd ~/.linux_autosetup
mkdir -p program_installation
cd ~/.linux_autosetup/program_installation

# (st) minimal terminal (always used for fzf program search (with mod+d))
# sudo apt update
# sudo apt install build-essential libx11-dev libxft-dev libxext-dev libfontconfig1-dev libfreetype6-dev -y
git clone https://git.suckless.org/st
cd st

set CONFIG_FILE 'config.def.h'
# Change font size from 12 to 30
sed -i 's/static char \*font = "Liberation Mono:pixelsize=12:antialias=true:autohint=true";/static char *font = "Liberation Mono:pixelsize=30:antialias=true:autohint=true";/' "$CONFIG_FILE"
# Change keybindings to allow zooming with ctrl +/-
sed -i 's/{ TERMMOD, XK_Prior, zoom, {.f = +1} },/{ ControlMask, XK_plus, zoom, {.f = +1} },/' "$CONFIG_FILE"
sed -i 's/{ TERMMOD, XK_Next, zoom, {.f = -1} },/{ ControlMask, XK_minus, zoom, {.f = -1} },/' "$CONFIG_FILE"
sudo make clean install
# Local installation (into ~/.local/bin):
# make clean install PREFIX=$HOME/.local
# echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc




# Optional
paru -S phoronix-test-suite

phoronix-test-suite benchmark unigine-heaven



# Set my git credentials
git config --global user.email "david.ott@uni-tuebingen.de"
git config --global user.name "David Ott"
# Set VSCode as git difftool (show diffs with git difftool <file>)
git config --global diff.tool vscode
git config --global difftool.vscode.cmd 'code --wait --diff "$LOCAL" "$REMOTE"'
git config --global difftool.prompt true




# Set Screen Scaling:
kscreen-doctor --outputs # To find the screen
kscreen-doctor output.DP-3.scale.1.8
kscreen-doctor output.DP-2.scale.1.8


# Settings:
rm ~/.config/fish/config.fish
ln -s ~/.linux_autosetup/config_files/fish/config.fish ~/.config/fish/config.fish

# Alacritty
rm -r ~/.config/alacritty/
mkdir -p ~/.config/alacritty/
rm ~/.config/alacritty/alacritty.toml
ln -s ~/.linux_autosetup/config_files/alacritty/alacritty.toml ~/.config/alacritty/alacritty.toml

# Put the VSCode - OSS config files into the appropriate locations
rm ~/.config/Code\ -\ OSS/User/keybindings.json
ln -s ~/.linux_autosetup/config_files/VSCode/vscode_linux_keybindings.json ~/.config/Code\ -\ OSS/User/keybindings.json
rm ~/.config/Code\ -\ OSS/User/settings.json
ln -s ~/.linux_autosetup/config_files/VSCode/settings.json ~/.config/Code\ -\ OSS/User/settings.json
# Snippets:
ln -s ~/.linux_autosetup/config_files/VSCode/snippets ~/.config/Code\ -\ OSS/User/snippets
# Prompts:
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



# Python (miniforge)
wget "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh"
bash Miniforge3-$(uname)-$(uname -m).sh -b -u
rm Miniforge3-$(uname)-$(uname -m).sh

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y



# VSCode programmatically install all extensions
set extensions \
  ms-python.python \
  ms-python.pylint \
  ms-python.black-formatter \
  ms-vscode.cpptools \
  rust-lang.rust-analyzer \
  ms-toolsai.jupyter \
  james-yu.latex-workshop \
  yzhang.markdown-all-in-one \
  yzane.markdown-pdf \
  ms-vscode-remote.vscode-remote-extensionpack \
  eamodio.gitlens

for extension in $extensions
    echo "Installing $extension..."
    code --install-extension $extension --force
end

echo "All VSCode extensions installed."


# Set alacritty as terminal:
kwriteconfig6 --file kdeglobals --group General --key TerminalApplication alacritty
kwriteconfig6 --file kdeglobals --group General --key TerminalService alacritty.desktop

# Can set hotkeys manually using the settings -> shortcuts utility
# Or use the symlinked config file:
rm ~/.config/kglobalshortcutsrc
ln -s ~/.linux_autosetup/config_files/kde/kglobalshortcutsrc ~/.config/kglobalshortcutsrc




# Sway
sudo pacman -S sway 
sudo pacman -S swaybg 
sudo pacman -S swayidle swaylock
sudo pacman -S gtklock

# sudo pacman -S i3status dex network-manager-applet brightnessctl flameshot

sudo pacman -S grim slurp

sudo pacman -S wl-clipboard cliphist

sudo pacman -S j4-dmenu-desktop # Needed for st+fzf program search menu

# Sway
rm -r ~/.config/sway/
mkdir -p ~/.config/sway/
ln -s ~/.linux_autosetup/config_files/sway/config ~/.config/sway/config
ln -s ~/.linux_autosetup/config_files/sway/open_website_in_firefox.sh ~/.config/sway/open_website_in_firefox.sh
ln -s ~/.linux_autosetup/config_files/sway/i3status.conf ~/.config/sway/i3status.conf
ln -s ~/.linux_autosetup/config_files/sway/sway_grid.sh ~/.config/sway/sway_grid.sh
# cat ~/.Xresources >> ~/.Xdefaults



# Copilot-Cli
curl -fsSL https://gh.io/copilot-install | bash




# TODO after installation: 
#
# - Enable HDR
#   - on the desktop, right-click -> Display configuration -> check Enable HDR
#   - calibrate HDR Brightness
# 
# - Desktop setup:
#   - right click on desktop -> Desktop and Wallpaper 
#       -> Layout: Folder View
#       -> Wallpaper type: Plain Color -> Black
#
# Install KDE plasma integration in firefox:
#   - https://addons.mozilla.org/en-US/firefox/addon/plasma-integration/
# 
# Zotero setup file sync 

# Krohnkite setup for tiling WM:
# - Search KWin Scripts -> Get New -> Krohnkite
# - Go to Krohnkite settings ("Configure")
#   - Layouts: Set all to 0, except Binary Tree to 1
#   - Geometry: Set all gaps to 6px
#   - 




Can i get tiling WM like navigation on kde?
-> YES: https://claude.ai/share/a76c1647-5e8e-4ce5-bc9c-cd3f28ccc4e1



# To prevent vscode freezes (does not work)
# echo "--disable-gpu" >> ~/.config/code-flags.conf



# You need to manually add the following lines at the end of ~/.vscode-oss/argv.json (or ~/.vscode/argv.json, if this different installation was used)
# 
# 	// Fix "An OS keyring couldn't be identified for storing the encryption related data in your current desktop environment"
# 	// see also https://code.visualstudio.com/docs/configure/settings-sync#_recommended-configure-the-keyring-to-use-with-vs-code
# 	"password-store":"gnome-libsecret"
