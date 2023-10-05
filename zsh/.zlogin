[[ "$(uname)" == 'Darwin' ]] && export PATH="/opt/homebrew/bin:$PATH"

if builtin type -p dircolors &> /dev/null; then
  eval "$(dircolors)"
fi

if builtin type -p zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi
