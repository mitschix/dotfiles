# zplug plugin manager - https://github.com/zplug/zplug
# install zplug into /tmp and then link it to to zsh for the first time
# export ZPLUG_HOME=/tmp/.zplug
# curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh


export ZPLUG_HOME=/home/$USER/.config/zsh/plugs/
source /home/$USER/.config/zsh/plugs/init.zsh

# zplug "Aloxaf/fzf-tab"
zplug "wookayin/fzf-fasd"
zplug "zdharma/fast-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug "ael-code/zsh-colored-man-pages"
zplug "paulmelnikow/zsh-startup-timer"
zplug "MichaelAquilina/zsh-emojis"

zplug 'zplug/zplug', hook-build:'zplug --self-manage'


# zplug check returns true if all packages are installed
# Therefore, when it returns false, run zplug install
if ! zplug check; then
    zplug install
fi

#     # source plugins and add commands to the PATH
zplug load
