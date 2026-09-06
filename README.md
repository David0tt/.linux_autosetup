# linux_autosetup
The goal of this repository is to automize the setup of a linux system and keep all my settings in one place, similar to a .dotfiles repo, but with a little bit more extended setup. 

In the best of all worlds, this provides you with a nice, opinionated full computing environment. However, due to the nature of linux systems, you will occasionally run into situations where some computing expirience and tinkering is required to fix it.

This repo basically supports two setups:
1. CachyOS with KDE Plasma and Sway
2. Ubuntu with Gnome and i3

## Installation

### CachyOS with KDE Plasma and Sway
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


### Ubuntu with Gnome and i3
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
5. install my custom shortcuts following https://github.com/David0tt/MyShortcuts

## What you get
The goal of this repo is to provide a full desktop environment, set up to my particular liking, including 
- installed programs
- preferred settings
- hotkey setup

As a daily driver I now exclusively use CachyOS with Sway, mainly because CachyOS provides a great operating system experience out of the box and I like the efficiency, productivity and mental clarity of using a tiling window manager, where Sway provides great responsibility, high-dpi and hdr performance and is the future proof option being built on wayland. 

As a backup, KDE Plasma as a GUI desktop environment, since it is in some cases more stable (e.g. for screen sharing). 

Ubuntu + Gnome + i3 is the alternative system which often works better with some legacy applications, in particular in my work and research context. So this is the system I use on my work computers. 


## Design Philosophy
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


## Why I have chosen specific programs:
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


