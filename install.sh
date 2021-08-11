#!/bin/bash

if [ "$(whoami)" != "root" ] 
then
    sudo chown -R $USER:$USER $PWD/*

    sudo pacman -S --needed $(comm -12 <(pacman -Slq | sort) <(sort $PWD/files/package_list.txt))

    mkdir -p $HOME/.config
    rm -f -r -- $HOME/.config/alacritty $HOME/.config/starship_modules $HOME/.config/nvim 
    rm -f -r -- $HOME/.config/neofetch $HOME/.zshrc $HOME/.plugins.txt
    rm -f -r -- $HOME/.gitconfig $HOME/.config/starship.toml
	rm -f -r -- $HOME/.pythonrc

    ln -s $PWD/files/.zshrc $HOME/.zshrc
    ln -s $PWD/files/.gitconfig $HOME/.gitconfig
    ln -s $PWD/files/.zsh_plugins.txt $HOME/.plugins.txt
    ln -s $PWD/files/starship.toml $HOME/.config/starship.toml
	ln -s $PWD/files/.pythonrc $HOME/.pythonrc
    ln -s -T $PWD/alacritty $HOME/.config/alacritty
    ln -s -T $PWD/neofetch $HOME/.config/neofetch
    ln -s -T $PWD/starship_modules $HOME/.config/starship_modules

    dconf load / < $PWD/files/dconf.bkp

    pacman -S broadcom-wl
    rmmod b43
    modprobe wl
else
    echo "Don't run this script with root privileges!"
fi
