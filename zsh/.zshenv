export GOPATH="$HOME/Development/go"
export PATH="$HOME/.cargo/bin:$HOME/.gem/bin:$HOME/.go/bin:$GOPATH/bin:$HOME/.local/bin:/usr/local/go/bin:$PATH"

if [[ -x /usr/bin/nvim ]]; then
  EDITOR="nvim"
else
  EDITOR="vim"
fi

export EDITOR=$EDITOR
export VISUAL=$EDITOR

export QT_QPA_PLATFORM=xcb
