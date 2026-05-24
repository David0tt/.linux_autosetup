source /usr/share/cachyos-fish-config/cachyos-config.fish

# overwrite greeting
# potentially disabling fastfetch
#function fish_greeting
#    # smth smth
#end

export TERMINAL=alacritty

# Use fzf for reverse command search (ctrl+r)
fzf --fish | source
set -x FZF_CTRL_R_OPTS "--with-nth=3.." # Only show the commands (not the time-stamps)

alias grep="rg"
alias find="fd"


