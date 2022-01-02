# ZSH Theme emulating the Fish shell's default prompt.

_fishy_collapsed_wd() {
  local i pwd
  pwd=("${(s:/:)PWD/#$HOME/~}")
  if (( $#pwd > 2 )); then
    for i in {1..$(($#pwd-2))}; do
      if [[ "$pwd[$i]" = .* ]]; then
        pwd[$i]="${${pwd[$i]}[1,2]}"
      else
        pwd[$i]="${${pwd[$i]}[1]}"
      fi
    done
  fi
  echo "${(j:/:)pwd}"
}

setopt PROMPT_SUBST
# VIM mode
MODE_INDICATOR_PROMPT='%F{8}[%F{8}I]%f% '
MODE_INDICATOR_VIINS='%F{8}[%F{8}I]%f '
MODE_INDICATOR_VICMD='%F{10}[%F{2}N]%f '
MODE_INDICATOR_REPLACE='%F{9}[%F{1}R]%f '
MODE_INDICATOR_SEARCH='%F{13}[%F{5}S]%f '
MODE_INDICATOR_VISUAL='%F{12}[%F{4}V]%f '
MODE_INDICATOR_VLINE='%F{12}[%F{4}VL]%f '
NEWLINE=$'\n'
autoload -U colors && colors
local user_color='red'; [ $UID -eq 0 ] && user_color='red'

# for i in {1..256}; do print -P "%F{$i}Color : $i"; done;
local pwd_color=$FG[238]
local bg_color=$BG[216]
# PROMPT='${MODE_INDICATOR_PROMPT}%B%{$fg[$user_color]%}%n%{$reset_color%}%B@%B%m':'%{$fg[$pwd_color]%}$(_fishy_collapsed_wd)%{$reset_color%}%(!.#.)${NEWLINE}➤ '
# PROMPT='${MODE_INDICATOR_PROMPT}%B%{$fg[$user_color]%}%n%{$reset_color%}%B@%B%m':'%{$fg[$pwd_color]%}$(_fishy_collapsed_wd)%{$reset_color%}%(!.#.) $(git_prompt_info|tr -d " ")$(git_prompt_status)$(kube_ps1)${NEWLINE}➤ %{$reset_color%}'
 # PROMPT='%{$reset_color%}${MODE_INDICATOR_PROMPT}$bg_color%{$fg[$user_color]%}%B%n%{$reset_color%}$bg_color%B@%B%m%b$bg_color:$bg_color$pwd_color$(_fishy_collapsed_wd)%{$reset_color%}%(!.#.) $(git_prompt_info|tr -d " ")%b$(kube_ps1)${NEWLINE}➤ %{$reset_color%}'
  PROMPT='%{$reset_color%}${MODE_INDICATOR_PROMPT}$bg_color%{$fg[$user_color]%}%n@:$bg_color$pwd_color$(_fishy_collapsed_wd)%{$reset_color%}%(!.#.) $(git_prompt_info|tr -d " ")%b$(kube_ps1)${NEWLINE}➤ %{$reset_color%}'
# PROMPT2='%{$fg[red]%}\ %{$reset_color%}'

local return_status="%{$fg_bold[red]%}%(?..%?) %{$reset_color%}"
# RPROMPT="${RPROMPT}"'(${return_status}$(git_prompt_info)$(git_prompt_status)%{$reset_color%})'
# RPROMPT="${RPROMPT}"'${return_status}'
# RPROMPT="${RPROMPT}"
RPROMPT='%{$reset_color%}'
# RPROMPT='%{$fg[$color]%}($ZSH_KUBECTL_PROMPT)%{$reset_color%}'
ZSH_THEME_GIT_PROMPT_PREFIX=" "
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY=""
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_GIT_PROMPT_ADDED="%{$fg_bold[green]%}+"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg_bold[blue]%}!"
ZSH_THEME_GIT_PROMPT_DELETED="%{$fg_bold[red]%}-"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg_bold[magenta]%}>"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg_bold[yellow]%}#"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg_bold[cyan]%}?"
