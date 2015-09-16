#!/usr/bin/env zsh

set -e

function link_file {
    source="${PWD}/$1"
    target="${HOME}/${1/_/.}"

    if [ -e "${target}" ] && [ ! -L "${target}" ]; then
        mv $target $target.df.bak
    fi

    ln -sf ${source} ${target}
}

function unlink_file {
    source="${PWD}/$1"
    target="${HOME}/${1/_/.}"

    if [ -e "${target}.df.bak" ] && [ -L "${target}" ]; then
        unlink ${target}
        mv $target.df.bak $target
    fi
}

if [ "$1" = "restore" ]; then
    for i in _*
    do
        unlink_file $i
    done
    exit
else
    for i in _*
    do
        link_file $i
    done
fi

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install ctags-exuberant
brew install fasd
brew install vim
brew install ag
brew install jq
brew install cmake
brew linkapps

cd /usr/local
git clone https://go.googlesource.com/go go1.4
cp -r go1.4 go1.5
ln -s go1.4 go
cd go/src
git checkout release-branch.go1.4
./make.bash
cd /usr/local
rm go
ln -s go1.5 go
cd go/src
GOROOT_BOOTSTRAP=/usr/local/go1.4 ./make.bash

cd ~/Developer/dotfiles
git submodule update --init --recursive

cd ~/Developer/dotfiles
vim +PluginInstall +qall
cd _vim/bundle/YouCompleteMe
./install.py

chsh -s /bin/zsh
