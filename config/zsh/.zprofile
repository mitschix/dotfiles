# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# add completion from dotfiles repo
fpath=(~/.config/zsh/compl $fpath)

export PATH="/usr/sbin:/sbin:$PATH"
export QT_QPA_PLATFORMTHEME=qt5ct

# custom env vars
export TERMINAL="termite"
export EDITOR="nvim"
export PAGER="less -R"

# install qt5ct and setup dark color
# export QT_QPA_PLATFORMTHEME=qt5ct

# source clipmenu config before starting x
source ~/.config/zsh/custom/clipmenu-conf.zsh
source ~/.config/zsh/custom/xdgbase-conf.zsh
source ~/.config/zsh/custom/nnn-conf.zsh

# start gui if on tty1
if [ $(tty) = "/dev/tty1" ];then
    exec startx "$XDG_CONFIG_HOME/X11/xinitrc"
fi
