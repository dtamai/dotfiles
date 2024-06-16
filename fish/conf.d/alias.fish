alias ll "exa -lah --group-directories-first"

alias grep "grep --color"

alias dps "docker ps --format \"table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Image}}\t{{.Ports}}\""
alias dpsa "docker ps -a --format \"table {{.ID}}\t{{.Names}}\t{{.Status}}\t{{.Image}}\t{{.Ports}}\""

alias vim nvim

alias tmux "direnv exec / tmux"
