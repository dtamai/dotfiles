set -gx FZF_DEFAULT_COMMAND "fd --type file"
set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
set -gx FZF_CTRL_T_OPTS "--select-1 --exit-0"

if status is-interactive
    fzf --fish | source
end
