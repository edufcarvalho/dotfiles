#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
MAIN_DIR="$(dirname "$SCRIPT_DIR")"
DOTFILES_DIR="$MAIN_DIR/files/"
BACKUPS_DIR="$MAIN_DIR/backups/"

# Delete existing dot files and folders
sudo rm -rf $HOME/.gitconfig > /dev/null 2>&1
sudo rm -rf $HOME/.zsh_plugins.txt > /dev/null 2>&1
sudo rm -rf $HOME/.zshrc > /dev/null 2>&1
sudo rm -rf $HOME/.config > /dev/null 2>&1

# Create symlinks
ln -sf $DOTFILES_DIR/.gitconfig $HOME/.gitconfig
ln -sf $DOTFILES_DIR/.zsh_plugins.txt $HOME/.zsh_plugins.txt
ln -sf $DOTFILES_DIR/.zshrc $HOME/.zshrc
ln -sf $DOTFILES_DIR/.config $HOME/.config

# Restore dconf backup
dconf reset -f /
dconf load / < $BACKUPS_DIR/backup.dconf

# Install all packages
yay -S $(cat $BACKUPS_DIR/packages.txt)
