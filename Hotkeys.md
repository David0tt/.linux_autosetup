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
