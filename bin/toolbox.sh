#!/bin/bash

toolbox_version=fedora-toolbox-34

bold=$(tput bold)
reset=$(tput sgr0)

info() {
    echo "${bold}$1${reset}"
}

packages=(
    ## basic
    'zsh' 'git' 'neovim' 'wl-clipboard' 'ranger' 'tmux' 'sqlite'
    ## ansible
    'ansible' 'openssh'
    ## C and compiling
    '@C Development Tools and Libraries'
    ## golang
    'golang' 'golang-x-tools-goimports' 'upx'
    ## haskell
    'haskell-platform'
    ## shell
    'ShellCheck'
    ## pandoc
    'pandoc' 'perl-Image-ExifTool' 'ruby' 'ruby-devel' 'texlive'
    'texlive-collection-fontsextra' 'texlive-collection-formatsextra' 'texlive-collection-langenglish'
    'texlive-collection-langgerman' 'texlive-collection-latexextra' 'texlive-collection-science' 'wkhtmltopdf'
    # rust
    'cargo' 'rust '
    ## header packages for compiling
    'pulseaudio-libs-devel' 'libxcb-devel' 'ncurses-devel' 'dbus-devel' 'libgit2-devel' 'libssh2-devel'
    'openssl-devel' 'ncurses-static' 'glibc-static' 'readline-static'
    ## python
    'python-requests' 'python-PyMySQL' 'python-psycopg2'
    ## huami-token
    'python3-pytest' 'python3-requests' 'python3-rich'
)

removals=(
    'subversion'
)

info 'Stopping toolbox ...'
podman stop ${toolbox_version}

info 'Delete old toolbox ...'
toolbox rm ${toolbox_version}

info 'Creating toolbox ...'
toolbox create

info 'Updating toolbox ...'
toolbox run sudo dnf upgrade -y

info 'Installing packages inside toolbox ...'
toolbox run sudo dnf install -y "${packages[@]}"

info 'Remove unused packages'
toolbox run sudo dnf remove -y "${removals[@]}"

info 'Remove unused dependencies and clean caches'
toolbox run sudo dnf autoremove -y
toolbox run sudo dnf clean all -y
