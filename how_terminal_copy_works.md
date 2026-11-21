Fish marks the blank line above each prompt. Ctrl+Shift+Y tells Alacritty to copy every line between the two most recent marks. It automates the same selection you were making with the mouse.

On the Fish side, I changed how your Pure theme prints the separator above its two-line prompt. The separator now contains three copies of U+2800 (Unicode Braille Pattern Blank). They look like empty space, but Alacritty can search for them. Ordinary blank lines in command output don’t match. Fish prompt helper

On the Alacritty side, I assigned several actions to the same shortcut. Alacritty runs them in order. Ctrl+Shift+Y binding

1. Starting at the empty > prompt, enter Vi mode and move up to the marker above the directory and Git branch line.
2. Search backward for the previous marker. Move down one line and start a whole-line selection. In your example, that’s ~/.linux_autosetup main ≡ just above > ls.
3. Jump forward to the current marker and move up one line. The selection now ends at the last line of ls output.
4. Copy the selection to the clipboard, clear the highlight, and exit Vi mode.

Because this copies the rendered terminal text, it includes stderr, icons, and blank lines as you saw them. The shortcut assumes your two-line Pure prompt and that both markers are still in scrollback.