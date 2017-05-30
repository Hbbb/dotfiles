#!/bin/sh

# TODO:
# 1. Barebones .vimrc with no plugins, just keymaps and visual stuff
# 2. no zsh.. bash will do
# 3. global gitconfig.. maybe?

echo "Symlinking vim config to home directory"
for file in `ls files`
do
  if [ -e ~/.$file -o -L ~/.$file ]; then
    echo "Replacing link to ~/.$file"
    rm -rf ~/.$file
  fi

  ln -s $PWD/files/$file ~/.$file
done

echo "Cloning submodules"
git submodule update --init --recursive
