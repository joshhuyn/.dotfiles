#!/bin/bash

mkdir $HOME/.config

config_copy()
{
	rm -rf $HOME/.config/$1
	ln -s $HOME/.dotfiles/$1 $HOME/.config/$1
}

config_copy "bspwm"
config_copy "sxhkd"
config_copy "nvim"
config_copy "kitty"
config_copy "alacritty"
config_copy "awesome"
config_copy "i3"
config_copy "i3status"
config_copy "picom"
config_copy "rofi"
config_copy "polybar"
