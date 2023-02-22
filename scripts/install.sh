#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
MAIN_DIR="$(dirname "$SCRIPT_DIR")"
DOTFILES_DIR="$MAIN_DIR/files/"
BACKUPS_DIR="$MAIN_DIR/backups/"
DEFAULT_DE="X-Cinnamon"

# Delete existing dot files and folders
sudo rm -rf $HOME/.gitconfig > /dev/null 2>&1
sudo rm -rf $HOME/.zsh_plugins.txt > /dev/null 2>&1
sudo rm -rf $HOME/.zshrc > /dev/null 2>&1
sudo rm -rf $HOME/.config/alacritty > /dev/null 2>&1
sudo rm -rf $HOME/.config/htop > /dev/null 2>&1
sudo rm -rf $HOME/.config/starship.toml > /dev/null 2>&1
# Create symlinks
ln -sf $DOTFILES_DIR/.gitconfig $HOME/.gitconfig
ln -sf $DOTFILES_DIR/.zsh_plugins.txt $HOME/.zsh_plugins.txt
ln -sf $DOTFILES_DIR/.zshrc $HOME/.zshrc
ln -sf $DOTFILES_DIR/.config/alacritty $HOME/.config/alacritty
ln -sf $DOTFILES_DIR/.config/htop $HOME/.config/htop
ln -sf $DOTFILES_DIR/.config/starship.toml $HOME/.config/starship.toml

# Install all packages if on arch
if [ -f "/etc/arch-release" ]; then
	PACKAGE_LIST=$(comm -1 -3 --nocheck-order <(yay -Qe | awk '{print $1}') /home/eduardo/.dotfiles/backups/packages.txt)
	yay -S $PACKAGE_LIST
fi

# Change default shell to zsh if installed
if [ -f "/bin/zsh" ]; then
	chsh -s $(which zsh)
else
	echo "Install zsh and run the script again"
fi
