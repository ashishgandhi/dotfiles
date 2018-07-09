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
brew install go python cmake ctags-exuberant fasd ripgrep jq clang-format neovim
/usr/local/opt/python/libexec/bin/pip install --user --upgrade neovim

# Setup nvim
cd ~/Developer/dotfiles
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
nvim +PlugInstall +qall
cd ~/.vim/plugged/YouCompleteMe
./install.py --clang-completer
ln -s /usr/local/bin/nvim /usr/local/bin/vim

# Use prezto
cd ~
git clone --recursive https://github.com/sorin-ionescu/prezto.git ".zprezto"
chsh -s /bin/zsh
