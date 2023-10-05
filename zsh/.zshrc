autoload -U bashcompinit && bashcompinit
autoload -U compinit && compinit
autoload -U vcs_info

HISTFILE=${HOME}/.zsh_history
HISTSIZE=100000
SAVEHIST=$HISTSIZE

setopt "APPEND_HISTORY"
setopt "EXTENDED_HISTORY"
setopt "HIST_FCNTL_LOCK"
setopt "HIST_IGNORE_ALL_DUPS"
setopt "HIST_IGNORE_SPACE"
setopt "SHARE_HISTORY"

setopt "AUTO_PUSHD"
setopt "COMPLETE_IN_WORD"
setopt "EXTENDED_GLOB"
setopt "NO_FLOW_CONTROL"
setopt "NO_NOMATCH"
setopt "PROMPT_SUBST"

alias :q="exit"
alias ..="cd .."
alias grep="grep --color=auto"

bindkey -e

if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx
  }

  function zle-line-finish() {
    echoti rmkx
  }

  zle -N zle-line-init
  zle -N zle-line-finish
fi

[[ -n "${terminfo[khome]}" ]] && bindkey "${terminfo[khome]}" beginning-of-line
[[ -n "${terminfo[kend]}" ]] && bindkey "${terminfo[kend]}" end-of-line
[[ -n "${terminfo[kcbt]}" ]] && bindkey "${terminfo[kcbt]}" reverse-menu-complete
[[ -n "${terminfo[kdch1]}" ]] && bindkey "${terminfo[kdch1]}" delete-char

zstyle ':completion:*:commands' rehash 1
zstyle ':completion:*' completer _oldlist _expand _complete _files _ignored
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' menu select=2

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' formats "[%B%F{cyan}%b%f%%b]"
zstyle ':vcs_info:*' actionformats "[%B%F{cyan}%b%f%%b|%a]"

local shell_indicator=""
[[ -f /run/.containerenv && -f /run/.toolboxenv ]] && shell_indicator="%F{13}⬢%f "

local user_color="red"
let $UID && user_color="12"

local user="%B%F{${user_color}}%n%f%b"
local at="@"
local host="%B%m%b "
local dollar="%F{red}%(#~#~$)%f "
local percent="%# "
local rc="%B%F{red}%(?..%? )%f%b"
local dir="%(4~|.../%2~|%~) "

PROMPT="${shell_indicator}${user}${at}${host}${dir}${dollar}"
RPROMPT="\$vcs_info_msg_0_"

precmd() {
  print -Pn "\e]0;%n@%m: %~\a"
  vcs_info
}

preexec() {
  print -Pn "\e]0;%n@%m: $1\a"
}

sudorun() {
  if builtin type -p sudo &> /dev/null; then
    sudo $(which "${1}") "${@:2}"
  fi
  return 1
}
