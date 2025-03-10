# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
if [ -d "$XDG_DATA_HOME/npm/bin" ] ; then
    PATH="$XDG_DATA_HOME/npm/bin:$PATH"
fi
if [ -d "$XDG_DATA_HOME/cargo/bin" ] ; then
    PATH="$XDG_DATA_HOME/cargo/bin:$PATH"
fi

# add completion from dotfiles repo
fpath=(~/.config/zsh/compl $fpath)

export PATH="/usr/sbin:/sbin:$PATH"
export QT_QPA_PLATFORMTHEME=qt5ct

# custom env vars
export TERMINAL="alacritty"
export EDITOR="nvim"
export PAGER="less -r"

# load local zprofile file if it exists
[ -f "${XDG_CONFIG_HOME:-$HOME/.config}"/zsh/.zprofile.local ] && \
    source "${XDG_CONFIG_HOME:-$HOME/.config}"/zsh/.zprofile.local

# start gui if on tty1
if [ $(tty) = "/dev/tty1" ];then
    exec startx "$XDG_CONFIG_HOME/X11/xinitrc" &> ~/startx.log
fi
