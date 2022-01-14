autoload -U +X colors && colors
autoload -U +X compinit && compinit
autoload -U +X bashcompinit && bashcompinit
autoload -Uz vcs_info

HISTFILE=${HOME}/.zsh_history
HISTSIZE=100000
SAVEHIST=$HISTSIZE

setopt completeinword
setopt extended_glob
setopt noflowcontrol
setopt prompt_subst
unsetopt nomatch

setopt share_history
setopt append_history
setopt extended_history
setopt histignorealldups
setopt histignorespace

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
zstyle ':vcs_info:*' formats "[%{$fg_bold[cyan]%}%b%{$reset_color%}]"
zstyle ':vcs_info:*' actionformats "[%{$fg_bold[cyan]%}%b%{$reset_color%}|%a]"

# cut shown $PWD if depth is 4 or more ('~' counts)
truncated_pwd="%(4~|.../%2~|%~)"
# cut shown $PWD after 20 characters
#truncated_pwd="%20<...<%~%<<"

shell_indicator=""
[[ -f /run/.containerenv && -f /run/.toolboxenv ]] && shell_indicator="%F{13}⬢%f "

PROMPT="${shell_indicator}(%M) ${truncated_pwd} %{$fg[red]%}%(#~#~$)%{$reset_color%} "
RPROMPT="\$vcs_info_msg_0_"

precmd () {
  print -Pn "\e]0;(%M) %~\a"
  vcs_info
}

preexec () {
  print -Pn "\e]0;(%M) $1\a"
}

sshl() {
  ssh -N -L ${1}:localhost:${2} $3
}

alias :q="exit"
alias ..="cd .."
[[ -x /usr/bin/xdg-open ]] && alias open="xdg-open"
