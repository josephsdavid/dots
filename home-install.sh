#!/usr/bin/env bash
mkdir -p "$HOME/bin"
cp -r bin/* "$HOME/bin"
mkdir -p "$HOME/scripts"
cp -r scripts/* "$HOME/scripts"
mkdir -p "$HOME/Pictures"
cp -r Pictures/* "$HOME/Pictures"

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
cp ./mynvim.desktop "$HOME/.local/share/applications/mynvim.desktop"
mkdir ~/.config/herbstluftwm
mkdir ~/.config/nvim
mkdir ~/.config/fish
mkdir ~/.config/rofi
mkdir ~/.config/termite
mkdir ~/.config/alacritty
mkdir ~/.conky
cp -r .conky/ ~/.conky
cp -r config/herbstluftwm/* "$HOME/.config/herbstluftwm/"
cp -r config/nvim/* "$HOME/.config/nvim/"
cp -r config/fish/* "$HOME/.config/fish/"
cp -r config/rofi/* "$HOME/.config/rofi/"
cp -r config/termite/* "$HOME/.config/termite/"
cp -r config/alacritty/* "$HOME/.config/alacritty/"

herbstclient reload
