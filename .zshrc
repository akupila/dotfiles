## Options section
setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
setopt nocaseglob                                               # Case insensitive globbing
setopt rcexpandparam                                            # Array expension with parameters
setopt numericglobsort                                          # Sort filenames numerically when it makes sense
setopt nobeep                                                   # No beep
setopt appendhistory                                            # Immediately append history instead of overwriting
setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
setopt share_history                                            # Import new comands and appends typed commands to history

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'       # Case insensitive tab completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
zstyle ':completion:*' rehash true                              # automatically find new executables in path 
# Speed up completions
zstyle ':completion:*' accept-exact '*(N)'
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

HISTFILE=~/.zhistory
HISTSIZE=1000000
SAVEHIST=1000000
WORDCHARS=${WORDCHARS//\/[&.;]}                                 # Don't consider certain characters part of the word

# Exports
export LANG=en_US.UTF-8
export EDITOR=vim
export VISUAL=vim
export GOPATH=~/go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:~/.local/bin
export GOPROXY=https://proxy.golang.org
export GOPRIVATE=github.com/akupila

## Keybindings section
bindkey -e
bindkey '^[[7~' beginning-of-line                               # Home key
bindkey '^[[H' beginning-of-line                                # Home key
if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line                # [Home] - Go to beginning of line
fi
bindkey '^[[8~' end-of-line                                     # End key
bindkey '^[[F' end-of-line                                      # End key
if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey "${terminfo[kend]}" end-of-line                       # [End] - Go to end of line
fi
bindkey '^[[2~' overwrite-mode                                  # Insert key
bindkey '^[[3~' delete-char                                     # Delete key
bindkey '^[[C'  forward-char                                    # Right key
bindkey '^[[D'  backward-char                                   # Left key
bindkey '^[[5~' history-beginning-search-backward               # Page up key
bindkey '^[[6~' history-beginning-search-forward                # Page down key

# Navigate words with ctrl+arrow keys
bindkey '^[Oc' forward-word                                     #
bindkey '^[Od' backward-word                                    #
bindkey '^[[1;5D' backward-word                                 #
bindkey '^[[1;5C' forward-word                                  #
bindkey '^H' backward-kill-word                                 # delete previous word with ctrl+backspace
bindkey '^[[Z' undo                                             # Shift+tab undo last action

## Alias section
alias cp='cp -i'                                                # Confirm before overwriting something
alias df='df -h'                                                # Human-readable sizes
alias free='free -m'                                            # Show sizes in MB
alias gs='git status'
alias gl='git --no-pager log --max-count 20 --graph'
alias gla='git --no-pager log --max-count 30 --all --graph'
alias gp='git log --stat --max-count=1 --format=medium'         # Show previous commit
alias gd='git diff --ignore-all-space'
alias gds='git diff --staged --ignore-all-space'
alias vi='vim'
alias goupdates='go list -u -m -json all | go-mod-outdated -update -direct'
## Aliases ignored from history
alias ..=' cd ..'
alias ...=' cd ...'
alias l=' ls -alh'
alias exit=" exit"

# Theming section
autoload -U compinit colors zcalc
compinit -d
colors

# enable substitution for prompt
setopt prompt_subst

PROMPT='%(?:%{$fg_bold[green]%}›:%{$fg_bold[red]%}›) %{$fg[cyan]%}%3d %{$(gitprompt -zsh)%}%{$reset_color%}'

# Color man pages
export LESS_TERMCAP_mb=$'\E[01;32m'
export LESS_TERMCAP_md=$'\E[01;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[01;47;34m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[01;36m'
export LESS=-r


## Plugins section: Enable fish style features
case `uname` in
  Darwin)
    source /usr/local/share/zsh-syntax-highlighting/highlighters
    source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh
  ;;
  Linux)
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    source /usr/share/zsh/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
  ;;
esac

zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Hooks

eval "$(direnv hook zsh)"
eval "$(jump shell zsh)"

# Misc

# AWS cli autocomplete
[ -f /usr/bin/aws_zsh_completer.sh ] && source /usr/bin/aws_zsh_completer.sh

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type f'

function gdoc() {
  if [ ! -f go.mod ]
  then
    echo "error: go.mod not found" >&2
    return
  fi

  module=$(sed -n 's/^module \(.*\)/\1/p' go.mod)
  mkdir -p /tmp/tmpgoroot/doc
  mkdir -p /tmp/tmpgopath/src/${module}
  tar -c --exclude='.git' --exclude='tmp' . | tar -x -C /tmp/tmpgopath/src/${module}
  xdg-open "http://localhost:6060/pkg/${module}" 2> /dev/null
  GOROOT=/tmp/tmpgoroot/ GOPATH=/tmp/tmpgopath/ godoc -http=localhost:6060
  rm -rf /tmp/tmpgopath/src/${module}
}

function gocover() {
  FILE=$(mktemp)
  go test -coverprofile=$FILE ./... && go tool cover -html=$FILE
  rm $FILE
}

[ ~/.zshrc-local ] && source ~/.zshrc-local
