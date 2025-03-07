# https://github.com/paulmelnikow/zsh-startup-timer
# never merged PR => just use the relevant part

seconds_to_milliseconds() {
    if [[ -z $1 ]]; then
        echo "Usage: seconds_to_milliseconds <seconds>"
        return 1
    fi
    local seconds=$1
    local milliseconds=$(echo "$seconds * 1000" | bc)
    printf "Startup time: %.3f ms\n" $milliseconds
}
typeset -F SECONDS
seconds_to_milliseconds $SECONDS
