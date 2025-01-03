# == basic settings
autoload -U compinit
compinit

# ls colors
autoload -U colors && colors

# load configs from ohmyzsh l
eval `dircolors -b` # needed to load ls colors for completion
LS_COLORS+=':ow=01;33' # quickfix for windoof folder permissions

# == source plugin files
# init fasder
if [ $(command -v fasder) ]; then
    # available alias with fasder
    # alias a='fasder'
    # alias d='fasder -d'
    # alias f='fasder -f'
    # alias v='fasder -fe $EDITOR'

    # available commands with fasder
    # vv foo          # Interactive file edition with fzf
    # j abc           # cd, same functionality as j in autojump (default j => change to z)
    # jj foo          # Interactive directory navigation with fzf (default j => change to z)

    fasder_cache="$HOME/.cache/fasder-init-zsh"
    if [ "$(command -v fasder)" -nt "$fasder_cache" -o ! -s "$fasder_cache" ]; then
        fasder --init auto aliases >| "$fasder_cache"
    fi
    source "$fasder_cache"
    unset fasder_cache
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
# source ~/.config/zsh/omz-plugs/git-auto-fetch/git-auto-fetch.plugin.zsh
source ~/.config/zsh/omz-plugs/globalias/globalias.plugin.zsh
source ~/.config/zsh/omz-plugs/jsontools/jsontools.plugin.zsh
source ~/.config/zsh/omz-plugs/magic-enter/magic-enter.plugin.zsh
source ~/.config/zsh/omz-plugs/urltools/urltools.plugin.zsh
source ~/.config/zsh/omz-plugs/zsh_reload/zsh_reload.plugin.zsh
source ~/.config/zsh/omz-plugs/kubectl/kubectl.plugin.zsh

# overwrite history settings from omz installed with zplug
HISTFILE="$HOME/.config/zsh/zhist"

# load local zshrc file if it exists
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/zsh/.zshrc.local ] && \
    source "${XDG_CONFIG_HOME:-$HOME/.config}"/zsh/.zshrc.local

eval "$(starship init zsh)"
