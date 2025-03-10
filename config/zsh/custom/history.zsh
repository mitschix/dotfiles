## History file configuration
HISTFILE="$ZDOTDIR/zhist"
[ "$HISTSIZE" -lt 50000 ] && HISTSIZE=50000
[ "$SAVEHIST" -lt 10000 ] && SAVEHIST=10000

## History command configuration
setopt extended_history       # record timestamp of command in HISTFILE
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
setopt share_history          # share command history data

# fix to show full history per default
alias history="history 0"
# Lists the ten most used commands. (from belak/zsh-utils)
alias history-stat="history 0 | awk '{print \$2}' | sort | uniq -c | sort -n -r | head"

# alias from omz plugin
alias h='history'
alias hl='history | less'
alias hs='history | grep'
alias hsi='history | grep -i'
