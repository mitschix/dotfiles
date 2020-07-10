if [ $(tty) = "/dev/tty1" ];then

    # set PATH so it includes user's private bin if it exists
    if [ -d "$HOME/.local/bin" ] ; then
        PATH="$HOME/.local/bin:$PATH"
    fi

    export PATH="/usr/sbin:/sbin:$PATH"
    export export QT_QPA_PLATFORMTHEME=qt5ct

    # custom env vars
    export TERMINAL="termite"
    export EDITOR="nvim"
    export PAGER="less"

    export CM_LAUNCHER=rofi

    # nnn config
    export NNN_COLORS='2641' 

    # install qt5ct and setup dark color
    export QT_QPA_PLATFORMTHEME=qt5ct
	
	exec startx
fi
