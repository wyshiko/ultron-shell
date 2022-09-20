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
read -p "Do you want install a Kali Linux LXD Image (Y/N): "  confirm
if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]
then
    cd ~
    ## Install LXD
    sudo snap install lxd
    lxd init

    ## Launch the container
    lxc launch images:kali/current/amd64 my-kali

    lxc exec my-kali -- passwd                         ## First things first
    lxc exec my-kali -- apt install kali-linux-light   ## Bare minimum

    read -p "Do you want install a Kali packages (Y/N): "  confirm
    if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]
    then
        ## Install some additional applications, use either light or default
        lxc exec my-kali -- apt install kali-linux-default ## Default set of packages
    fi
    read -p "Do you want create an non-root user (Y/N): "  confirm
    if [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]]
    then
        ## Setup non-root user
        lxc exec my-kali -- adduser kali
        lxc exec my-kali -- usermod -aG sudo kali
        lxc exec my-kali -- sed -i '1 i\TERM=xterm-256color' /home/kali/.bashrc
        lxc exec my-kali -- sh -c "echo 'Set disable_coredump false' > /etc/sudo.conf"
        echo lxc console my-kali > how_to_launch_kali.txt
    fi
fi
echo ''
echo 'INSTALLATION FINISH, THANK YOU'
echo ''
zsh