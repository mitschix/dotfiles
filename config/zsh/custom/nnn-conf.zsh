# nnn config file
export NNN_COLORS='2641'
export NNN_TERMINAL='alacritty'
# -a uto-setup temporary NNN_FIFO (described in ENVIRONMENT section)
# -e open text files in $VISUAL (else $EDITOR, fallback vi)
# -E use $EDITOR for internal undetached edits
# -o open files only on Enter key
export NNN_OPTS="Eeao"
export NNN_PLUG='u:getplugs;p:preview-tui;i:imgview;d:dragdrop;m:nmount;s:suedit'

[ -f "$ZDOTDIR"/nnn-bookmarks.zsh ] && source "$ZDOTDIR"/nnn-bookmarks.zsh

n ()
{
    # Block nesting of nnn in subshells
    [ "${NNNLVL:-0}" -eq 0 ] || {
        echo "nnn is already running"
        return
    }

    # The behaviour is set to cd on quit (nnn checks if NNN_TMPFILE is set)
    # If NNN_TMPFILE is set to a custom path, it must be exported for nnn to
    # see. To cd on quit only on ^G, remove the "export" and make sure not to
    # use a custom path, i.e. set NNN_TMPFILE *exactly* as follows:
    #      NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    # Unmask ^Q (, ^V etc.) (if required, see `stty -a`) to Quit nnn
    # stty start undef
    # stty stop undef
    # stty lwrap undef
    # stty lnext undef

    # The command builtin allows one to alias nnn to n, if desired, without
    # making an infinitely recursive alias
    command nnn "$@"

    [ ! -f "$NNN_TMPFILE" ] || {
        . "$NNN_TMPFILE"
        rm -f -- "$NNN_TMPFILE" > /dev/null
    }
}

# bat theme config if installed and used for preview
is_bat=$(command -v bat)
if [ -n "$is_bat" ];then
    export BAT_THEME=Coldark-Dark
fi
unset is_bat
