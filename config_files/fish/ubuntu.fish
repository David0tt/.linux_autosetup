# Ubuntu Fish settings; Bash/ble.sh remains configured separately in ~/.bashrc.
# Sway may leave SWAYSOCK in the user environment after logout.
if set -q SWAYSOCK; and not test -S "$SWAYSOCK"
    set -e SWAYSOCK
end

fish_add_path "$HOME/bin" "$HOME/.local/bin" "$HOME/.fzf/bin"
set -gx TERMINAL alacritty
set -gx QT_QPA_PLATFORMTHEME KDE

function fish_greeting
end

set -g pure_symbol_prompt ">"
set -g pure_symbol_reverse_prompt "<"
set -gx FZF_CTRL_R_OPTS "--with-nth=3.." # Hide history entry numbers and timestamps.

# Open the supplied paths, or the current directory, in PCManFM.
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

# Load Conda on demand, rather than slowing down every shell startup.
function conda_init
    if test -x "$HOME/miniforge3/bin/conda"
        "$HOME/miniforge3/bin/conda" shell.fish hook $argv | source
    else if test -f "$HOME/miniforge3/etc/fish/conf.d/conda.fish"
        source "$HOME/miniforge3/etc/fish/conf.d/conda.fish"
    else if test -d "$HOME/miniforge3/bin"
        fish_add_path "$HOME/miniforge3/bin"
    end
end
alias mamba_init=conda_init

# Ruby: use the installed Ruby version instead of a hard-coded CachyOS path.
set -gx GEM_HOME "$HOME/gems"
fish_add_path "$GEM_HOME/bin"
if type -q ruby
    fish_add_path (ruby -r rubygems -e 'puts Gem.user_dir')/bin
end

# Fall back to GCR when there is no working inherited/forwarded SSH agent.
if set -q XDG_RUNTIME_DIR; and test -S "$XDG_RUNTIME_DIR/gcr/ssh"
    if not set -q SSH_AUTH_SOCK; or not test -S "$SSH_AUTH_SOCK"
        set -gx SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/gcr/ssh"
    end
end

# Ubuntu's NVIDIA packages install CUDA under /usr/local/cuda.
for cuda_root in /usr/local/cuda /opt/cuda
    if test -d "$cuda_root/bin"
        fish_add_path "$cuda_root/bin"
        if test -d "$cuda_root/lib64"; and not contains -- "$cuda_root/lib64" $LD_LIBRARY_PATH
            set -gx LD_LIBRARY_PATH "$cuda_root/lib64" $LD_LIBRARY_PATH
        end
        break
    end
end

if status is-interactive
    bind \cc __newline_cancel_commandline
    alias ls='eza'
    alias cat='batcat --paging=never --style=plain'
    alias grep='rg'
    alias find='fdfind'

    if type -q fzf
        fzf --fish | source
    end
    if type -q zoxide
        zoxide init fish --cmd cd | source
    end
end
