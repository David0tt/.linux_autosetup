
git clone https://github.com/David0tt/.linux_autosetup


sudo pacman -Sy git
sudo pacman -Sy code 
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

# Put the VSCode config files into the appropriate locations
rm ~/.config/Code\ -\ OSS/User/keybindings.json
ln -s ~/.linux_autosetup/config_files/VSCode/vscode_linux_keybindings.json ~/.config/Code\ -\ OSS/User/keybindings.json
rm ~/.config/Code\ -\ OSS/User/settings.json
ln -s ~/.linux_autosetup/config_files/VSCode/settings.json ~/.config/Code\ -\ OSS/User/settings.json
# Snippets:
ln -s ~/.linux_autosetup/config_files/VSCode/snippets ~/.config/Code\ -\ OSS/User/snippets
# Prompts:
ln -s ~/.linux_autosetup/config_files/VSCode/prompts ~/.config/Code\ -\ OSS/User/prompts

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

# Sway
rm -r ~/.config/sway/
mkdir -p ~/.config/sway/
ln -s ~/.linux_autosetup/config_files/sway/config ~/.config/sway/config
ln -s ~/.linux_autosetup/config_files/sway/open_website_in_firefox.sh ~/.config/sway/open_website_in_firefox.sh
ln -s ~/.linux_autosetup/config_files/sway/i3status.conf ~/.config/sway/i3status.conf
ln -s ~/.linux_autosetup/config_files/sway/sway_grid.sh ~/.config/sway/sway_grid.sh
# cat ~/.Xresources >> ~/.Xdefaults






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



# TODO: 

# reduce the time after which the windows are shown when hovering over the taskbar
# Set alacritty as terminal emulator default
# Set up all the tiling-wm features for kde plasma 
# configure fish, so that it jumps to the next line when hitting ctrl+c
# make fish prompt similar to bash
# make keyboard not light up -> roccat swarm support for linux

Can i get tiling WM like navigation on kde?
-> YES: https://claude.ai/share/a76c1647-5e8e-4ce5-bc9c-cd3f28ccc4e1