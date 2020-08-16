autoload -U +X colors && colors
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
autoload -Uz vcs_info

setopt completeinword
setopt extended_glob
setopt noflowcontrol
setopt prompt_subst
unsetopt nomatch

HISTFILE=${HOME}/.zsh_history
HISTSIZE=500000
SAVEHIST=$HISTSIZE
setopt share_history
setopt append_history
setopt extended_history
setopt histignorealldups
setopt histignorespace

bindkey -e
bindkey "^r" history-incremental-search-backward

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

if [[ "${terminfo[khome]}" != "" ]]; then
  bindkey "${terminfo[khome]}" beginning-of-line
fi

if [[ "${terminfo[kend]}" != "" ]]; then
  bindkey "${terminfo[kend]}" end-of-line
fi

if [[ "${terminfo[kcbt]}" != "" ]]; then
  bindkey "${terminfo[kcbt]}" reverse-menu-complete
fi

if [[ "${terminfo[kdch1]}" != "" ]]; then
  bindkey "${terminfo[kdch1]}" delete-char
else
  # fallbacks
  bindkey "^[[3~" delete-char
  bindkey "^[3;5~" delete-char
  bindkey "\e[3~" delete-char
fi

zstyle ':completion:*:commands' rehash 1
zstyle ':completion:*' completer _oldlist _expand _complete _files _ignored
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' menu select=5

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' formats "[%{$fg_bold[cyan]%}%b%{$reset_color%}]"
zstyle ':vcs_info:*' actionformats "[%{$fg_bold[cyan]%}%b%{$reset_color%}|%a]"

PROMPT="(%M) %~ %{$fg[red]%}%(#~#~$)%{$reset_color%} "
RPROMPT="\$vcs_info_msg_0_"

precmd () {
  print -Pn "\e]0;(%M) %~\a"
  vcs_info
}

preexec () {
  print -Pn "\e]0;(%M) $1\a"
}

alias :q="exit"
alias ..="cd .."
alias open="xdg-open"

wttr() {
  curl wttr.in/$1
}

sshn() {
  ssh -N -L ${1}:localhost:${2} $3
}

if [[ -x /usr/bin/dircolors ]]; then
  eval "$(dircolors)"
fi
