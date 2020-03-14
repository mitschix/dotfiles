if [ $(tty) = "/dev/tty1" ];then

    # set PATH so it includes user's private bin if it exists
    if [ -d "$HOME/.local/bin" ] ; then
        PATH="$HOME/.local/bin:$PATH"
    fi

    export PATH="/usr/sbin:/sbin:$PATH"

    # custom env vars
    export TERMINAL="termite"
    export EDITOR="nvim"
    export PAGER="less"
	
	exec startx
fi

