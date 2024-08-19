#!/bin/zsh -e

function link_file {
    src="${PWD}/$1"
    dst="${HOME}/${1/_/.}"

    if [ -e "${dst}" ] && [ ! -L "${dst}" ]; then
        echo "Backing up $dst as it already exists"
        mv "$dst" "$dst.bak"
    fi

    ln -sfh "${src}" "${dst}"
}

for i in _*
do
    link_file "$i"
done