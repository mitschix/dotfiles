# setup XDG paths
export XDG_DATA_HOME=${XDG_DATA_HOME:="$HOME/.local/share"}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:="$HOME/.cache"}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:="$HOME/.config"}


# disable less history
export LESSHISTFILE=-

# move ruby .cargo dir
export CARGO_HOME="$XDG_DATA_HOME/cargo"
# move .npm/npm -> ! npmrc need to be created and edited
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
# move .xinitrc -> ! need to be placed at startx >exec startx "$XDG_CONFIG_HOME/X11/xinitrc" 
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc
# move .vscode-oss -> ! is not documented and might break unexpectedly 
export VSCODE_PORTABLE="$XDG_DATA_HOME"/vscode
# move .pylint.d has a won`t fix -> but a note with this
export PYLINTHOME="$XDG_CACHE_HOME"/pylint
# move .Xauthoriy -> ! breaks lightDM
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority

# move .yarnrc to new loaction
alias yarn="yarn --use-yarnrc $XDG_CONFIG_HOME/yarn/config"

# move fasd cache file
export _FASD_DATA="$XDG_CACHE_HOME"/fasd-cache

