#! /usr/bin/env sh

cd ~
ln -s ~/GitHub/dotfiles/gvimrc .gvimrc
ln -s ~/GitHub/dotfiles/vimrc .vimrc
cp --interactive ~/GitHub/dotfiles/gvimrc.local .gvimrc.local
cp --interactive ~/GitHub/dotfiles/vimrc.local .vimrc.local 

ln -s ~/GitHub/dotfiles/zshrc .zshrc
ln -s ~/GitHub/dotfiles/zprofile .zprofile
