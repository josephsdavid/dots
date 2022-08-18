#!/usr/bin/env bash
cd ~/
mkdir -p ~/.local/bin
wget "https://discordapp.com/api/download/canary?platform=linux&format=tar.gz" -O discord.tar.gz
tar -xvf discord.tar.gz -C ~/.local/bin
sudo ln -s ~/.local/bin/DiscordCanary/discord.png /usr/share/icons/discord.png
sudo ln -s ~/.local/bin/DiscordCanary/DiscordCanary /usr/bin
wget https://gist.githubusercontent.com/AdrianKoshka/a12ca0bfe2f334a9f208aff72f8738c3/raw/9d606ad7ce7cc1dd23f6a99993e2396540538a02/discord.desktop -O discord.desktop
mkdir -p ~/.local/share/applications/
mv ~/discord.desktop ~/.local/share/applications/
sudo ln -s ~/.local/share/applications/discord.desktop /usr/share/applications/discord.desktop
