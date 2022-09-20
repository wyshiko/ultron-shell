#!/bin/bash

read -p "intialisation du .zshrc? (Y/N): "  confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
echo "initialisation du .zshrc"
cp zshrc ~/.zshrc
echo "initialisation du .p10.zsh"
cp p10k.zsh ~/.p10k.zsh
cd ~
sudo apt install zsh
curl -L git.io/antigen > antigen.zsh
zsh