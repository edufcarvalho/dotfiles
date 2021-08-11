#!/bin/bash

cd /home/eduardo/.dotfiles
pacman -Qqe > files/package_list.txt
dconf dump / > files/dconf.bkp
git add .
git commit -m "[AUTO] Daily package list and dconf backup update"
git push
