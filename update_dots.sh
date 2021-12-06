#!/usr/bin/env bash

cfig=$HOME/.config
mkdir -p scripts
mkdir -p bin
cp -r $HOME/scripts/* scripts/
cp -r ~/.conky .conky
cp -r $HOME/bin/* bin/
cp -r ~/.bash-git-prompt .bash-git-prompt
cp ~/.bashrc .bashrc
cp ~/.bash_profile .bash_profile
cp ~/.bashrc .bashrc
cp -r ~/.screenlayout  .screenlayout

cp /etc/nixos/configuration.nix nixos/configuration.nix
cp -r $cfig/fish/* config/fish
cp -r $cfig/nixpkgs/* config/nixpkgs
cp -r $cfig/herbstluftwm/* config/herbstluftwm
cp -r $cfig/nvim/* config/nvim
cp -r $cfig/rofi/* config/rofi
cp -r $cfig/termite/* config/termite
cp -r $cfig/mimeapps.list config/mimeapps.list
cp "$HOME/.local/share/applications/mynvim.desktop" mynvim.desktop

cp -r "$HOME/Pictures/icons/" Pictures/icons/
