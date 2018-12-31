#!/bin/bash

echo "Updating repository ...."
git pull

if [ ! -n "$HOME" ]; then
    echo "[E] Environment \$HOME is not set"
    exit 1
fi

echo "Starting setup ...."
#-------------------------------------------------------------------------
# Bash settings
#-------------------------------------------------------------------------
if [ ! -e "$HOME/bin/scripts" ]; then
    echo "Creating bin/scipts ...."
    if [ ! -e "$HOME/bin" ]; then
        mkdir -p $HOME/bin
    fi
    ln -s $PWD/scripts $HOME/bin/scripts
fi

if [ ! -e "$HOME/.user_bashrc" ]; then
    echo "Creating .user_bashrc ...."
    ln -s $PWD/dotfiles/user_bashrc $HOME/.user_bashrc
fi
if [ ! -e "$HOME/.user_alias" ]; then
    echo "Creating .user_alias ...."
    ln -s $PWD/dotfiles/user_alias $HOME/.user_alias
fi

if [ -e "$HOME/.bashrc" ]; then
    echo "source ~/.user_bashrc" >> $HOME/.bashrc
elif [ -e "$HOME/.bash_profile" ]; then
    echo "\n\nsource ~/.user_bashrc" >> $HOME/.bash_profile
else
    echo "No bashrc or bash_profile exists"
fi


#-------------------------------------------------------------------------
# Tmux
#-------------------------------------------------------------------------
if [ ! -e "$HOME/.tmux.conf" ]; then
    echo "Creating .tmux.conf ...."
    ln -s $PWD/dotfiles/tmux.conf $HOME/.tmux.conf
fi


#-------------------------------------------------------------------------
# VIM settings
#-------------------------------------------------------------------------
# .vim
if [ ! -e "$HOME/.vim" ]; then
    echo "Creating .vim ...."
    cp -r $PWD/dotfiles/vim $HOME/.vim
    rm $HOME/.vim/vimrc_user_funcs
    rm $HOME/.vim/vimrc_vundle
fi
if [ ! -e "$HOME/.vim/vimrc_user_funcs" ]; then
    echo "Creating vimrc_user_funcs ...."
    ln -s $PWD/dotfiles/vim/vimrc_user_funcs $HOME/.vim/vimrc_user_funcs
fi
if [ ! -e "$HOME/.vim/vimrc_vundle" ]; then
    echo "Creating vimrc_vundle ...."
    ln -s $PWD/dotfiles/vim/vimrc_vundle $HOME/.vim/vimrc_vundle
fi
if [ ! -d "$HOME/.vim/bundle" ]; then
    mkdir -p $HOME/.vim/bundle
fi
if [ ! -d "$HOME/.vim/autoload" ]; then
    mkdir -p $HOME/.vim/autoload
fi

# vimrc
if [ ! -e "$HOME/.vimrc" ]; then
    echo "Creating .vimrc ...."
    ln -s $PWD/dotfiles/vimrc $HOME/.vimrc
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

