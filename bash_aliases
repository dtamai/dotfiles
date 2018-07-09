# User defined aliases

alias ls="ls --color"
alias ll="ls -lah --group-directories-first"
alias grep="grep --color"
alias dps="docker ps --format \"table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Image}}\t{{.Ports}}\""
alias dpsa="docker ps -a --format \"table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Image}}\t{{.Ports}}\""

function dstop
{
  docker stop $(docker ps -q)
}

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'