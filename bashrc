# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

bind "set bell-style visible"
bind "set completion-ignore-case on"
bind "set completion-map-case on"
bind "set show-all-if-ambiguous on"
bind "set mark-symlinked-directories on"
bind "set colored-stats on"
bind "set completion-query-items 20"

# History control
HISTIGNORE="&:cd ~:cd ..:exit:??"
HISTCONTROL=ignoreboth:erasedups
HISTSIZE=10000
HISTFILESIZE=50000

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set PATH so it includes user's local bin if it exists
if [ -d "$HOME/bin" ] ; then PATH="$HOME/bin:$PATH"; fi
if [ -d "$HOME/.local/bin" ]; then PATH="$HOME/.local/bin:$PATH"; fi

export EDITOR=vim
export VISUAL=$EDITOR
if [ -e /usr/share/terminfo/x/xterm-256color ]; then
    export TERM='xterm-256color'
else
    export TERM='xterm-color'
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Alias definitions.
[ -f ~/.bash_aliases ] && source ~/.bash_aliases

# Customize prompt
[ -f ~/.bash_ps1 ] && source ~/.bash_ps1

# Local configurations
[ -f ~/.bashrc.local ] && source ~/.bashrc.local

function tmux()
{
    TMUX_BIN=`which tmux`
    TMUX_CMD="direnv exec / $TMUX_BIN"
    TERM=screen-256color $TMUX_CMD $@
}

source /usr/local/share/chruby/chruby.sh
source /usr/local/share/gem_home/gem_home.sh
eval "$(direnv hook bash)"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND="fd --type file"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="--select-1 --exit-0"
