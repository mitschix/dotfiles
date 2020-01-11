# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

export PATH="/usr/sbin:/sbin:$PATH"

# custom env vars
export TERMINAL="st"
export EDITOR="vim"
export PAGER="less"

# nnn settings
if command -v nnn > /dev/null ; then
export NNN_CONTEXT_COLORS='2641' 
export NNN_COPIER="/home/$USER/.local/bin/nnn/misc/clipboard-copier/copier"

# source more custom nnn configs, like note and bookmarks
source ~/.nnn_env_extra
fi

