set fish_greeting

if status is-interactive
    set -gx EDITOR nvim
    set -gx VISUAL $EDITOR
end
