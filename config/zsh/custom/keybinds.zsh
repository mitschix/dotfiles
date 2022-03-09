# custom keybindings -> add/fix to omz keys

bindkey '^F' forward-word                        # [Ctrl-F] - move forward one word
bindkey '^D' backward-word                       # [Ctrl-D] - move backward one word
bindkey '^K' forward-char                       # [Ctrl-K] - move forward one char -- accept autosuggestion

# fix for wrong terminfo
# vim insert mode
bindkey -M viins '^[[A' up-line-or-beginning-search
bindkey -M viins '^[[B' down-line-or-beginning-search
bindkey -M viins '^[[H' beginning-of-line
bindkey -M viins '^[[F' end-of-line

# vim normal mode
bindkey -M vicmd '^[[A' up-line-or-beginning-search
bindkey -M vicmd '^[[B' down-line-or-beginning-search
bindkey -M vicmd '^[[H' beginning-of-line
bindkey -M vicmd '^[[F' end-of-line

# custom functions with zle
bindkey "^xs" sudo-command-line
bindkey "^x'" toggleSingleString
bindkey '^x"' toggleDoubleString
bindkey '^x;' clearString

