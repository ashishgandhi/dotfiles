#!/bin/bash -e

# Use prezto
function link_file {
    src="${PWD}/$1"
    dst="${HOME}/${1/_/.}"

    if [ -e "${dst}" ] && [ ! -L "${dst}" ]; then
        mv $dst $dst.bak
    fi

    ln -sfh ${src} ${dst}
}

for i in _*
do
    link_file $i
done

git clone --recursive https://github.com/sorin-ionescu/prezto.git ~/.zprezto
chsh -s /bin/zsh
