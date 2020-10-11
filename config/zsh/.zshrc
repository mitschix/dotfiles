# == basic settings
autoload -U compinit
compinit

# ls colors
autoload -U colors && colors

# load configs from ohmyzsh l
eval `dircolors -b` # needed to load ls colors for completion

# == source files/folders

# source omz files
source ~/.config/zsh/omz-conf/omz-clipboard.zsh
source ~/.config/zsh/omz-conf/omz-completion.zsh
source ~/.config/zsh/omz-conf/omz-directories.zsh
source ~/.config/zsh/omz-conf/omz-history.zsh
source ~/.config/zsh/omz-conf/omz-key-bindings.zsh
source ~/.config/zsh/omz-conf/omz-spectrum.zsh

# source config files
source ~/.config/zsh/custom/zplug.zsh
source ~/.config/zsh/custom/vim-conf.zsh
source ~/.config/zsh/custom/zprompt.zsh
source ~/.config/zsh/custom/alias.zsh
source ~/.config/zsh/custom/functions.zsh
source ~/.config/zsh/custom/grep-config.zsh
source ~/.config/zsh/custom/keybinds.zsh
source ~/.config/zsh/omz-plugs/globalias/globalias.plugin.zsh
	
# overwrite history settings from omz installed with zplug
HISTFILE="$HOME/.config/zsh/zhist"

# == source plugin files
# init fasd
if [ $(command -v fasd) ]; then
    # available alias with fasd
    # alias a='fasd -a'        # any
    # alias s='fasd -si'       # show / search / select
    # alias d='fasd -d'        # directory
    # alias f='fasd -f'        # file
    # alias sd='fasd -sid'     # interactive directory selection
    # alias sf='fasd -sif'     # interactive file selection
    # alias z='fasd_cd -d'     # cd, same functionality as j in autojump
    # alias zz='fasd_cd -d -i' # cd with interactive selection
    
    fasd_cache="$HOME/.cache/fasd-init-zsh"
    if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
        fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install>| "$fasd_cache"
    fi
    source "$fasd_cache"
    unset fasd_cache
fi
# fzf installed via nvim
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh


