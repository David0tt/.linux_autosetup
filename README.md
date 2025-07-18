# linux_autosetup
The main point of this repository is to automatically install my whole setup on a ubuntu system by running one script 

    cd ~
    git clone https://github.com/David0tt/.linux_autosetup
    cd .linux_autosetup
    bash install_script.sh

Before installing it might make sense to uncomment some installations in the `install_script.sh`

# Components of this setup:
- i3 window manager
- config files to make everything to my liking
- standard programs I use (firefox, thunderbird, ...)
- modern replacements for some classical shell commands
- 


# Design Philosophy
- use as many standard tools as possible (-> compatability with many other setups)
- make the installation as simple as possible (only one script, if possible use robust installations that are kept up to date, e.g. with apt-get upgrade)
- require as little as possible manual or non-standard setup (i don't like many config files)
- keep everything at one place
- speed is a priority (e.g. when loading the shell)
- Aesthetics are less important than standard compatability
- compatability with other platforms is key (i want to change as little as possible of my workflow when i ssh into some server or use a docker image)
- First: Programs i use and like
- Then: shell features
- Always reason from functionality i want to have and why, to how to get it with minimal setup, maximal standard adherance and minimal performance overhead
- take your hands off the keyboard as little as possible
- it should be intuitive where everything is (no searching for some open window
- when i show people something, it should be comprehensible what i am doing, without much background knowledge
- everything should be installed in such a way, that it is automatically updated when possible. So in most cases use apt or snap if available

Which shell to use?
Main contenders are bash vs zsh vs fish
-> Bash is the standard, so i would like to use this. I can get all the features i want in bash, so this is preferred

Which Tiling system to use?

- tiling window manager (i3), terminator, tmux

Notable Mentions and why i am not using them:

- vim / neovim: i don't want to learn the commands,  i pick just the features i want for other editors, setup of VSCode is easier and with plugins i would say it is more powerful
- 

I want as little as possible in the taskbar, since this is all visual clutter (programs to launch should be in a searchable start menu)


# Other things that i could look into:
- maybe also try Hyprland -> Probably not, is mostly nice ui focused and appears to have some bugs
- also try awesome window manager -> felt more clunky and less supported for me
- sway: would be a good replacement for i3 in the future. However right now, some apps don't work natively in sway, since they rely too much on x11 (e.g. snap installed discord, which causes a crash on start). Also, open-vm-tools is not well integrated with sway/wayland for now -> I will use i3 for now, i will switch when wayland/sway support is more mature, this switch should be rather simple, as configs generally are compatible (-> Note again, i don't want to depend on many other tools for this!)






# Tiling window Manager features
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



# On different shells: 
A different shell
(bash, zsh, Fish)
Fish -> better experience without modifications
Zsh -> more modifications possible, see oh-my-zsh or zinit
In the end, i want to be as compatible as possible, so i am choosing bash, since i can get all the functionality i need there with little modification (mainly by using ble.sh)
What i want from my shell:
- user@machine /Directory prompt -> modify PROMPT or PS1 variable
- syntax highlighting -> ble.sh
- command autosuggestions -> ble.sh i actually don't want this
- autocomplete -> already built in
- autocomplete preview -> ble.sh (but currently not working
- fuzzy history search -> already from fzf
- shared history across sessions [TODO!]
- searchable history with ctrl+r (also fuzzy) -> already from fzf
- smart case sensitivity
- background job notifications
- spelling correction proposals -> fuck [TODO!]
- (fuzzy autocomplete)
- (git-aware prompt)
- Plus: Bash / scripting POSIX-compliant
- Fish has great defaults, but is not POSIX compliant
- See this for features that i might want: https://chatgpt.com/c/686acb3b-6e34-800c-a9b9-276aceb84fcc
- Look into zsh + oh-my-zsh
- in particular plugins:
  - powerlevel10k
  - zsh-autosuggestions
  - zsh-syntax-highlighting
  - fzf
  - git
  - history-substring-search
- how can i make it most compatible with bash (e.g. for the setups that have been made in ~/.bashrc
- alternative: make bash compliant with all these features
- FINDING: I tried zsh, with some nice configs, e.g. from https://www.youtube.com/watch?v=ud7YxC33Z3w ; but i found that i could get the same functionality just in bash, which is more portable, ubiquitous and POSIX compliant, and also has faster startup times in my testing (oh-my-zsh was extremely slow, but even zinit was about 3 times slower than bash)

autocomplete preview
fuzzy autocomplete
automatically propose corrected command ("did you mean..." and possibility to automatically execute it)


# Vim vs. other code editors

- many people swear by vim for speedup
- however, i don't want to loose the comfort of a graphical interface in VSCode, especially with all the extensions its setup is very easy
- to get a good vim config is quite some stuff to do
- Also, Vim does not produce much of a speedup compared to using good "normal navigation"
- Advantage is, that "normal" navigation works in almost all environments (Browser search bar, other textfields, ...). For the advanced navigation i have to set up the environment anyways. Going into some remote ssh server and having vim there is not really an argument, since here "normal" navigation still works, and if i want to do something extensive i want all my other stuff too (LSP, syntax highlighting, nice ide features), so i would need to install an environment anyways
- I pick the features from vim i want
- Other considerations:
  - Speed / Startup speed: As long as it is not too slow, it is fine. Note, that you pay for features (e.g. if you want an LSP, syntax highlighting, ...); As a rule of thumb i would say that with similar features, startup times are similar across programs.
  - when i show people something, it should be comprehensible what i am doing, without much background knowledge

# Feature comparison:

# Note: many of the "normal" navigations work in any kind of environment (e.g. Find in Browser)

# Note: a straight forward comparison of keypresses is not possible, since it depends on whether or not we count the ESC presses for Vim. Also, Hand movements are not counted (e.g. jklö is closer to normal typing position than arrow keys, and POS1, END, DEL keys are quite far). For a fair comparison, we should look at the commands and keystrokes needed to do some standard text task.

# Comparison along the lines of Vim Tutor: https://gist.github.com/hashrocketeer/852a4f878acd42abbf98f18278329bdc
- Navigation (jklö vs. arrow keys); holding ctrl for faster navigation (jumping through words), POS1 and END keys
- deleting stuff: words (ctrl+Backspace/Del) vs. (ESC,dw), to beginning/end of line: Shift+END/POS1,Del/Backspace vs (d$)
- delete a number of objects (in vim: [number] d object / d [number] object) vs. (just clicking ctrl+backspace/Del mutliple times)
- deleting line: ctrl+X in VSCode
- clicking at some position in the text is sometimes quite fast, even faster than navigating there!
- Switching between Normal / Insert / Command mode takes time
- I would not use the "Advanced" features of vim so often, so finding a specific solution in that case or scripting is fine
- Enclose in Braces: select with shift+(ctrl)+left/right and click ( / [ / { / " / '
- Undo / redo (ctrl+z / ctrl+y) vs. u / U
- redo commands (vim: ctrl+r) -> TODO find something like this?
- putting (in vim, delete something, the p to put it) vs. (selecting, ctrl+x -> ctrl+v)
- Replace Command (r)
- Change Command (cw)
- Search: / and ? vs. ctrl+f; Find + Replace, use find to jump to some location in the text
- Matching Paranthesis search: % to find a matching ), ], } vs. syntax highlighting does this for me, [TODO] but jumping there would be nice -> exists, with ctrl+shift+^; selecting in current paranthesis/brackets/etc. can be done with smart select: shift+alt+left/right
- Substitution - ctrl+f find and replace does this for me
- External commands: I don't need this in my editor, i just have a terminal open (or ctrl+`)
- Open Command: o vs. END+Enter
- Append / Insert: a / i -> Not needed, when i have navigation
- 

# Mainly from VSCode:
- Multiline Edits (win+alt+Up/Down, hold alt and click to multiple locations with mouse)
- F2 for semantic rename
- ctrl+. for code actions

# Bonus: Remote compatability
- vscode remote extension is extremely powerful





# TODO
TODO maybe get all the shell completions using bashit
TODO look at `jj`
[TODO add alias to start a bash in the newest docker container]

[TODO try https://github.com/google-gemini/gemini-cli ]

[TODO make this a gist somewhere, that can simply be installed with wget ...  | sudo bash or something like that (also to install everything, or just the minimal features]

[TODO find some efficient system wide keypass integration, so i dont always have to open the app]
examine tmux
- https://github.com/dreamsofcode-io/tmux
- https://tmuxcheatsheet.com/
- Why? more light-weight, more available in ssh sessions, more scriptable
- needed tmux config: 
  - TODO do tmux tutorial
  - add mouse support
  - allow find
  - nicer layout
  - allow copy & paste / yanking
  - nice hotkeys for navigation (should match tiling window manager)
  - predefined sessions
[Hotkey to copy the current line from the shell]

[alert for long running tasks]

# TODO
- change the bar sizes for resizing windows with mouse -> DONE
- add x / minimize options on windows -> DONE: mod+middle mouse for closing and mod+right to toggle floating
- auto-layout -> DONE
- adjust taskbar -> DONE
- start menu (ctrl) -> should show different graphical programs i might want to use, and a search bar to search -> Not solved for now, but st with fzf works fine
- fzf program searach when clicking ctrl+d -> st with fzf
- something to change the volume
- vscode open folder in i3 -> DONE just go full screen / floating
- custom scripts to start up my workspaces
- allow setting audio by scrolling wheel on keyboard
- VSCode Open File dialogue does not quite work, but making it a non floating window (mod+shift+space) or when VSCode is in fullscreen mode (mod+f) is fine
- try if st would be a good terminal for everything (test images)
- install yazi, with all dependencies https://yazi-rs.github.io/docs/installation/

- For most works i want all relevant windows in one workspace (Standard development setup: ChatGPT, Firefox for Search, VSCode, Terminals)
- Use different workspaces for different tasks (e.g. second coding task, with all the windows as above)
- I don't think i will use many predefined workspaces, but lets see
- A dedicated startup script to get the development environment would be nice
- do i want the same window on multiple workspaces? -> Probably actually No!
- add close button to windows -> No, mod+middle mouse works very well
cron jobs

pass highlighting through e.g. eza -> rg
https://github.com/helix-editor/helix
# [TODO] try VSCode snippets (e.g. enclose something with "#" border)
# TODO set ctrl+shift+c / ctrl+shift+v hotkeys in vscode to be compatible with terminal copy-paste
# [TODO] terminal set scrollback length (in best case infinite)
# [TODO] fuzzy find in VSCode https://marketplace.visualstudio.com/items?itemName=rlivings39.fzf-quick-open

hotkey für einkaufsliste
hotkey für mitnehmliste
- lock hotkey win+l (compatible with win, ubuntu)


- navigate more in vscode with mouse-forward / backward
- keepassXC browser integration (and other locations)
- check whether i will ever use fdfind if i have fzf (however, it could be useful to replace find by fdfind for fzf for more speed)
- tmux dotfile: https://github.com/elijahmanor/dotfiles/blob/lua/tmux/.tmux.conf

use `cd -` more often

