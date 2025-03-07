# Bootstrap if it does not exist
if [[ ! -d ${ZDOTDIR:-$HOME}/.antidote ]]; then
  git clone https://github.com/mattmc3/antidote ${ZDOTDIR:-$HOME}/.antidote
fi

# Use antidote plugin manager
source ${ZDOTDIR:-$HOME}/.antidote/antidote.zsh

# configure
zstyle ':antidote:bundle' use-friendly-names 'yes'
zstyle ':antidote:bundle' file ${ZDOTDIR:-~}/plugins/antidote-plugins.txt

antidote load
