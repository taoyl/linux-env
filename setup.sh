#!/bin/bash

if [[ ! -n "$HOME" ]]; then
    echo "[[E]] Environment \$HOME is not set"
    exit 1
fi

# Global Settings
UTILS_DIR="$HOME/utils"
SHRC_DIR="$UTILS_DIR/shrc"
SCRIPTS_DIR="$UTILS_DIR/scripts"

echo "Updating repository ...."
# git pull

echo "Starting setup ...."
#-------------------------------------------------------------------------
# Bash settings
#-------------------------------------------------------------------------
echo "Creating essential dirs and links ...."
shell=$(ps -p $$ | awk 'NR==2 {print $NF}' | sed 's/^-//')
if [[ ! -e $UTILS_DIR ]]; then
    mkdir -p $UTILS_DIR
fi

if [[ ! -e "$SCRIPTS_DIR" ]]; then
    echo "Linking $SCRIPTS_DIR ...."
    ln -s $PWD/scripts $SCRIPTS_DIR
fi
if [[ ! -e "$SHRC_DIR" ]]; then
    echo "Linking $SHRC_DIR ...."
    ln -s $PWD/dotfiles/shrc $SHRC_DIR
fi

# bashrc
if [[ -e "$HOME/.bashrc" && "$(grep user_bashrc $HOME/.bashrc)" == "" ]]; then
    echo "Updating user bashrc ...."
    echo >> $HOME/.bashrc
    echo "# User settings" >> $HOME/.bashrc
    echo "source $SHRC_DIR/user_bashrc" >> $HOME/.bashrc
elif [[ -e "$HOME/.bash_profile" && "$(grep user_bashrc $HOME/.bash_profile)" == "" ]]; then
    echo "Updating user bash_profile ...."
    echo >> $HOME/.bash_profile
    echo "# User settings" >> $HOME/.bash_profile
    echo "source $SHRC_DIR/user_bashrc" >> $HOME/.bash_profile
else
    echo "[Warning]: No bashrc or bash_profile exists or already updated"
fi

# zshrc
if [[ -e "$HOME/.zshrc" && "$(grep user_bashrc $HOME/.zshrc)" == "" ]]; then
    echo "Updating user bashrc ...."
    echo >> $HOME/.zshrc
    echo "# User settings" >> $HOME/.zshrc
    echo "source $SHRC_DIR/user_bashrc" >> $HOME/.zshrc
else
    echo "[Warning]: No zshrc exists or already upated"
fi

# tcshrc
if [[ -e "$HOME/.cshrc" && "$(grep user_cshrc $HOME/.cshrc)" == "" ]]; then
    echo "Updating user cshrc ...."
    echo >> $HOME/.cshrc
    echo "# User settings" >> $HOME/.cshrc
    echo "source $SHRC_DIR/user_cshrc" >> $HOME/.cshrc
else
    echo "[Warning]: No cshrc exists or already updated"
fi

#-------------------------------------------------------------------------
# Tmux
#-------------------------------------------------------------------------
if [[ ! -e "$HOME/.tmux.conf" ]]; then
    echo "Creating .tmux.conf ...."
    ln -s $PWD/dotfiles/tmux.conf $HOME/.tmux.conf
fi


#-------------------------------------------------------------------------
# VIM settings
#-------------------------------------------------------------------------
# .vim
if [[ ! -e "$HOME/.vim" ]]; then
    echo "Creating .vim ...."
    cp -r $PWD/dotfiles/vim $HOME/.vim
    rm $HOME/.vim/vimrc_user_funcs
    rm $HOME/.vim/vimrc_vundle
fi
if [[ ! -e "$HOME/.vim/vimrc_user_funcs" ]]; then
    echo "Creating vimrc_user_funcs ...."
    ln -s $PWD/dotfiles/vim/vimrc_user_funcs $HOME/.vim/vimrc_user_funcs
fi
if [[ ! -e "$HOME/.vim/vimrc_vundle" ]]; then
    echo "Creating vimrc_vundle ...."
    ln -s $PWD/dotfiles/vim/vimrc_vundle $HOME/.vim/vimrc_vundle
fi
if [[ ! -d "$HOME/.vim/bundle" ]]; then
    mkdir -p $HOME/.vim/bundle
fi
if [[ ! -d "$HOME/.vim/autoload" ]]; then
    mkdir -p $HOME/.vim/autoload
fi

# vimrc
if [[ ! -e "$HOME/.vimrc" ]]; then
    echo "Creating .vimrc ...."
    ln -s $PWD/dotfiles/vimrc $HOME/.vimrc
fi

# clone pathogen
if [[ ! -f "$HOME/.vim/autoload/pathogen.vim" ]]; then
    echo "Downloading pathogen.vim..."
    curl -LSso $HOME/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
fi
if [[ ! -f "$HOME/.vim/autoload/pathogen.vim" ]]; then
    echo "[[E]] Failed to download pathogen.vim"
    exit 1
fi

# clone Vundle
if [[ ! -d "$HOME/.vim/bundle/Vundle.vim/autoload" ]]; then
    echo "Downloading Vundle.vim..."
    git clone https://github.com/VundleVim/Vundle.vim.git $HOME/.vim/bundle/Vundle.vim
fi
if [[ ! -d "$HOME/.vim/bundle/Vundle.vim/autoload" ]]; then
    echo "Failed to clone Vim Vundle"
    exit 1
fi

