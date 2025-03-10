# init fasder
if [ $(command -v fasder) ]; then
    # available alias with fasder
    # alias a='fasder'
    # alias d='fasder -d'
    # alias f='fasder -f'
    # alias v='fasder -fe $EDITOR'

    # available commands with fasder
    # vv foo          # Interactive file edition with fzf
    # j abc           # cd, same functionality as j in autojump (default j => change to z)
    # jj foo          # Interactive directory navigation with fzf (default j => change to z)

    fasder_cache="$HOME/.cache/fasder-init-zsh"
    if [ "$(command -v fasder)" -nt "$fasder_cache" -o ! -s "$fasder_cache" ]; then
        fasder --init auto aliases >| "$fasder_cache"
    fi
    source "$fasder_cache"
    unset fasder_cache
fi
