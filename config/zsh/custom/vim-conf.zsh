# Activate vim mode.
bindkey -v

# Remove mode switching delay.
KEYTIMEOUT=5

# Use beam shape cursor for vi insert mode (default)
make_beam() { echo -ne '\e[5 q' }
# Use block shape cursor for vi normal mode
make_block() { echo -ne '\e[1 q' }

# Change cursor shape for different vi modes.
function zle-line-init zle-keymap-select {
	case ${KEYMAP} in
		(vicmd)      make_block ;;
		(main|viins) make_beam ;;
	esac
}

zle -N zle-line-init
zle -N zle-keymap-select

# use vim keys in normal mode to fuzzy find history back/forward
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search

# Use vim keys in tab complete menu:
zstyle ':completion:*' menu select
zmodload zsh/complist

bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
# Fix backspace bug when switching modes
bindkey "^?" backward-delete-char
