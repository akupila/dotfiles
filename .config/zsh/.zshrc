export LANG=en_US.UTF-8
export EDITOR='nvim'
export VISUAL='nvim'
export DIFFPROG='nvim -d'
export MANPAGER='nvim +Man!'
export CLICOLOR=1

eval $(brew shellenv)

export GOPATH=$HOME/go
export GOPRIVATE=github.com/akupila
export AWS_VAULT_PROMPT=ykman
export PATH=$PATH:$GOPATH/bin

# 10ms timeout on ESC
export KEYTIMEOUT=1

# List colors
# https://geoff.greer.fm/lscolors/
export LSCOLORS=ExhxhxDxbxhxhxhxhxcxcx

if [ ! -d ${ZDOTDIR:-~}/.antidote ]; then
  git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote
fi
source ${ZDOTDIR:-~}/.antidote/antidote.zsh

antidote load

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh


# History
HISTFILE="${ZDOTDIR:-$HOME}/.zsh_history"
HISTSIZE=1000000
SAVEHIST=1000000

setopt BANG_HIST            # Treat the '!' character specially during expansion.
setopt GLOB_DOTS            # Show hidden files in completion.
setopt HIST_FIND_NO_DUPS    # Do not display a previously found event.
setopt HIST_IGNORE_ALL_DUPS # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_DUPS     # Do not record an event that was just recorded again.
setopt HIST_IGNORE_SPACE    # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS    # Do not write a duplicate event to the history file.
setopt HIST_VERIFY          # Do not execute immediately upon history expansion.
setopt IGNORE_EOF           # Do not exit on ctrl-d.
setopt INC_APPEND_HISTORY   # Write to the history file immediately.
setopt SHARE_HISTORY        # Share history between all sessions.

# Completion
zmodload zsh/complist 
autoload -U compinit; compinit
# Allow selecting with menu.
zstyle ':completion:*' menu select
zstyle ':completion:*' use-cache on
# Case-insensitive path-completion.
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=* r:|=*'
# Completion menu has colors.
zstyle ':completion:*' list-colors ${(s.:.)LSCOLORS}

# Vi keys
bindkey -e
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey "^?" backward-delete-char                 # Fix backspace after normal mode

# Edit line in $EDITOR
autoload -z edit-command-line
zle -N edit-command-line
bindkey "^X^X" edit-command-line

# Aliases
alias ..='cd ..'
alias gd='git diff'
alias gds='git diff --staged'
alias gl='git log'
alias gp='git log --stat --max-count=1 --format=medium'
alias grep='grep --color=auto'
alias gs='git status'
alias l='ls -alh'

# Use FZF for search
[ -f ${ZDOTDIR:-~}/.fzf.zsh ] && source ${ZDOTDIR:-~}/.fzf.zsh

# Hooks
eval "$(direnv hook zsh)"
eval "$(jump shell zsh)"
