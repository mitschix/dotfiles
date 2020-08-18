export ZPLUG_HOME=/home/$USER/.config/zsh/plugs/
source /home/$USER/.config/zsh/plugs/init.zsh

# zplug "Aloxaf/fzf-tab"
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
