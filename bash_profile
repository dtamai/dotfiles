# User dependent .bash_profile file

# source the users bashrc if it exists
if [ -f "${HOME}/.bashrc" ] ; then
  source "${HOME}/.bashrc"
fi

bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

alias ls="ls --color"
alias ll="ls -lah"
alias grep="grep --color"

function h {
  history | tail -n 10
}

export HISTIGNORE="&:cd ~:cd ..:exit:h:history:??"
export HISTCONTROL=ignoreboth:erasedups

export EDITOR=vim
if [ -e /usr/share/terminfo/x/xterm-256color ]; then
  export TERM='xterm-256color'
else
  export TERM='xterm-color'
fi

#  Customize BASH PS1 prompt to show current GIT repository and branch.
#  by Mike Stewart - http://MediaDoneRight.com

#  SETUP CONSTANTS
#  Bunch-o-predefined colors.  Makes reading code easier than escape
#  sequences.
#  I don't remember where I found this.  o_O

# Reset
Color_Off="\033[0m"       # Text Reset

# Regular Colors
Black="\033[0;30m"        # Black
Red="\033[0;31m"          # Red
Green="\033[0;32m"        # Green
Yellow="\033[0;33m"       # Yellow
Blue="\033[0;34m"         # Blue
Purple="\033[0;35m"       # Purple
Cyan="\033[0;36m"         # Cyan
White="\033[0;37m"        # White

# Bold
BBlack="\033[1;30m"       # Black
BRed="\033[1;31m"         # Red
BGreen="\033[1;32m"       # Green
BYellow="\033[1;33m"      # Yellow
BBlue="\033[1;34m"        # Blue
BPurple="\033[1;35m"      # Purple
BCyan="\033[1;36m"        # Cyan
BWhite="\033[1;37m"       # White

# Underline
UBlack="\033[4;30m"       # Black
URed="\033[4;31m"         # Red
UGreen="\033[4;32m"       # Green
UYellow="\033[4;33m"      # Yellow
UBlue="\033[4;34m"        # Blue
UPurple="\033[4;35m"      # Purple
UCyan="\033[4;36m"        # Cyan
UWhite="\033[4;37m"       # White

# Background
On_Black="\033[40m"       # Black
On_Red="\033[41m"         # Red
On_Green="\033[42m"       # Green
On_Yellow="\033[43m"      # Yellow
On_Blue="\033[44m"        # Blue
On_Purple="\033[45m"      # Purple
On_Cyan="\033[46m"        # Cyan
On_White="\033[47m"       # White

# High Intensty
IBlack="\033[0;90m"       # Black
IRed="\033[0;91m"         # Red
IGreen="\033[0;92m"       # Green
IYellow="\033[0;93m"      # Yellow
IBlue="\033[0;94m"        # Blue
IPurple="\033[0;95m"      # Purple
ICyan="\033[0;96m"        # Cyan
IWhite="\033[0;97m"       # White

# Bold High Intensty
BIBlack="\033[1;90m"      # Black
BIRed="\033[1;91m"        # Red
BIGreen="\033[1;92m"      # Green
BIYellow="\033[1;93m"     # Yellow
BIBlue="\033[1;94m"       # Blue
BIPurple="\033[1;95m"     # Purple
BICyan="\033[1;96m"       # Cyan
BIWhite="\033[1;97m"      # White

# High Intensty backgrounds
On_IBlack="\033[0;100m"   # Black
On_IRed="\033[0;101m"     # Red
On_IGreen="\033[0;102m"   # Green
On_IYellow="\033[0;103m"  # Yellow
On_IBlue="\033[0;104m"    # Blue
On_IPurple="\033[10;95m"  # Purple
On_ICyan="\033[0;106m"    # Cyan
On_IWhite="\033[0;107m"   # White

# Various variables you might want for your PS1 prompt instead
Time12h="\t"
Time12a="\@"
PathShort="\w"
PathFull="\W"
NewLine="\n"
Jobs="\j"


