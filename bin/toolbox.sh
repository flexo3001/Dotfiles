#!/bin/bash

toolbox_version=fedora-toolbox-34

bold=$(tput bold)
reset=$(tput sgr0)

info() {
    echo "${bold}$1${reset}"
}

packages=(
    # basic
    'atool' 'p7zip' 'unzip' 'zsh' 'tmux' 'git' 'neovim' 'wl-clipboard' 'bind-utils' 'bmon' 'curl' 'fd-find'
    'file' 'htop' 'nmon' 'mosh' 'ranger' 'stow' 'wget' 'youtube-dl' 'net-tools' 'gocryptfs' 'sshfs' 'netcat'
    'dstat' 'atop' 'iotop' 'wireguard-tools' 'magic-wormhole' 'ncdu' 'sqlite' 'hyperfine'
    #'khal' 'vdirsyncer' 'khard' 'hledger' 'nnn'
    # ansible
    'ansible' 'openssh'
    # C and compiling
    '@C Development Tools and Libraries'
    # golang
    'golang' 'golang-x-tools-goimports' 'upx'
    # haskell
    'haskell-platform'
    # pandoc
    #'pandoc' 'perl-Image-ExifTool' 'ruby' 'ruby-devel' 'texlive'
    #'texlive-collection-fontsextra' 'texlive-collection-formatsextra' 'texlive-collection-langenglish'
    #'texlive-collection-langgerman' 'texlive-collection-latexextra' 'texlive-collection-science' 'wkhtmltopdf'
    # rust
    'cargo' 'rust '
    # header packages for compiling
    'pulseaudio-libs-devel' 'libxcb-devel' 'ncurses-devel' 'dbus-devel' 'libgit2-devel' 'libssh2-devel'
    'openssl-devel'
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

info 'Installing Ansible modules'
toolbox run ansible-galaxy collection install ansible.posix community.general
