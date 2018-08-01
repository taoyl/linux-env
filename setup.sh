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
if [ ! -d "$HOME/.vim/bundle" ]; then
    mkdir -p $HOME/.vim/bundle
fi
if [ ! -d "$HOME/.vim/autoload" ]; then
    mkdir -p $HOME/.vim/autoload
fi

# clone pathogen
if [ ! -f "$HOME/.vim/autoload/pathogen.vim" ]; then
    echo "Downloading pathogen.vim..."
    curl -LSso $HOME/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
fi
if [ ! -f "$HOME/.vim/autoload/pathogen.vim" ]; then
    echo "[E] Failed to download pathogen.vim"
    exit 1
fi

# clone Vundle
if [ ! -d "$HOME/.vim/bundle/Vundle.vim/autoload" ]; then
    echo "Downloading Vundle.vim..."
    git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
fi
if [ ! -d "$HOME/.vim/bundle/Vundle.vim/autoload" ]; then
    echo "Failed to clone Vim Vundle"
    exit 1
fi



