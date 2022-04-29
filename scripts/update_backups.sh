#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
MAIN_DIR="$(dirname "$SCRIPT_DIR")"
BACKUPS_DIR="$MAIN_DIR/backups/"

# Get dconf values
dconf dump / > $BACKUPS_DIR/backup.dconf

# Save packages list
yay -Qe | awk '{print $1}' > $BACKUPS_DIR/packages.txt

# Commit changes
cd $MAIN_DIR
if [[ `git status --porcelain` ]]; then
	git add .
	git commit -m "[Auto] Update backups"	
	git push
fi
