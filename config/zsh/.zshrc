# == basic settings
autoload -U compinit
compinit

# ls colors
autoload -U colors && colors
eval `dircolors -b` # needed to load ls colors for completion

# fzf installed via nvim
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh ] && \
    source "${XDG_CONFIG_HOME:-$HOME/.config}"/fzf/fzf.zsh

# source plugins custom/persistent + omz lib/plugins
for f ("$ZDOTDIR"/plugins/**/*.zsh(N.)) source $f

# source config files (after plugins to overwrite e.g. alias)
source "$ZDOTDIR"/custom/vim-conf.zsh
source "$ZDOTDIR"/custom/history.zsh
source "$ZDOTDIR"/custom/alias.zsh
source "$ZDOTDIR"/custom/functions.zsh
source "$ZDOTDIR"/custom/keybinds.zsh

# load local zshrc file if it exists
[ -f "$ZDOTDIR"/.zshrc.local ] && source "$ZDOTDIR"/.zshrc.local

# call the startup timer
typeset -F SECONDS
seconds_to_milliseconds $SECONDS

eval "$(starship init zsh)"
