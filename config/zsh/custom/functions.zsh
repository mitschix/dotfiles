# from archlabs
# better ls and cd from archlabs
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

# useful functions
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

# extract function from omz
# usage: ex [-r] <file>
# -r removes archive after extraction
function ex() {
	local remove_archive
	local success
	local extract_dir

	if (( $# == 0 )); then
		cat <<-'EOF' >&2
			Usage: extract [-option] [file ...]

			Options:
			    -r, --remove    Remove archive after unpacking.
		EOF
	fi

	remove_archive=1
	if [[ "$1" == "-r" ]] || [[ "$1" == "--remove" ]]; then
		remove_archive=0
		shift
	fi

	while (( $# > 0 )); do
		if [[ ! -f "$1" ]]; then
			echo "extract: '$1' is not a valid file" >&2
			shift
			continue
		fi

		success=0
		extract_dir="${1:t:r}"
		case "${1:l}" in
			(*.tar.gz|*.tgz) (( $+commands[pigz] )) && { pigz -dc "$1" | tar xv } || tar zxvf "$1" ;;
			(*.tar.bz2|*.tbz|*.tbz2) tar xvjf "$1" ;;
			(*.tar.xz|*.txz)
				tar --xz --help &> /dev/null \
				&& tar --xz -xvf "$1" \
				|| xzcat "$1" | tar xvf - ;;
			(*.tar.zma|*.tlz)
				tar --lzma --help &> /dev/null \
				&& tar --lzma -xvf "$1" \
				|| lzcat "$1" | tar xvf - ;;
			(*.tar.zst|*.tzst)
				tar --zstd --help &> /dev/null \
				&& tar --zstd -xvf "$1" \
				|| zstdcat "$1" | tar xvf - ;;
			(*.tar) tar xvf "$1" ;;
			(*.tar.lz) (( $+commands[lzip] )) && tar xvf "$1" ;;
			(*.tar.lz4) lz4 -c -d "$1" | tar xvf - ;;
			(*.tar.lrz) (( $+commands[lrzuntar] )) && lrzuntar "$1" ;;
			(*.gz) (( $+commands[pigz] )) && pigz -dk "$1" || gunzip -k "$1" ;;
			(*.bz2) bunzip2 "$1" ;;
			(*.xz) unxz "$1" ;;
			(*.lrz) (( $+commands[lrunzip] )) && lrunzip "$1" ;;
			(*.lz4) lz4 -d "$1" ;;
			(*.lzma) unlzma "$1" ;;
			(*.z) uncompress "$1" ;;
			(*.zip|*.war|*.jar|*.sublime-package|*.ipa|*.ipsw|*.xpi|*.apk|*.aar|*.whl) unzip "$1" -d $extract_dir ;;
			(*.rar) unrar x -ad "$1" ;;
			(*.rpm) mkdir "$extract_dir" && cd "$extract_dir" && rpm2cpio "../$1" | cpio --quiet -id && cd .. ;;
			(*.7z) 7za x "$1" ;;
			(*.deb)
				mkdir -p "$extract_dir/control"
				mkdir -p "$extract_dir/data"
				cd "$extract_dir"; ar vx "../${1}" > /dev/null
				cd control; tar xzvf ../control.tar.gz
				cd ../data; extract ../data.tar.*
				cd ..; rm *.tar.* debian-binary
				cd ..
			;;
			(*.zst) unzstd "$1" ;;
			(*)
				echo "extract: '$1' cannot be extracted" >&2
				success=1
			;;
		esac

		(( success = $success > 0 ? $success : $? ))
		(( $success == 0 )) && (( $remove_archive == 0 )) && rm "$1"
		shift
	done
}

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

# from OMZ plugin
# Remove python compiled byte-code and mypy/pytest cache in either the current
# directory or in a list of specified directories (including sub directories).
function pyclean() {
    ZSH_PYCLEAN_PLACES=${*:-'.'}
    find ${ZSH_PYCLEAN_PLACES} -type f -name "*.py[co]" -delete
    find ${ZSH_PYCLEAN_PLACES} -type d -name "__pycache__" -delete
    find ${ZSH_PYCLEAN_PLACES} -depth -type d -name ".mypy_cache" -exec rm -r "{}" +
    find ${ZSH_PYCLEAN_PLACES} -depth -type d -name ".pytest_cache" -exec rm -r "{}" +
}

# from OMZ
function take() {
  mkdir -p $@ && cd ${@:$#}
}

# https://github.com/shibumi/dotfiles/blob/master/.zshrc
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
