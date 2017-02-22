#!/bin/sh

echo "Cloning submodules"
git submodule update --init --recursive

echo "Symlinking dotfiles to home directory"
for file in `ls files`
do
  if [ -e ~/.$file -o -L ~/.$file ]; then
    echo "Replacing link to ~/.$file"
    rm -rf ~/.$file
  fi

  ln -s $PWD/files/$file ~/.$file
done

