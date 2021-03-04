#!/usr/bin/env bash

nix-channel --add https://nixos.org/channels/nixos-20.09 nixos
nix-channel --add https://github.com/nix-community/home-manager/archive/release-20.09.tar.gz home-manager
nix-channel --update

nix-shell '<home-manager>' -A install
cp config/nixpkgs/home.nix "$HOME/.config/nixpkgs/home.nix"
home-manager switch

mkdir -p "$HOME/bin"
cp -r bin/* "$HOME/bin"
mkdir -p "$HOME/scripts"
cp -r scripts/* "$HOME/scripts"

sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
cp ./mynvim.desktop "$HOME/.local/share/applications/mynvim.desktop"
cp -r config/herbstluftwm/* "$HOME/.config/herbstluftwm/"
cp -r config/nvim/* "$HOME/.config/nvim/"
cp -r config/fish/* "$HOME/.config/fish/"
cp -r config/rofi/* "$HOME/.config/rofi/"
cp -r config/termite/* "$HOME/.config/termite/"

herbstclient reload
