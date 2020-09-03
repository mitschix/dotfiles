# Activate vim mode.
bindkey -v

# Remove mode switching delay.
KEYTIMEOUT=5

# configure vimodes and set for startup
IMODE="%K{22}%F{green} I %f%k"
NMODE="%K{88}%F{red} N %f%k"

# change vim mode in prompt
function change-vim-mode {
	case ${KEYMAP} in
		(vicmd)      VIMODE=${NMODE} ;;
		(main|viins) VIMODE=${IMODE} ;;
		(*)          VIMODE=${IMODE} ;;
	esac
}

# Use beam shape cursor for vi insert mode (default)
make_beam() {
	echo -ne '\e[5 q'
}

# Use block shape cursor for vi normal mode
make_block() {
  echo -ne '\e[1 q'
}

# Change cursor shape for different vi modes.
function zle-keymap-select zle-line-init {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
        make_block

  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
				make_beam 
  fi
	setprompt
	zle reset-prompt
}

bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search