# This PS1 snippet was adopted from code for MAC/BSD I saw from:
# http://allancraig.net/index.php?option=com_content&view=article&id=108:ps1-export-command-for-git&catid=45:general&Itemid=96
# I tweaked it to work on UBUNTU 11.04 & 11.10 plus made it mo' better

# Git do Cygwin tinha essa função, Git do Windows não
__git_ps1 ()
{
  local __ps1=
  `git branch &>/dev/null`
  if [ $? -eq 0 ]; then
    echo `git status` | grep "nothing to commit" > /dev/null 2>&1
    if [ "$?" -eq "0" ]; then
      # Clean repository - nothing to commit
      __ps1=$Green'('$(__git_branch)')'
    else
      # Changes to working tree
      __ps1=$IRed'{'$(__git_branch)'}'
    fi
  fi
  echo -e " $__ps1 "
}

__git_branch ()
{
  local b="$(git symbolic-ref HEAD 2>/dev/null)";
  if [ -n "$b" ]; then
    echo ${b##refs/heads/}
  fi
}

# Outputs the current trunk, branch, or tag
__svn_branch()
{
  local url=
  if [[ -d .svn ]]; then
    url=`svn info | awk '/URL:/ {print $2}'`
    if [[ $url =~ trunk ]]; then
      echo trunk
    elif [[ $url =~ /branches/ ]]; then
      echo "branch `echo $url | sed -e 's#.*branches\(.*\)/#\1#'`"
    elif [[ $url =~ /tags/ ]]; then
      echo "tag `echo $url | sed -e 's#.*tags/(.*\)/#\1#'`"
    fi
  fi
}

#export SVN_SHOWDIRTYSTATE=1
# Outputs the current revision
__svn_rev()
{
  echo $(svn info | awk '/Revisão:/ {print $2}')
}

__svn_ps1()
{
  local __ps1
  if [ ! -z $SVN_SHOWDIRTYSTATE ]; then
    local svnst flag
    svnst=$(svn status | grep '^\s*[?ACDMR?!]')
    if [ -z "$svnst" ]; then
      __ps1=$Green'('$(__svn_branch):$(__svn_rev)')'
    else
      __ps1=$IRed'{'$(__svn_branch):$(__svn_rev)'}'
    fi
  else
    __ps1='('$(__svn_branch):$(__svn_rev)')'
  fi
  echo -e " $__ps1 "
}

# Git/Subversion prompt function
__git_svn_ps1()
{
  local s=
  if [[ -d ".git" ]]; then
    s=`__git_ps1`
  elif [[ -d ".svn" ]]; then
    s=`__svn_ps1`
  fi
  echo -n "$s"
}

__job_count()
{
  local j=$(jobs -s | wc -l)
  if [ $j -eq 0 ]; then
    j=$Green"No jobs"$Color_Off
  elif [ $j -eq 1 ]; then
    j=$Cyan[$j]$Color_Off
  elif [ $j -eq 2 ]; then
    j=$Yellow[$j]$Color_Off
  else
    j=$Red{$j}$Color_Off
  fi
  echo -e "$j"
}

export PS1=$BCyan$Time12h$Color_Off' $(__git_svn_ps1)'$BYellow$PathShort$Color_Off' $(__job_count) '" \n\$ "

# Função para mudar o título da janela
function settitle
{ 
  echo -ne "\e]2;$@\a\e]1;$@\a"; 
}

function sohtopipe
{
  sed 's/\x01/|/g';
}

function fixtail
{
  tail -f $1 | sed 's/\x01/|/g';
}

function fixgrep
{
  grep $1 $2 | sed -e 's/\x01/|/g' -e ''/$1/s//`printf "$BIGreen$1$Color_Off"`/'';
}

source /usr/local/share/chruby/chruby.sh
chruby 2.1.1
