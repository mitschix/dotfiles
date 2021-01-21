ZSH_THEME_GIT_PROMPT_PREFIX=" %F{green} -<[ %F{white}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%f %F{green}]>-%f"

ZSH_THEME_GIT_PROMPT_DIRTY="%F{red}*%f"
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_GIT_COMMITS_BEHIND_PREFIX=" %F{red}↓"
ZSH_THEME_GIT_COMMITS_BEHIND_SUFFIX="%f"

ZSH_THEME_GIT_COMMITS_AHEAD_PREFIX=" %F{green}↑"
ZSH_THEME_GIT_COMMITS_AHEAD_SUFFIX="%f"

# this is required for initial prompt and a problem I had with Ctrl+C or
# Enter when in normal mode (a new line would come up in insert mode,
# but normal mode would be indicated)
precmd () {
    # Use beam shape cursor for each new prompt.
    make_beam
}

# set prompt and configs
setprompt () {
    setopt prompt_subst
    autoload colors
    change-vim-mode
    NEWLINE=$'\n'
    VENV="\$(virtualenv_info)"
    # show status of last command
    EXIT_STATUS="%(0?.%F{green}✔.%F{red}✘)%f "

    # hostnamectl sometimes breaks! use with caution!
    # VM="\$(vm_info)"
    VM=""

    RPS1="${EXIT_STATUS}"
    PROMPT="${VM}${VENV}%F{wwhite}[%*]%f ${VIMODE}$(git_prompt_info) %F{yellow}`whoami`@%m%f %F{cyan}[%~]%f${NEWLINE}> "
}

# function to check and display python virtualenvs
function virtualenv_info(){
    # Get Virtual Env
    if [[ -n "$VIRTUAL_ENV" ]]; then
        # Strip out the path and just leave the env name
        venv="${VIRTUAL_ENV##*/}"
    else
        # In case you don't have one activated
        venv=''
    fi
    [[ -n "$venv" ]] && echo "($venv) "
}

# function to check if VM
# need to have hostnamectl installed
# @todo hostnamectl breaks sometimes = slows down prompt
function vm_info(){
    if hostnamectl status | grep -q vm; then
        vm="%F{red}VM%f"
    elif hostnamectl status | grep -q arm; then
        vm="%F{red}PI%f"
    else
        vm=""
    fi
    [[ -n "$vm" ]] && echo "$vm "
}


# from OMZ git 
# -- beginn
#
# Outputs current branch info in prompt format
function git_prompt_info() {
    local ref
    if [[ "$(command git config --get oh-my-zsh.hide-status 2>/dev/null)" != "1" ]]; then
        ref=$(command git symbolic-ref HEAD 2> /dev/null) || \
        ref=$(command git rev-parse --short HEAD 2> /dev/null) || return 0
        echo "$ZSH_THEME_GIT_PROMPT_PREFIX${ref#refs/heads/}$(parse_git_dirty)$(git_commits_behind)$(git_commits_ahead)$ZSH_THEME_GIT_PROMPT_SUFFIX"
    fi
}

# Checks if working tree is dirty
function parse_git_dirty() {
    local STATUS
    local -a FLAGS
    FLAGS=('--porcelain' '--ignore-submodules=dirty')
    if [[ "$(command git config --get oh-my-zsh.hide-dirty)" != "1" ]]; then
        if [[ "$DISABLE_UNTRACKED_FILES_DIRTY" == "true" ]]; then
            FLAGS+='--untracked-files=no'
        fi
        STATUS=$(command git status ${FLAGS} 2> /dev/null | tail -n1)
    fi
    if [[ -n $STATUS ]]; then
        echo "$ZSH_THEME_GIT_PROMPT_DIRTY"
    else
        echo "$ZSH_THEME_GIT_PROMPT_CLEAN"
    fi
}

# Gets the number of commits ahead from remote
function git_commits_ahead() {
    if command git rev-parse --git-dir &>/dev/null; then
        local commits="$(git rev-list --count @{upstream}..HEAD 2>/dev/null)"
        if [[ -n "$commits" && "$commits" != 0 ]]; then
            echo "$ZSH_THEME_GIT_COMMITS_AHEAD_PREFIX$commits$ZSH_THEME_GIT_COMMITS_AHEAD_SUFFIX"
        fi
    fi
}

# Gets the number of commits behind remote
function git_commits_behind() {
    if command git rev-parse --git-dir &>/dev/null; then
        local commits="$(git rev-list --count HEAD..@{upstream} 2>/dev/null)"
        if [[ -n "$commits" && "$commits" != 0 ]]; then
            echo "$ZSH_THEME_GIT_COMMITS_BEHIND_PREFIX$commits$ZSH_THEME_GIT_COMMITS_BEHIND_SUFFIX"
        fi
    fi
}
# -- end

# drawing prompt and add plugin
zle -N zle-line-init
zle -N zle-keymap-select

setprompt
