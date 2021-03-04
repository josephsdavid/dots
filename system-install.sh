#!/usr/bin/env bash

# Assumptions: You have installed nix, with git, nvim, and a working internet connection, and are running this script as root
# You should look over the configurations and make sure they are right for your computer!

echo "Installing system-wide configuration"
cp nixos/configuration.nix /etc/nixos/configuration.nix
nixos-rebuild switch
