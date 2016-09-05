function get_jobs() {
  # jobs | sed 's/\[\(.\)\]  . .*  \(.*\)/%%\1: \2/g' | xargs # with job nr
  jobs | sed 's/\[\(.\)\]  . .*  \(.*\)/\2/g' | xargs
}

local ret_status="%(?:%{$fg_bold[green]%}›:%{$fg_bold[red]%}›)"
PROMPT='${ret_status} %{$fg[cyan]%}%3d%{$reset_color%} $(git_super_status)'
RPROMPT='$FG[238]% $(get_jobs)%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_bold[blue]%}) %{$reset_color%}"
ZSH_THEME_GIT_PROMPT_SEPARATOR=""
ZSH_THEME_GIT_PROMPT_BRANCH="%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_STAGED="%{$fg[magenta]%} ›"
ZSH_THEME_GIT_PROMPT_CONFLICTS="%{$fg[red]%} !"
ZSH_THEME_GIT_PROMPT_CHANGED="%{$fg[green]%} +"
ZSH_THEME_GIT_PROMPT_BEHIND="%{$fg[magenta]%} ↓"
ZSH_THEME_GIT_PROMPT_AHEAD="%{$fg[magenta]%} ↑"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[yellow]%} ϟ"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}(%{$fg[red]%}"
# ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
# ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}×"
# ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"
