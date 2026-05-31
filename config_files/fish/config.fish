source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
function fish_greeting
end

set -g pure_symbol_prompt ">"
set -g pure_symbol_reverse_prompt "<"


export TERMINAL=alacritty

# Use the Vulkan renderer for Sway (required for HDR)
set -gx WLR_RENDERER vulkan

# Use fzf for reverse command search (ctrl+r)
fzf --fish | source
set -x FZF_CTRL_R_OPTS "--with-nth=3.." # Only show the commands (not the time-stamps)

alias grep="rg"
alias find="fd"

# Use dolphin as the file-manager
function fm
	if test (count $argv) -gt 0
		command pcmanfm $argv >/dev/null 2>&1 &
	else
		command pcmanfm . >/dev/null 2>&1 &
	end
	disown
end

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



function conda_init
	# >>> conda initialize >>>
	# !! Contents within this block are managed by 'conda init' !!
	if test -f /home/surfer/miniforge3/bin/conda
		eval /home/surfer/miniforge3/bin/conda "shell.fish" "hook" $argv | source
	else
		if test -f "/home/surfer/miniforge3/etc/fish/conf.d/conda.fish"
			. "/home/surfer/miniforge3/etc/fish/conf.d/conda.fish"
		else
			set -x PATH "/home/surfer/miniforge3/bin" $PATH
		end
	end
	# <<< conda initialize <<<
end

alias mamba_init=conda_init

# conda_init
