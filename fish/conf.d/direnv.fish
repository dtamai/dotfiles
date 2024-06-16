set -g direnv_fish_mode disable_arrow

if status is-interactive
    direnv hook fish | source
end
