# == basic settings 
autoload -U compinit
compinit
	
# ls colors
autoload -U colors && colors

# load configs from ohmyzsh l
eval `dircolors -b` # needed to load ls colors for completion

# == source files/folders

src_files=(
    # ENTER SINGLE FILES FOR SOURCING HERE
)

src_folder=(
	/home/$USER/.config/zsh/omz-conf
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


# == source plugin files
# init fasd
if [ $(command -v fasd) ]
    then eval "$(fasd --init auto)"
fi
# fzf installed via nvim
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh


# from archlabs
# better ls and cd from archlabs
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

