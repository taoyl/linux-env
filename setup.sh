#!/bin/bash

if [ ! -n "$HOME" ]; then
    echo "[E] Environment \$HOME is not set"
    exit 1
fi

# copy config file
cp -r .vim $HOME
cp .vimrc  $HOME
cp .tmux.conf $HOME

##### VIM Settings ######
if [ ! -d "~/.vim/bundle" ]; then
    mkdir -p ~/.vim/bundle
fi
if [ ! -d "~/.vim/autoload" ]; then
    mkdir -p ~/.vim/autoload
fi

# clone pathogen
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
if [ ! -f "~/vim/autoload/pathogen.vim" ]; then
    echo "[E] Failed to download pathogen.vim"
    exit 1
fi

# clone Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
if [ ! -d "~/vim/bundle/Vundle.vim/autoload" ]; then
    echo "Failed to clone Vim Vundle"
    exit 1
fi



