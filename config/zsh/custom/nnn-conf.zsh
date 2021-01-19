# nnn config file 
export NNN_COLORS='2641' 
# -a uto-setup temporary NNN_FIFO (described in ENVIRONMENT section)
# -e open text files in $VISUAL (else $EDITOR, fallback vi)
# -E use $EDITOR for internal undetached edits
# -o open files only on Enter key
export NNN_OPTS="Eeao"
export NNN_PLUG='u:getplugs;p:preview-tui;i:imgview;d:dragdrop;m:nmount;s:suedit'


[ -f ~/.config/zsh/nnn-bookmarks.zsh ] && source ~/.config/zsh//nnn-bookmarks.zsh


n ()
{
    # Block nesting of nnn in subshells
    if [ -n $NNNLVL ] && [ "${NNNLVL:-0}" -ge 1 ]; then
        echo "nnn is already running"
        return
    fi

    # The default behaviour is to cd on quit (nnn checks if NNN_TMPFILE is set)
    # To cd on quit only on ^G, remove the "export" as in:
    #     NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"
    # NOTE: NNN_TMPFILE is fixed, should not be modified
    export NNN_TMPFILE="${XDG_CONFIG_HOME:-$HOME/.config}/nnn/.lastd"

    nnn "$@"

    if [ -f "$NNN_TMPFILE" ]; then
            . "$NNN_TMPFILE"
            rm -f "$NNN_TMPFILE" > /dev/null
    fi
}

# bat theme config if installed and used for preview
is_bat=$(command -v bat)
if [ -n "$is_bat" ];then
    export BAT_THEME=Coldark-Dark
fi
unset is_bat
