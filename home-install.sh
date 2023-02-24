#!/usr/bin/env bash
mkdir -p "$HOME/bin"
cp -r bin/* "$HOME/bin"
mkdir -p "$HOME/scripts"
cp -r scripts/* "$HOME/scripts"
mkdir -p "$HOME/Pictures"
cp -r Pictures/* "$HOME/Pictures"

cp ./mynvim.desktop "$HOME/.local/share/applications/mynvim.desktop"
mkdir -p ~/.config/herbstluftwm
mkdir -p ~/.config/nvim
mkdir -p ~/.config/fish
mkdir -p ~/.config/rofi
mkdir -p ~/.config/termite
mkdir -p ~/.config/alacritty
mkdir -p ~/.conky
cp -r .conky/ ~/.conky
cp -r config/herbstluftwm/* "$HOME/.config/herbstluftwm/"
# cp -r config/nvim/* "$HOME/.config/nvim/"
cp -r config/fish/* "$HOME/.config/fish/"
cp -r config/rofi/* "$HOME/.config/rofi/"
cp -r config/termite/* "$HOME/.config/termite/"
cp -r config/alacritty/* "$HOME/.config/alacritty/"

herbstclient reload
