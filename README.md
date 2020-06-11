# Dotfiles

For managing the configs GNU Stow is used. Every directory represents a
configuration path relative to $HOME.
To install a single configuration(e.g. zsh; stow needs to be installed) just do

```
$ cd Dotfiles
$ stow zsh
...
```

For further reading see `man stow`.
