#!/usr/bin/env bash

echo "Symlinking dotfiles to home directory"
for file in `ls files`
do
  if [ -e ~/.$file -o -L ~/.$file ]; then
    echo "Replacing link to ~/$file"
    rm -rf ~/.$file
  fi

  ln -s $PWD/files/$file ~/.$file
done


echo "Cloning submodules"
# 1. oh-my-zsh
# 2. vim bundles
