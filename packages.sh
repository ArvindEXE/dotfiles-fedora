#!/bin/bash

## Check if Script is Run as Root
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user to run this script, please run  ./install.sh" 2>&1
  exit 1
fi

# Add RPM Fusion repo
dnf install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
dnf groupupdate core 

## Updating System
dnf update -y

# Installing Dependencies 
dnf install -y unzip wget git curl flatpak blueberry bluez bluez-libs bluez-tools xdg-user-dirs xorg-x11-server-Xorg pavucontrol \
papirus-icon-theme file-roller gtk-murrine-engine gtk2-engines ImageMagick xclip lxappearance xfce4-settings \
parcellite neofetch maim gpick jq tint2 moreutils recode dunst plank redshift mate-polkit mpv yaru-sound-theme \
alsa-utils xorg-x11-xinit brightnessctl acpi playerctl python3-pytz glava wmctrl jgmenu rsms-inter-fonts \
NetworkManager network-manager-applet starship lsof gamemode zsh \
dbus-devel gcc git libconfig-devel libdrm-devel libev-devel libX11-devel libX11-xcb libXext-devel libxcb-devel mesa-libGL-devel \
meson pcre-devel pixman-devel uthash-devel xcb-util-image-devel xcb-util-renderutil-devel xorg-x11-proto-devel

# Installing Essential Programs 
dnf install -y lightdm bspwm sxhkd kitty rofi polybar thunar feh lxpolkit micro geany btop

# Adding flathub repo
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak override --filesystem=$HOME/.local/share/themes
flatpak override --env=GTK_THEME=my-theme

# Installing flatpak apps
flatpak install -y flathub com.discordapp.Discord
flatpak install -y flathub io.gitlab.librewolf-community
flatpak install -y flathub com.github.Eloston.UngoogledChromium

# Installing Custom ocs-url package
dnf install ~/dotfiles-fedora/rpm-packages/ocs-url-3.1.0-1.fc20.x86_64.rpm
dnf install ~/dotfiles-fedora/rpm-packages/ICAClient-rhel-22.7.0.20-0.x86_64.rpm

## Installing fonts
dnf install fontawesome-fonts fontawesome-fonts-web
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/FiraCode.zip
unzip FiraCode.zip -d /usr/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Meslo.zip
unzip Meslo.zip -d /usr/share/fonts
wget https://github.com/google/material-design-icons/archive/refs/tags/4.0.0.zip
unzip material-design-icons-4.0.0.zip -d /usr/share/fonts
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/JetBrainsMono.zip
unzip JetBrainsMono.zip -d /usr/share/fonts
wget https://github.com/feathericons/feather/archive/refs/tags/v4.29.0.zip
unzip v4.29.0.zip -d /usr/share/fonts

mv ~/dotfiles-fedora/.fonts/* /usr/share/fonts

## Installing Themes
git clone https://github.com/Fausto-Korpsvart/Tokyo-Night-GTK-Theme.git
cd Tokyo-Night-GTK-Theme/
mv themes/Tokyonight-Dark-BL /usr/share/themes/

# Reloading Font
fc-cache -vf

## Enabling Services and Graphical User Interface
systemctl enable lightdm
systemctl set-default graphical.target


