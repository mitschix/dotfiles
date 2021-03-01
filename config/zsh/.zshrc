# == basic settings
autoload -U compinit
compinit

# ls colors
autoload -U colors && colors

# load configs from ohmyzsh l
eval `dircolors -b` # needed to load ls colors for completion
LS_COLORS+=':ow=01;33' # quickfix for windoof folder permissions

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

    export _FASD_DATA=$HOME/.local/share/fasd
    
    fasd_cache="$HOME/.cache/fasd-init-zsh"
    if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
        fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install>| "$fasd_cache"
    fi
    source "$fasd_cache"
    unset fasd_cache
fi

# source navi interactive cheatsheet
# https://github.com/denisidoro/navi
if [ $(command -v navi) ]; then
    eval "$(navi widget zsh)"
fi

# fzf installed via nvim
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh

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

# source omz plugins
source ~/.config/zsh/omz-plugs/copybuffer/copybuffer.plugin.zsh
source ~/.config/zsh/omz-plugs/copydir/copydir.plugin.zsh
source ~/.config/zsh/omz-plugs/cp/cp.plugin.zsh
source ~/.config/zsh/omz-plugs/dircycle/dircycle.plugin.zsh
source ~/.config/zsh/omz-plugs/dirhistory/dirhistory.plugin.zsh
source ~/.config/zsh/omz-plugs/encode64/encode64.plugin.zsh
source ~/.config/zsh/omz-plugs/git-auto-fetch/git-auto-fetch.plugin.zsh
source ~/.config/zsh/omz-plugs/globalias/globalias.plugin.zsh
source ~/.config/zsh/omz-plugs/jsontools/jsontools.plugin.zsh
source ~/.config/zsh/omz-plugs/magic-enter/magic-enter.plugin.zsh
source ~/.config/zsh/omz-plugs/urltools/urltools.plugin.zsh
source ~/.config/zsh/omz-plugs/zsh_reload/zsh_reload.plugin.zsh
	
# overwrite history settings from omz installed with zplug
HISTFILE="$HOME/.config/zsh/zhist"

