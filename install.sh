#!/bin/bash -e

# Link config files
function link_file {
    source="${PWD}/$1"
    target="${HOME}/${1/_/.}"

    if [ -e "${target}" ] && [ ! -L "${target}" ]; then
        mv $target $target.df.bak
    fi

    ln -sf ${source} ${target}
}

for i in _*
do
	link_file $i
done

# Install packages
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew install ctags-exuberant
brew install fasd
brew install ag
brew install jq
brew install cmake
brew install clang-format
brew install neovim/neovim/neovim
pip2 install --user --upgrade neovim

# Install Go
cd /usr/local
git clone https://go.googlesource.com/go go1.4
cp -r go1.4 gotip
ln -s go1.4 go
cd go/src
git checkout release-branch.go1.4
./make.bash
cd /usr/local
rm go
ln -s gotip go
cd go/src
GOROOT_BOOTSTRAP=/usr/local/go1.4 ./make.bash

# Setup nvim
cd ~/Developer/dotfiles
mkdir -p ~/.vim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
nvim +PluginInstall +qall
cd ~/.vim/bundle/YouCompleteMe
./install.py --clang-completer
ln -s /usr/local/bin/nvim /usr/local/bin/vim

# Use prezto
cd ~
git clone --recursive https://github.com/sorin-ionescu/prezto.git ".zprezto"
chsh -s /bin/zsh
