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
sudo rm -rf $HOME/.config > /dev/null 2>&1

# Create symlinks
ln -sf $DOTFILES_DIR/.gitconfig $HOME/.gitconfig
ln -sf $DOTFILES_DIR/.zsh_plugins.txt $HOME/.zsh_plugins.txt
ln -sf $DOTFILES_DIR/.zshrc $HOME/.zshrc
ln -sf $DOTFILES_DIR/.config $HOME/.config

# Clone AstroNvim and symlink custom configuration
git clone https://github.com/AstroNvim/AstroNvim ~/.config/nvim
ln -sf $DOTFILES_DIR/nvim_user $HOME/.config/nvim/lua/user

# Restore dconf backup if on cinnamon
if [ $XDG_CURRENT_DESKTOP == $DEFAULT_DE ]; then
	dconf reset -f /
	dconf load / < $BACKUPS_DIR/backup.dconf
fi

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

echo "Run neovim to complete configuration, don't forget to install the language tools (servers, linters and formatters)"

