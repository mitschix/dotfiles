# alias basics
alias mkdir='mkdir -pv'
alias mkx='chmod u+x'
alias rmd='rm -rf'
alias yeet='rm -rf'
alias ls='ls --color'
alias cl='clear'
alias za='zathura'
alias _='sudo '

# show disk info
alias duh='du -khd1'
alias du='du -kh'
alias df='df -kTh'

# more ls alias
alias ..='cd ..'

# global alias
alias -g L='| less'
alias -g G='| grep'
alias -g RG='| rg'

# "inspired" by https://github.com/Jxck/dotfiles/blob/master/zsh/common.zsh
alias -g N="1>/dev/null 2>/dev/null"          # No Output
alias -g B="1>/dev/null 2>/dev/null &"        # Background
alias -g A="2>&1"                             # All (merge stdout/err)
alias -g C="2>&1 | color"                     # Color (All then colorize) --> bin from jxck
alias -g H="| xxd -g 1 -c 4"                  # Hex

is_dragon=$(command -v dragon-drop)
if [ -n "$is_dragon" ];then
    alias drag="dragon-drop -x -i"
fi
unset is_dragon

# package manager alias {{{
is_arch=$(command -v pacman)
if [ -n "$is_arch" ];then
  alias pls="pacman -Ql"        # list files
  alias pup="sudo pacman -Syyu" # update
  alias pin="sudo pacman -S"    # install
  alias pun="sudo pacman -Rs"   # remove
  alias pcc="sudo pacman -Scc"  # clear cache
  alias prm="sudo pacman -Rnsc" # really remove, configs and all
  alias plast="tac /var/log/pacman.log | sed -n '/full system upgrade/q;s/.*\[ALPM\] upgraded //p'"
  is_yay=$(command -v yay)
  if [ -n "$is_yay" ];then
    alias yls='yay -Qqm'        # list files
    alias yup='yay'             # update
    alias yin='yay -S'          # install
    alias yun='yay -Rs'         # remove
    alias ycc='yay -Scc'        # clear cache
    alias yrm='yay -Rnsc'       # really remove, configs and all
  fi
  unset is_yay
else
  alias als='dpkg -l'
  alias aup='sudo apt update ; sudo apt upgrade -y'
  alias ain='sudo apt install'
  alias aun='sudo apt remove'
  alias acc='sudo apt autoremove -y; sudo apt autoclean -y'
  alias arm='sudo apt purge'
fi
unset is_arch
# }}}

# networking alias
alias getip='curl ipinfo.io/ip'
alias p1='ping 1.1.1.1'
alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'
alias sort-by-ip="sort -n -t . -k 1,1 -k 2,2 -k 3,3 -k 4,4"

# git alias
has_lazygit=$(command -v lazygit)
if [ -n "$has_lazygit" ];then
    alias g='lazygit' # need lazygit installed
fi
unset has_lazygit

# other useful stuff
alias wetter='curl wttr.in/austria'
alias xp='xprop | awk -F\"'" '/CLASS/ {printf \"NAME = %s\nCLASS = %s\n\", \$2, \$4}'"
alias capmap="setxkbmap -option caps:escape"
alias remove-color="sed 's/\x1b\[[0-9;]\{1,\}[a-za-z]//g'"

# stolen from omz urltools plugin (only two lines that matter)
alias urlencode='python3 -c "import sys; del sys.path[0]; import urllib.parse as up; print(up.quote_plus(sys.argv[1]))"'
alias urldecode='python3 -c "import sys; del sys.path[0]; import urllib.parse as up; print(up.unquote_plus(sys.argv[1]))"'
