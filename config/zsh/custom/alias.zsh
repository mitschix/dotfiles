# alias basics
alias mkdir='mkdir -pv'
alias mkx='chmod u+x'
alias rmd='rm -rf'
alias yeet='rm -rf'
alias ls='ls --color'
alias cl='clear'
alias xopen='xdg-open'
alias za='zathura'

# nvim alias
alias ve='nvim .'
alias sv='sudo nvim'

# show disk info
alias du='du -kh'
alias df='df -kTh'

# more ls alias
alias ..='cd ..'

# global alias
alias -g L='| less'
alias -g G='| grep'
alias -g RG='| rg'

# package manager alias
is_arch=$(command -v pacman)
command -v powerpill > /dev/null && pkg="powerpill" || pkg="pacman"
if [ -n "$is_arch" ];then
  alias pls="$pkg -Ql"        # list files
  alias pup="sudo $pkg -Syyu" # update
  alias pin="sudo $pkg -S"    # install
  alias pun="sudo $pkg -Rs"   # remove
  alias pcc="sudo $pkg -Scc"  # clear cache
  alias prm="sudo $pkg -Rnsc" # really remove, configs and all
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
unset pkg

# networking alias
alias getip='curl ipinfo.io/ip'
alias p1='ping 1.1.1.1'

# git alias
alias ga='git add'
alias gaa='git add -A'
alias gd='git diff'
alias gp='git pull'
alias gf='git fetch'
alias gc='git clone'
alias gs='git status'
alias gst='git stash'
alias gb='git branch'
alias gm='git merge'
alias gch='git checkout'
alias gcm='git commit -m"'
alias glg='git log --stat'
alias gpo='git push origin HEAD'
alias gwch='git whatchanged -p --abbrev-commit --pretty=medium'
alias gpall='find . -mindepth 1 -maxdepth 1 -type d -print -exec git --git-dir={}/.git --work-tree=$PWD/{} pull origin master \;'

# other useful stuff
alias wetter='curl wttr.in/austria'
alias xp='xprop | awk -F\"'" '/CLASS/ {printf \"NAME = %s\nCLASS = %s\n\", \$2, \$4}'"
alias get='curl --continue-at - --location --progress-bar --remote-name --remote-time'

alias capmap="setxkbmap -option caps:escape"

# if advanced copy is installed
# is_advcp=$(command -v cpg)
# if [ -n "$is_advcp" ];then
#   alias cp='cpg -g'
#   alias mv='mvg -g'
# fi
# unset is_advcp

alias info_termite='echo "curl https://raw.githubusercontent.com/thestinger/termite/master/termite.terminfo | sudo tic -x -" | xsel -bi'
