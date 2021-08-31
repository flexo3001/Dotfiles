HISTFILE=${HOME}/.zsh_history
HISTSIZE=500000
SAVEHIST=$HISTSIZE

export GOPATH="$HOME/.go"
export PATH="$HOME/.cargo/bin:$HOME/.gem/bin:$GOPATH/bin:$HOME/.dotfiles/bin:$HOME/.local/bin:$PATH"

[[ "`uname`" == 'Darwin' ]] && PATH="/opt/homebrew/bin:$PATH"

if [[ -x /usr/bin/nvim ]]; then
  export EDITOR=nvim
elif [[ -x /usr/bin/vim ]]; then
  export EDITOR=vim
fi

export LESS=-R
[[ -x /usr/bin/dircolors ]] && eval "$(dircolors)"