## Notable alternatives: 
- [hyprland](https://hypr.land/): if you want the even more bleeding edge experience for (tiling) window managers. Less stable than sway but more development on modern features, better for customization (ricing).
- [Omarchy](https://omarchy.org/): an opinionated arch+hyprland+quickshell installation with lots of functionality out of the box.


## Nifty details and features:
- very minimal "application launcher" using the st terminal and fzf fuzzy find
- sway_grid.sh to automatically lay out application in a grid layout
- screenshot hotkeys that allow pasting as image data, or as file, so they are working in both, applications or the file manager
- script to automatically cycle the horizontal layout of all attached displays
- micro as minimal text editor with support for `ctrl+shift+s` save as and `ctrl+o` open using GUI windows for file selection
- many minor scripts for the waybar
    - [Workspace Icon Daemon](https://github.com/David0tt/workspace-icon-daemon) for dynamic application icons on i3 and Sway workspaces
    - Player controls and media information with album art
    - audio control
    - brightness control for my external monitor
    - hdr toggle
    - power saving mode toggle
    - shutdown button with gui Logout | Suspend | Shutdown | Reboot selection 
    - automatically close settings windows on mouse leave (audio, brightness, network, bluetooth)
    - all interactive elements use interrupt signals to trigger instant reloads of the waybar UI elements on click/modification


## TODO
- [ ] find some efficient system wide keypass integration, so i dont always have to open the app
- [ ] Hotkey to copy the current line from the shell



## Hotkeys
In the following I will discuss all the hotkeys I use, which greatly increase my productivity and reduce the mental load when working with a computer. However I am not dogmatic about this, of course there are many applications where a mouse is better. Of course there are also many more shortcuts in the world. This is just my opnionated list of shortcuts which I find most useful.

They are structured as follows: 
- basic (text) navigation: keyboard controls that work in almost any environment
- shortcuts to open programs: Shortcuts for my most used programs
- Terminal navigation: controls specifically in the terminal
- Tiling WM navigation: controls specifically for navigating a tiling window manager
- Navigation in GUI desktops: Shortcuts to navigate a general desktop (no tiling window manager)
- VSCode: Shortcuts for VSCode
- Miscellaneous programs: Shortcuts for Firefox, Zotero, KeepassXC

Note that in the following i use `mod` / `win` / `super` interchangeably for the Windows/Super key. 

### basic (text) navigation
These are keyboard commands that work in (almost) any computer environment. Any person using a computer should know these and they are the absolut basics:

- `ctrl+c`/ `ctrl+v` / `ctrl+x`: copy, paste and cut. Sometimes `ctrl+shift+c` and `ctrl+shift+v` are needed. `ctrl+shift+v` often is 'paste without formatting'
- `win+v`: pasting with a clipboard manager. This lets you select past copied entries from your clipboard. It works natively on Windows and KDE Plasma. With the installations from this repository, clipboard managers are also set up in Gnome, i3 and sway. 
- Holding `shift` and navigating with the arrow keys to select text. 
- `pos1` / `end`: to jump to the beginning / end of a line. Can be combined with `shift` for text selection
- Holding `ctrl` to navigate over words. `ctrl+left/right` lets the cursor jump over one word each. `ctrl+backspace` deletes the previous word, `ctrl+del` deletes the following word. 
- `ctrl+f`: search
- `ctrl+z`: undo
- `ctrl+y` / `ctrl+shift+z`: redo


### Shortcuts to open programs
There are some programs that you open very often. For these it makes sense to set hotkeys to automatically open them. Here is a list of the programs and shortcuts I use frequently (all of these are set up in my CachyOS + Sway environment, and most are also set up in my other setups).

- `ctrl+alt+t` / `mod+enter`: open the terminal (Alacritty)
- `mod+d`/`win`: open the application launcher / search
- `mod+e`: open file manager (Dolphin)
- `mod+c`: open calculator (KCalc)
- `mod+t`: open text editor (Micro)
- `mod+b`: open browser (Firefox)
- `ctrl+shift+alt+c`: open ChatGPT in Firefox
- `ctrl+shift+alt+d`: open DeepL in Firefox
- `ctrl+shift+alt+k`: open Google Keep in Firefox
- `ctrl+shift+alt+s`: open Google Scholar in Firefox
- `ctrl+shift+alt+t`: open Google Translate in Firefox
- `ctrl+shift+alt+g`: open GitHub in Firefox
- `ctrl+shift+alt+w` / `mod+w`: open WhatsApp Web in Firefox
- `ctrl+y`: open YouTube in Firefox
- `ctrl+g`: open my Calendar in Firefox
- `ctrl+shift+alt+n`: open my notetaking / TODO document in VS Code. I find it very useful to have quick access to a scratchpad document for notetaking and current todos. 


### Terminal navigation
- all the ones from [basic (text) navigation](#basic-text-navigation)
- `ctrl+r`: reverse command search in the history using fzf fuzzy search to quickly find past commands to use again
- `ctrl+c`: interrupt the running command
- `ctrl+shift+c`: copy
- `ctrl+shift+c`: paste

### Tiling WM navigation: controls specifically for navigating a tiling window manager
- `mod+arrow key`: move focus to the window in that direction
- `mod+shift+arrow key`: move the focused window in that direction
- `mod+0` ... `mod+9`: switch to workspace 0 to 9
- `mod+shift+0` ... `mod+shift+9`: move the focused window to workspace 0 ... 9
- `mod+d`: open the application launcher (to open new programs)
- `mod+q`: close the focused window
- `mod+f`: toggle fullscreen for the focused window
- `mod+r`: enter resize mode
  - `left/right`: shrink/grow the window width
  - `up/down`: shrink/grow the window height
  - `enter` / `escape` / `mod+r`: leave resize mode
- `mod+alt+left/right`: move the current workspace to the monitor on the left/right
- `mod+shift+g`: automatically arrange the windows on the current workspace in a grid
- `mod+l`: lock the screen
- `mod+shift+e`: show the confirmation dialog to exit

Mouse controls
- `mouse hover`: moves the focus to the window currently hovered by the mouse
- `mod+left mouse button drag`: drag the window to the desired location on the workspace
- `mod+middle mouse button click`: close the selected window
- `mod+right mouse button drag`: resize the window
- (Note: `mod+left mouse button drag` to drag a window and `mod+right mouse button drag` to resize a window work in many other desktop environments too)

Setup
- `mod+alt+1/2/3`: Turn off monitor 1 / 2 / 3 (monitors need to be correctly named in the config)
- `mod+shift+o`: cycle through the display layouts (when using multiple monitors)
- `mod+shift+c`: reload the Sway configuration

Not used often:
- `mod+space`: toggle the focused window between tiling and floating
- `mod+shift+space`: switch focus between tiling and floating windows
- `mod+alt+h`: make the next window split horizontal
- `mod+alt+v`: make the next window split vertical
- `mod+a`: move focus to the parent container


### Navigation in GUI desktops: Shortcuts to navigate a general desktop (no tiling window manager)
Multi-Workspace workflows:
- `ctlr+win+left/right`: Move to the previous / next workspace
- `win+tab`/`super`: task overview, enables moving windows to the desired workspace
- `win+arrow-keys`: Move a window around on the desktop (maximize/minimize, align left/right)
- `win+number` start or switch to this program in the taskbar
- `win+space` Switch between language keyboard input

Mouse controls
- `mod+left mouse button drag`: drag the window to the desired location
- `mod+right mouse button drag`: resize the window




### VSCode: Shortcuts for VSCode
Shortcuts can be added in GUI or in keybindings.json (`Preferences: Open Keyboard Shortcuts (JSON)`). Settings can be added in settings.json (`Preferences: Open User Settings (JSON)`), or only for the workspace (`Preferences: Open Workspace Settings (JSON)`). I synchronize these settings between systems by symlinking the respective settings files from this repository in the intallation scripts. 

Many of the following shortcuts are the defaults, although some need to be manually set


- all the ones from [basic (text) navigation](#basic-text-navigation)
- `Ctrl+#` `Toggle Line Comment`
- `F2`: rename symbol
- `tab` / `shift+tab`: indent / unindent
- `ctrl+ 0`: toggle the terminal
- `ctrl+k z`: focus mode/zen mode (make editor full-screen)
- `Alt+Z`: toggle word-wrap
- `shift+alt+up/down`: multiline/multi-cursor edit
- `alt+left mouse click`: multi-cursor edit
- `Ctrl+Shift+P`: command palette
- `ctrl+.`: quick fix
- `Shift+Enter` Jupyter: Run Selection/Line in Interactive Window
  - also have to edit when expression of shortcut `Jupyter: Run Selection/Line in Interactive Window` to:
    - `editorTextFocus && isWorkspaceTrusted && !findInputFocussed && !isCompositeNotebook && !notebookEditorFocused && !replaceInputFocussed && editorLangId == 'python'`
- `ctrl+shift+enter`: Jupyter: Run To Line in Interactive Window (remove `Insert Code Cell Above` and `Insert Line Before`)
- `ctrl+shift+v` paste (to use same as in terminals)
- `ctrl+shift+c` copy (to use same as in terminals)

- `shift+alt+left/right` smart select, select in paranthesis / brackets / to next comma, etc.
- `ctrl+p` search for file / go to file
- `ctrl+shift+f` workspace search
- `ctrl+shift+e` open explorer tab
- `ctrl+shift+o` go to symbol in file, e.g. section header or function/class definition
- `ctrl+p / ctrl+t, #` go to symbol in the whole workspace
- `ctrl+1/2/3/...` switch between active editors
- `ctrl+w` close the active file
- `ctrl+tab / ctrl+shift+tab` Go through tabs (forward/backward)
- `shift+alt+f` Format Document (needs formatter for the current language installed, e.g. `ms-python.black-formatter`, `C++ Extension Pack` with clang)



### Miscellaneous programs: Shortcuts for Firefox, Zotero, KeepassXC
- In Browsers / Most programs:
    - `Ctrl+Tab`/`Ctrl+Shift+Tab` switch active tab
- Firefox:
    - `ctrl+t` new tab
    - `ctrl+shift+t` reopen last closed tab
    - `ctrl+n` new window
    - `ctrl+shift+n` reopen last closed window
    - `ctrl+shift+d` save all open tabs as bookmark folder
- Zotero:
    - `Alt+Left/Right` to go back/forward after clicking hyperlinks (+ options in menu bar "Go -> Back")
- KeePassXC:
    - `Ctrl+b` copy username
    - `Ctrl+c` copy password
- Terminator: 
    - `Ctrl+Shift+E` split window vertically
    - `Ctrl+Shift+O` split window horizontally
    - `Ctrl+Shift+W` close active window


