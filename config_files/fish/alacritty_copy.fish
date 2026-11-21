# Mark the blank line above Pure's two-line prompt for Alacritty's Ctrl+Shift+Y.
# U+2800 renders blank but is a searchable character in terminal scrollback.
if status is-interactive; and set -q ALACRITTY_WINDOW_ID; and functions -q _pure_prompt_new_line; and not _pure_is_single_line_prompt
    function _pure_prompt_new_line --on-event fish_prompt
        printf '\r\e[K\u2800\u2800\u2800\n'
    end
end
