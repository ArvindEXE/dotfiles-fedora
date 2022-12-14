#!/bin/bash

## Moving dotfiles to home
# Config
mkdir ~/.config
mv ~/dotfiles-fedora/.config/* ~/.config
# Scripts
mkdir ~/.scripts
mv ~/dotfiles-fedora/.scripts/* ~/.scripts
# Local
mkdir ~/.local
mv ~/dotfiles-fedora/.local/* ~/.local
# Fonts
mkdir ~/.fonts
mv ~/dotfiles-fedora/.fonts/* ~/.fonts

mv ~/dotfiles-fedora/.Xtyonight ~/
mv ~/dotfiles-fedora/.Xresources ~/

# Reloading Font
fc-cache -vf

# Removing zip Files
rm FiraCode.zip Meslo.zip 4.0.0.zip JetBrainsMono.zip v4.29.0.zip

xdg-user-dirs-update
