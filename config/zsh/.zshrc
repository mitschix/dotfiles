# == basic settings
autoload -U compinit
compinit

# ls colors
autoload -U colors && colors

# load configs from ohmyzsh l
eval `dircolors -b` # needed to load ls colors for completion
LS_COLORS+=':ow=01;33' # quickfix for windoof folder permissions

# fzf installed via nvim
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh

# == source files/folders

# source omz config and plugins
for f (~/.config/zsh/omz-config/**/*.zsh(N.)) source $f
for f (~/.config/zsh/omz-plugins/used/**/*.zsh(N.)) source $f

# source custom/persistent plugins
for f (~/.config/zsh/plugins/**/*.zsh(N.)) source $f

# source config files (after omz to overwrite e.g. alias)
source ~/.config/zsh/custom/vim-conf.zsh
source ~/.config/zsh/custom/history.zsh
source ~/.config/zsh/custom/alias.zsh
source ~/.config/zsh/custom/functions.zsh
source ~/.config/zsh/custom/keybinds.zsh

# load local zshrc file if it exists
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/zsh/.zshrc.local ] && \
    source "${XDG_CONFIG_HOME:-$HOME/.config}"/zsh/.zshrc.local

# call the startup timer
typeset -F SECONDS
seconds_to_milliseconds $SECONDS

eval "$(starship init zsh)"
