#!/bin/sh

# TODO: Only copy over vim config/plugins..
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
