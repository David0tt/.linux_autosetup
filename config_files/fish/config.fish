source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
function fish_greeting
end

set -g pure_symbol_prompt ">"
set -g pure_symbol_reverse_prompt "<"


export TERMINAL=alacritty

# Use fzf for reverse command search (ctrl+r)
fzf --fish | source
set -x FZF_CTRL_R_OPTS "--with-nth=3.." # Only show the commands (not the time-stamps)

alias grep="rg"
alias find="fd"

function __newline_cancel_commandline
	if test -n "$(commandline)"
		commandline -f cancel-commandline
	else
		echo
		commandline -f repaint
	end
end

if status is-interactive
	bind \cc __newline_cancel_commandline
end


