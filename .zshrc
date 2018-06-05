# Alias {{{

alias ..='cd ..'
alias ...='cd ...'
alias l='ls -alh'

# Enable pbcopy on arch
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

# Git
alias gs="git status"
alias gd="git diff"
alias gds="git diff --staged"

# }}}
# Export {{{

export EDITOR="vim"
export GOPATH=~/go
export GOBIN=$GOPATH/bin
export PATH=$PATH:$GOPATH/bin

# }}}
# History {{{

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

# Allow multiple terminal sessions to all append to one zsh command history
setopt append_history
# Save timestamp and duration
setopt extended_history
# Adds commands as they are typed, don't wait until shell exit
setopt inc_append_history
# When trimming history, remove oldest duplicates first
setopt hist_expire_dups_first
# Do not write events to history that are duplicates of previous events
setopt hist_ignore_dups
# Remove line from history when first character is a space
setopt hist_ignore_space
# When searching history, don't display already cycled results twice
setopt hist_reduce_blanks
# Don't execute, just expand history
setopt hist_verify
# Import new comands and appends typed commands to history
setopt share_history

# }}}
# Completion {{{

autoload -Uz compinit && compinit

# When completing fomr the middle of a word, move the cursor to the end of the
# # word
setopt always_to_end
# Show completion menu on successive tab press (requires unsetop menu_complete)
set auto_menu
# Any parameter that is set to the absolute name of a directory immediately
# becomes a name for that directory
setopt auto_name_dirs
# Allow completion from withing a word/phrase
setopt complete_in_word

# Do not autoselect the first completion entry
unsetopt menu_complete

# Enable autocompletion menu
zstyle ':completion:*:*:*:*:*' menu select
# Automatically update PATH entries
zstyle ':completion:*' rehash true
# Keep dirs and files separated
zstyle ':completion:*' list-dirs-first true

# }}}
# Prompt {{{

autoload -U colors && colors

# Enable command substitution in prompt (and parameter expansion, arithmetic expansion)
setopt promptsubst

local ret_status="%(?:%{$fg_bold[green]%}|:%{$fg_bold[red]%}|)"
local dir="%{$fg[cyan]%}%3d%{$reset_color%}"

PROMPT='${ret_status} ${dir} $(gitprompt)'

# }}}
# Key bindings {{{

# Use emacs-like key bindings by default
bindkey -e

bindkey '^r' history-incremental-search-backward

# }}}
# Hooks {{{

eval "$(direnv hook zsh)"
eval "$(jump shell)"

# }}}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# vim: set foldmethod=marker :
