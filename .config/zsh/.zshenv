export LANG=en_US.UTF-8

export EDITOR='nvim'
export VISUAL='nvim'
export DIFFPROG='nvim -d'
export MANPAGER='nvim +Man!'
export CLICOLOR=1

# /opt/homebrew/bin/brew shellenv
export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_CELLAR="/opt/homebrew/Cellar";
export HOMEBREW_REPOSITORY="/opt/homebrew";
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin${PATH+:$PATH}";
export MANPATH="/opt/homebrew/share/man${MANPATH+:$MANPATH}:";
export INFOPATH="/opt/homebrew/share/info:${INFOPATH:-}";

export GOPATH=$HOME/go
export GOPRIVATE=github.com/akupila
export AWS_VAULT_PROMPT=ykman

# 10ms timeout on ESC
export KEYTIMEOUT=1

# List colors
# https://geoff.greer.fm/lscolors/
export LSCOLORS=ExhxhxDxbxhxhxhxhxcxcx

# PATH
export PATH=$PATH:$GOPATH/bin

