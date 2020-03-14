autoload -U compinit
compinit
	
# ls colors
autoload -U colors && colors

# load configs from ohmyzsh l
eval `dircolors -b` # needed to load ls colors for completion

src_files=(
	# git clone https://github.com/zsh-users/zsh-autosuggestions
	/home/$USER/.config/zsh/plugs/zsh-autosuggestions/zsh-autosuggestions.zsh
	# nnn https://github.com/jarun/nnn.git
	/home/$USER/.config/nnn/misc/quitcd/quitcd.bash_zsh
)

src_folder=(
	/home/$USER/.config/zsh/lib
	/home/$USER/.config/zsh/custom
)

# functions to source files
source_file(){
	[ -f $1 ] && source $1
}
source_folder(){
# Load all files from .shell/zshrc.d directory
	if [ -d $1 ]; then
	  for file in $1/*; do
		source $file
	  done
	fi
}

# source files and folder
for f in $src_files;do source_file $f;done
for fol in $src_folder;do source_folder $fol;done


if [ $(command -v fasd) ]
    then eval "$(fasd --init auto)"
fi


# expand alias with space
globalias()
{
	zle _expand_alias
	zle self-insert
}
zle -N globalias

bindkey ' ' globalias   # [Space] - do alias expansion


# useful functions
# from manjaro zsh config
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# from OMZ plugin
# Remove python compiled byte-code and mypy/pytest cache in either the current
# directory or in a list of specified directories (including sub directories).
function pyclean() {
    ZSH_PYCLEAN_PLACES=${*:-'.'}
    find ${ZSH_PYCLEAN_PLACES} -type f -name "*.py[co]" -delete
    find ${ZSH_PYCLEAN_PLACES} -type d -name "__pycache__" -delete
    find ${ZSH_PYCLEAN_PLACES} -depth -type d -name ".mypy_cache" -exec rm -r "{}" +
    find ${ZSH_PYCLEAN_PLACES} -depth -type d -name ".pytest_cache" -exec rm -r "{}" +
}


# from OMZ
function take() {
  mkdir -p $@ && cd ${@:$#}
}
# from archlabs
# better ls and cd  from archlabs
unalias ls >/dev/null 2>&1
ls()
{
  command ls --color=auto -F "$@"
}

unalias cd >/dev/null 2>&1
cd()
{
  builtin cd "$@" && command ls --color=auto -F
}

# OMZ configs, aliases and co. so no file sourcing is necessary
# -- begin
# grep.zsh
# is x grep argument available?
grep-flag-available() {
    echo | grep $1 "" >/dev/null 2>&1
}

GREP_OPTIONS=""

# color grep results
if grep-flag-available --color=auto; then
    GREP_OPTIONS+=" --color=auto"
fi

# ignore VCS folders (if the necessary grep flags are available)
VCS_FOLDERS="{.bzr,CVS,.git,.hg,.svn}"

if grep-flag-available --exclude-dir=.cvs; then
    GREP_OPTIONS+=" --exclude-dir=$VCS_FOLDERS"
elif grep-flag-available --exclude=.cvs; then
    GREP_OPTIONS+=" --exclude=$VCS_FOLDERS"
fi

# export grep settings
alias grep="grep $GREP_OPTIONS"

# clean up
unset GREP_OPTIONS
unset VCS_FOLDERS
unfunction grep-flag-available

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


export XKB_DEFAULT_LAYOUT=de
# setup env vars when in tty1
if [ $(tty) = "/dev/tty1" ];then

    # set PATH so it includes user's private bin if it exists
    if [ -d "$HOME/.local/bin" ] ; then
        PATH="$HOME/.local/bin:$PATH"
    fi

    export PATH="/usr/sbin:/sbin:$PATH"

    # custom env vars
    export TERMINAL="termite"
    export EDITOR="nvim"
    export PAGER="less"
fi
