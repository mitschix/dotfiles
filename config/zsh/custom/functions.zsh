# useful functions {{{
function countdown(){
    date1=$((`date +%s` + $1));
    while [ "$date1" -ge `date +%s` ]; do
        echo -ne "\r$(date -u --date @$(($date1 - `date +%s`)) +%H:%M:%S)";
        sleep 0.1
    done
    is_notify=$(command -v notify-send)
    if [ -n "$is_notify" ] ;then
        notify-send "countdown $1 ended"
    fi
}

function stopwatch() {
    start=$(date +%s)
    while true; do
        echo -ne "\r$(date -u --date @$((`date +%s` - $start)) +%H:%M:%S)";
        sleep 0.1
    done
}

# }}}

# from archlabs - better ls and cd from archlabs {{{
unalias ls >/dev/null 2>&1
ls()
{
  command ls --color=auto --classify --literal --human-readable "$@"
}

unalias cd >/dev/null 2>&1
cd()
{
  builtin cd "$@" && command ls --color=auto --classify --literal --human-readable
}
# }}}

# useful functions with fzf {{{
is_fzf=$(command -v fzf)
if [ -n "$is_fzf" ];then
    is_arch=$(command -v pacman)
    if [ -n "$is_arch" ];then
        function pacs() {
            packages=$(pacman -Ssq | fzf -m --preview="pacman -Si {}" --preview-window=:hidden --bind=space:toggle-preview)
            if [ -n "$packages" ];then
                sudo pacman -Syy --needed $packages
            fi
        }
        function blpacs() {
            packages=$(pacman -Sgg | grep blackarch | cut -d' ' -f2 | sort -u | fzf -m --preview="pacman -Si {}" --preview-window=:hidden --bind=space:toggle-preview)
            if [ -n "$packages" ];then
                sudo pacman -Syy --needed $packages
            fi
        }
    fi
    unset is_arch

function nf(){
    local filepatterrn=$1

    # need to save arrays instead of just string or it will be handled as one element for the editor
	if (( $# == 0 )); then
        filenames=( $(fzf -m --preview="head -n 20 {}" --preview-window=:hidden --bind=ctrl-space:toggle-preview) )
    else
        is_fd=$(command -v fd)
        if [ -n "$is_fd" ];then
            filenames=( $(fd --type f "$filepatterrn" | fzf -m --preview="head -n 20 {}" --preview-window=:hidden --bind=ctrl-space:toggle-preview) )
        else
            filenames=( $(find . -type f -name "$filepatterrn"| fzf -m --preview="head -n 20 {}" --preview-window=:hidden --bind=ctrl-space:toggle-preview) )
        fi
    fi

    if [ ${#filenames[@]} -gt 0 ]; then
        $EDITOR $filenames
    fi
}
fi
unset is_fzf
# }}}

# from OMZ plugin {{{
# Remove python compiled byte-code and mypy/pytest cache in either the current
# directory or in a list of specified directories (including sub directories).
function pyclean() {
    ZSH_PYCLEAN_PLACES=${*:-'.'}
    find ${ZSH_PYCLEAN_PLACES} -type f -name "*.py[co]" -delete
    find ${ZSH_PYCLEAN_PLACES} -type d -name "__pycache__" -delete
    find ${ZSH_PYCLEAN_PLACES} -depth -type d -name ".mypy_cache" -exec rm -r "{}" +
    find ${ZSH_PYCLEAN_PLACES} -depth -type d -name ".pytest_cache" -exec rm -r "{}" +
}

# take functions

# mkcd is equivalent to takedir
function mkcd takedir() {
  mkdir -p $@ && cd ${@:$#}
}

function takeurl() {
  local data thedir
  data="$(mktemp)"
  curl -L "$1" > "$data"
  tar xf "$data"
  thedir="$(tar tf "$data" | head -n 1)"
  rm "$data"
  cd "$thedir"
}

function takezip() {
  local data thedir
  data="$(mktemp)"
  curl -L "$1" > "$data"
  unzip "$data" -d "./"
  thedir="$(unzip -l "$data" | awk 'NR==4 {print $4}' | sed 's/\/.*//')"
  rm "$data"
  cd "$thedir"
}

function takegit() {
  git clone "$1"
  cd "$(basename ${1%%.git})"
}

function take() {
  if [[ $1 =~ ^(https?|ftp).*\.(tar\.(gz|bz2|xz)|tgz)$ ]]; then
    takeurl "$1"
  elif [[ $1 =~ ^(https?|ftp).*\.(zip)$ ]]; then
    takezip "$1"
  elif [[ $1 =~ ^([A-Za-z0-9]\+@|https?|git|ssh|ftps?|rsync).*\.git/?$ ]]; then
    takegit "$1"
  else
    takedir "$@"
  fi
}

# from omz/lib/clipboard -> only xsel used
function clipcopy() { xsel --clipboard --input < "${1:-/dev/stdin}"; }
function clippaste() { xsel --clipboard --output; }
# }}}

# https://github.com/shibumi/dotfiles/blob/master/.zshrc {{{
toggleSingleString() {
  LBUFFER=`echo $LBUFFER | sed "s/\(.*\) /\1 '/"`
  RBUFFER=`echo $RBUFFER | sed "s/\($\| \)/' /"`
  zle redisplay
}
zle -N toggleSingleString

toggleDoubleString() {
  LBUFFER=`echo $LBUFFER | sed 's/\(.*\) /\1 "/'`
  RBUFFER=`echo $RBUFFER | sed 's/\($\| \)/" /'`
  zle redisplay
}
zle -N toggleDoubleString

clearString() {
  LBUFFER=`echo $LBUFFER | sed 's/\(.*\)\('"'"'\|"\).*/\1\2/'`
  RBUFFER=`echo $RBUFFER | sed 's/.*\('"'"'\|"\)\(.*$\)/\1\2/'`
  zle redisplay
}
zle -N clearString

# run command line as user root via sudo:
function sudo-command-line () {
    [[ -z $BUFFER ]] && zle up-history
    if [[ $BUFFER != sudo\ * ]]; then
        BUFFER="sudo $BUFFER"
        CURSOR=$(( CURSOR+5 ))
    fi
}
zle -N sudo-command-line
# }}}
