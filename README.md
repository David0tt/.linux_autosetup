# linux_autosetup
The goal of this repository is to automize the setup of a linux system and keep all my settings in one place, similar to a .dotfiles repo, but with a little bit more extended setup. 

In the best of all worlds, this provides you with a nice, opinionated full computing environment. However, due to the nature of linux systems, you will occasionally run into situations where some computing expirience and tinkering is required to fix it.

This repo basically supports two setups:
1. CachyOS with KDE Plasma and Sway
2. Ubuntu with Gnome and i3

# Usage

## CachyOS with KDE Plasma and Sway
1. Install CachyOS from an installation medium (https://wiki.cachyos.org/installation/installation_on_root/)
   1. Select Limine as the bootloader
   2. If wanted, enable disk encryption on installation
   3. Select KDE Plasma as the desktop environment (don't select the optional sway!)
2. Optional: comment or uncomment any wanted or unwanted steps in the installation script
3. run the setup and installation script:
```bash
cd ~
git clone https://github.com/David0tt/.linux_autosetup
cd .linux_autosetup
bash cachyOS_install.sh
```
4. Run all the post-installation that could not be automated


## Ubuntu with Gnome and i3
1. Install Ubuntu from an installation medium (https://ubuntu.com/tutorials/install-ubuntu-desktop)
2. Optional: comment or uncomment any wanted or unwanted steps in the installation script
3. run the setup and installation script: 
```bash
cd ~
git clone https://github.com/David0tt/.linux_autosetup
cd .linux_autosetup
bash install_script.sh
```
4. Run all the post-installation that could not be automated

TODO: instructions to install https://github.com/David0tt/MyShortcuts

# What you get
The goal of this repo is to provide a full desktop environment, set up to my particular liking, including 
- installed programs
- preferred settings
- hotkey setup

As a daily driver I now exclusively use CachyOS with Sway, mainly because CachyOS provides a great operating system experience out of the box and I like the efficiency, productivity and mental clarity of using a tiling window manager, where Sway provides great responsibility, high-dpi and hdr performance and is the future proof option being built on wayland. 

As a backup, KDE Plasma as a GUI desktop environment, since it is in some cases more stable (e.g. for screen sharing). 

Ubuntu + Gnome + i3 is the alternative system which often works better with some legacy applications, in particular in my work and research context. So this is the system I use on my work computers. 


# Design Philosophy
> _The system should get out of the way and provide mental clarity_

- functionality, usability and simplicity over aesthetics
- visual minimalism. This is not about ricing
- performance and speed is a priority. Everything needs to be responsive
- compatability with other platforms is key 
    - I want to change as little as possible of my workflow when I ssh into some server or use a docker image
- Corollaries:
    - if in doubt, use standard tools for compatability
    - if in doubt, use standard hotkeys for compatability and to not be a fish out of the water when needing to work on another system
    - require as little as possible manual or non-standard setup
    - keep everything at one place
    - system should require minimal management (-> use package manager installed programs with auto update)
    - take your hands off the keyboard as little as possible


# Why I have chosen specific programs:
- [CachyOS](https://cachyos.org/): provides a great [arch](https://archlinux.org/) installation out of the box. Compilation with architecture optimizations supposedly make it faster
    - rolling release: most up to date programs
    - many modern features
    - generally very stable (in my experience)
- [Sway](https://swaywm.org/): a tiling window manager provides very high efficiency for keyboard use, and even more importantly mental clarity about where program windows are
    -  vs [i3](https://i3wm.org/): If possible, always use sway. It is the tool of the future, being built on wayland. Therefore it has better high-dpi and hdr support, better graphics accelerated performance and will receive better support and updates in the future. Use i3 only if there are issues with hardware support (gpu acceleration) on sway. 
    -  the most important thing for me is the tiling wokrflow, which in principle could also be achieved in other ways (but sway is my preferred choice based on the tradeoffs). Alternatives:
          -  [tmux](https://tmux.app/): terminal multiplexer. Can be a good even more minimal choice. However, it only works for terminal applications.
          -  [terminator](https://gnome-terminator.org/): a tiling terminal emulator. also just works for terminal applications.
          -  [hyprland](https://hypr.land/): Another Wayland window manager with good tiling support. It errs more on the side of aesthetics than performance and stability when compared to sway. 
          -  [bspwm](https://github.com/baskerville/bspwm), [awesomewm](https://awesomewm.org/), [dwm](https://dwm.suckless.org/): minimal tiling window managers, however they all only have X and no Wayland support
- [KDE Plasma](https://kde.org/plasma-desktop/): Robost, modern, feature rich desktop environment. Default on CachyOS, so it will probably get good support in the future.
- [VSCode](https://code.visualstudio.com/): this is currently my editor of choice. It has a lot of customizability and functionality, with many extensions. There is an advantage of being to able to do everything (e.g. programming in different languages) in one environment. Also it is available everywhere with the remote development extension (e.g. into ssh servers or docker containers). My main drawback is, that it's startup is rather slow, and since it generally best as a big full screen application, it does not fit perfectly into the tiling environment. 
    - Notable alternatives would be [zed](https://zed.dev/) and [neovim](https://neovim.io/), however zed currently does not have so many features, and neovim has a high initial setup overhead and I don't really want to learn vim motions
- [alacritty](https://github.com/alacritty/alacritty): provides a very fast an minimal terminal emulator. From my testing it was the most performant. Notable alternatives include [terminator](https://gnome-terminator.org/), [kitty](https://github.com/kovidgoyal/kitty), [ghostty](https://ghostty.org/), [st](https://st.suckless.org/)
- Shell:
    - [fish](https://fishshell.com/): on CachyOS I use fish, since it is the default. It provides many good features out of the box: color highlighting, command autocomplete, command autocomplete based on history, notifications on long-running commands. Only drawback: it is not POSIX compliant, so its scripting language is significantly different from bash.
    - [bash](https://en.wikipedia.org/wiki/Bash_(Unix_shell)) with [ble.sh](https://github.com/akinomyoga/ble.sh): I use this on ubuntu systems, since it is the default. Bash has the highest compatability since it is fully posix compliant. With ble.sh you get syntax highlighting and auto suggestions. 
    - Notable contender: [zsh](https://www.zsh.org/) with [ohmyzsh](https://ohmyz.sh/) provides direct compatability with bash, however it requires more initial setup.
- [dolphin](https://apps.kde.org/dolphin/): is the file manager shipped with KDE and has a lot of functionality out of the box. [pcmanfm](https://pcmanfm.com/) is an even faster, less feature rich alternative.
- [micro](https://micro-editor.github.io/): a fast terminal text editor for quick notes



# Notable alternatives: 
- [hyprland](https://hypr.land/): if you want the even more bleeding edge experience for (tiling) window managers. Less stable than sway but more development on modern features, better for customization (ricing).
- [Omarchy](https://omarchy.org/): an opinionated arch+hyprland+quickshell installation with lots of functionality out of the box.




# Nifty details and features:
- st + fzf program search
- sway_grid.sh
- screenshot hotkeys that allow pasting as image data, or as file, so they are working in both, applications or the file manager
- many minor scripts for the waybar
    - swayWorkspaceIconsDaemon
    - Player controls
    - audio control
    - brightness control
    - hdr toggle
    - power saving mode toggle
    - shutdown button
    - close settings windows on mouse leave (audio, brightness, network, bluetooth)


# TODO
- [ ] find some efficient system wide keypass integration, so i dont always have to open the app
- [ ] Hotkey to copy the current line from the shell



# Hotkeys
In the following I will discuss all the hotkeys I use, which greatly increase my productivity and reduce the mental load when working with a computer. However I am not dogmatic about this, of course there are many applications where a mouse is better. 

They are structured as follows: 
- basic text navigation: keyboard controls that work in almost any environment
- shortcuts to open programs: Shortcuts for my most used programs
- Terminal navigation: controls specifically in the terminal
- Tiling WM navigation: controls specifically for navigating a tiling window manager
- Navigation in GUI desktops: Shortcuts to navigate a general desktop (no tiling window manager)
- VSCode: Shortcuts for VSCode
- Firefox: Shortcuts for Firefox


- basic text navigation: keyboard controls that work in almost any environment
- Terminal navigation (ctrl+r, )
- Tiling WM navigation
- shortcuts to open programs I need
- VSCode
- Firefox
- Navigation in GUI desktops (ctrl+win+left/right; win to move programs to workspaces)



- Tiling window Manager features / hotkeys
    - Autotile, arrange (over all displays, over current display) -> DONE with custom script
    - switch between active window (in i3 is mod + arrow keys or mod + jklö)
    - split horizontally / vertically (in i3 is mod+v, mod+h before opening a window)
    - move/arrange window (mod+shift+arrow-keys / mod+shift+j/k/l/ö / ctrl+left mouse + move), toggle horizontal/vertical split mode: mod+e
    - make window fullscreen mod+f
    - switch between horizontal/vertical split mode, stacking mode and tabbed mode (not sure if I want this) - mod+e mod+s mod+w
    - close window (mod+shift+d) (mod+middle mouse)
    - toggle window floating (mod+shift+space / mod+right mouse)
    - switch between desktops/workspaces (mod+num)
    - move window to workspace (mod+shift+num)
    - resizing windows (mod+r, then arrow keys / use mouse on borders)
    - exit i3: mod+shift+e



Also see ~/Nextcloud/MyShortcuts which is https://github.com/David0tt/MyShortcuts

Shortcuts can be added in GUI or in keybindings.json (`Preferences: Open Keyboard Shortcuts (JSON)`)
Settings can be added in settings.json (`Preferences: Open User Settings (JSON)`), or only for the workspace (`Preferences: Open Workspace Settings (JSON)`)

- VSCode (Hotkeys + Extensions can be automatically synced via github):
    - `ctrl+left/right` move cursor by words
    - `ctrl+shift+left/right` select by jumping through words
    - `shift+alt+left/right` smart select, select in paranthesis / brackets / to next comma, etc.
    - `Ctrl+K V` to open markdown preview to the side 
    - `Ctrl+Alt+I` Toggle copilot chat panel
    - `Ctrl+Shift+Alt+I` toggle Copilot edits panel
    - `Ctrl+J` cursor accept partial edit
    - `Ctrl+Shift+P` command palette
    - `Alt+Z` toggle word-wrap
    - `alt+c` toggle checkbox in markdown list
    - `ctrl+enter` copilot suggestions
    - `ctrl+p` search for file / go to file
    - `ctrl+shift+f` search
    - `ctrl+shift+e` open explorer tab
    - `ctrl+.` quick fix
    - `ctrl+k z` focus mode/zen mode (make editor full-screen)
    - `ctrl+k ctrl+m` toggle maximize editor group
    - ``ctrl+` `` (backtick) toggle the terminal in vscode
    - `ctrl+shift+o` go to symbol in file, e.g. section header or function/class definition
    - `ctrl+p / ctrl+t, #` go to symbol in the whole workspace
    - `ctrl+1/2/3/...` switch between active editors
    - `ctrl+w` close the active file
    - `ctrl+tab / ctrl+shift+tab` Go through tabs (forward/backward)
    - `shift+alt+f` Format Document (needs formatter for the current language installed, e.g. `ms-python.black-formatter`, `C++ Extension Pack` with clang)
- Custom VSCode Shortcuts:
    - `Ctrl+#` `Toggle Line Comment`
    - `Ctrl+Y` `Redo`
    - `Shift+Enter` Jupyter: Run Selection/Line in Interactive Window
      - also have to edit when expression of shortcut `Jupyter: Run Selection/Line in Interactive Window` to:
        - `editorTextFocus && isWorkspaceTrusted && !findInputFocussed && !isCompositeNotebook && !notebookEditorFocused && !replaceInputFocussed && editorLangId == 'python'`
    - `ctrl+shift+enter`: Jupyter: Run To Line in Interactive Window (remove `Insert Code Cell Above` and `Insert Line Before`)
    - `ctrl+shift+v` paste (to use same as in terminals)
    - `ctrl+shift+c` copy (to use same as in terminals)
    - `Ctrl+Shift+Alt+V` to open markdown preview (previously was `ctrl+shift+v`)
- VSCode Copilot
  - `ctrl+alt+i`: toggle chat
  - `ctrl+shift+alt+i`: toggle editor chat
  - `ctrl+i`: inline chat
- VSCode Copilot Custom Hotkeys: 
  - `ctrl+shift+i`: new chat (replaces `ctrl+l`) (`Chat: New Chat`, `Chat: New Edit Session`)
  - `ctrl+l` add selection to context (`Github Copilot: Add Selection to Chat`, remove `Expand Line Selection`)
      - `Github Copilot: Add Selection to Chat` When: editorFocus
      - we would also like to use the following, but i have not found good "When" expressions to make this work. 
          - `GitHub Copilot: Add Selection to Copilot Edits`
              - Maybe something like: When: editorFocus && chatLocation == 'editing-session'
          - `GitHub Copilot: Add Terminal Selection to Chat` When: terminalTextSelected PROBLEM: does conflict with ctrl+l for terminal clear
- In Browsers / Most programs:
    - `Ctrl+Tab`/`Ctrl+Shift+Tab` switch active tab
- Firefox:
    - `ctrl+t` new tab
    - `ctrl+shift+t` reopen last closed tab
    - `ctrl+n` new window
    - `ctrl+shift+n` reopen last closed window
    - `ctrl+shift+d` save all open tabs as bookmark folder
- Windows Window management:
    - `Win + Space` Switch between language keyboard input
    - Switch between input keyboard: ?
    - `Win + Left/Right/Up/Down` Align window left/right/maximize/minimize
    - `Ctrl + Win + Left/Right` switch workspaces
    - `Win + Number` start or switch to this program in the taskbar
- Terminator: 
    - `Ctrl+Shift+E` split window vertically
    - `Ctrl+Shift+O` split window horizontally
    - `Ctrl+Shift+W` close active window
- Zotero:
    - `Alt+Left/Right` to go back/forward after clicking hyperlinks (+ options in menu bar "Go -> Back")
- KeePassXC:
    - `Ctrl+b` copy username
    - `Ctrl+c` copy password
