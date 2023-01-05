#!/bin/bash

#PATHS
export GOPATH=/home/mictian/.goLibs
export PATH=~/.local/bin:$GOPATH/bin:$PATH
#System:fix icons,network-manager,themes,etc
export XDG_DATA_DIRS=/usr/share/mictian:/usr/local/share:/usr/share

ulimit -n 2048

#ALIAS
alias rm=trash
alias hibernate='systemctl hibernate'
alias poweroff='systemctl poweroff'
alias reboot='systemctl reboot'
alias gno='gnome-open'
alias xno='xdg-open'
alias wheather='curl wttr.in/delft'
alias ll='ls -l'
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'
# alias nvim='nvim.appimage'

#Fix NeoVim character
#https://github.com/neovim/neovim/issues/5990
export VTE_VERSION="100"