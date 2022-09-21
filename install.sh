#!/bin/bash
echo ''
echo "           __ __                     ";
echo "   __  __ / // /_ _____ ____   ____  ";
echo "  / / / // // __// ___// __ \ / __ \ ";
echo " / /_/ // // /_ / /   / /_/ // / / / ";
echo " \__,_//_/ \__//_/    \____//_/ /_/  ";
echo "              setup                  ";
echo "                                     ";
read -p "Do you want install ultron and customiz your shell (the ~/.zshrc file will me edit) (Y/N): "  confirm
if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]
then
    # Past .zshrc custom file to ~/ folder  
    echo "initialisation du .zshrc"
    cp zshrc ~/.zshrc
    sudo apt install zsh
fi
read -p "Do you want set .p10k.zsh file in your ~ folfer (Y/N): "  confirm
if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]
then
    # Past .p10k.zshcustom file to ~/ folder  
    echo "initialisation du .p10k.zsh"
    cp p10k.zsh ~/.p10k.zsh
fi
# Install antigen pluggin manager
cd ~
curl -L git.io/antigen > antigen.zsh
echo ''
echo 'INSTALLATION FINISH, THANK YOU'
echo ''
zsh