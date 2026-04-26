#!/bin/bash

if [ ! -d $HOME/.config ]; then
  mkdir $HOME/.config
fi

for x in configs/*; do
  APP_CONFIG=$(echo "$x" | sed "s/^configs\///")

  TARGET_DIR=$HOME/.config/$APP_CONFIG

  if [ -d $TARGET_DIR ]; then
    mv $TARGET_DIR $TARGET_DIR.bak
  fi

  ln -s $PWD/$x $TARGET_DIR
done

