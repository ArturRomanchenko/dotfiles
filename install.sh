#!/bin/bash

GREEN='\033[0;32m'   
RESET='\033[0m'      

echo -e "${GREEN}
#
#  ██╗      █████╗ ██╗   ██╗███╗   ██╗ ██████╗██╗  ██╗███████╗██████╗ 
#  ██║     ██╔══██╗██║   ██║████╗  ██║██╔════╝██║  ██║██╔════╝██╔══██╗
#  ██║     ███████║██║   ██║██╔██╗ ██║██║     ███████║█████╗  ██████╔╝
#  ██║     ██╔══██║██║   ██║██║╚██╗██║██║     ██╔══██║██╔══╝  ██╔══██╗
#  ███████╗██║  ██║╚██████╔╝██║ ╚████║╚██████╗██║  ██║███████╗██║  ██║
#  ╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝ ╚═╝  ╚═╝ ╚═════╝╚══════╝╚═╝  ╚═╝
#
#      - https://github.com/ArturRomanchenko/dotfiles
#
${RESET}"

# Update the system and install necessary packages
sudo pacman -Syu --noconfirm

# List of essential packages
pkg=(
    xorg-server xorg-xinit xorg-xsetroot lightdm lightdm-gtk-greeter bspwm sxhkd polybar rofi ranger
    qt5ct picom alacritty papirus-icon-theme ttf-jetbrains-mono vim ttf-jetbrains-mono-nerd
    thunar pulseaudio cmus pavucontrol firefox htop fastfetch feh flameshot lxappearance nano
    flatpak openssh dunst xclip imagemagick gpick nano iwd
)

dev=(
    cmake make clang gcc git code obs-studio gnome-boxes obsidian nvidia-open
)

packages=("${pkg[@]}" "${dev[@]}")

echo -e "${GREEN}
###############################################
#                                             #
#                All packages:                #
#                                             #
###############################################${RESET}"

echo -e "${GREEN}${packages[@]}${RESET}"

# Install the essential packages
sudo pacman -S "${packages[@]}"

# Installing base development tools and yay
sudo pacman -S --needed --noconfirm base-devel git
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..
rm -rf yay

# Installing a package from AUR
yay -S --noconfirm cava google-chrome

# Setting up environment variable for qt5ct
echo 'QT_QPA_PLATFORMTHEME=qt5ct' | sudo tee -a /etc/environment > /dev/null



###############################################
#                                             #
#      	Transferring all configurations       #
#                                             #
###############################################



# Creating standart directories
mkdir -p ~/Downloads ~/Images ~/Music ~/Videos ~/Documents
cp -r ./Images/* ~/Images/

# Creating configuration directories
mkdir -p ~/.config/bspwm ~/.config/sxhkd ~/.config/flameshot ~/.config/gtk-3.0 ~/.config/picom ~/.config/polybar ~/.config/ranger ~/.config/rofi ~/.config/cmus ~/.config/alacritty

# Copying configuration files
cp -r ./config/bspwm/* ~/.config/bspwm/
cp -r ./config/sxhkd/* ~/.config/sxhkd/
cp -r ./config/flameshot/* ~/.config/flameshot/
cp -r ./config/gtk-3.0/* ~/.config/gtk-3.0/
cp -r ./config/picom/* ~/.config/picom/
cp -r ./config/polybar/* ~/.config/polybar/
cp -r ./config/ranger/* ~/.config/ranger/
cp -r ./config/rofi/* ~/.config/rofi/
cp -r ./config/cmus/* ~/.config/cmus/
cp -r ./config/alacritty/* ~/.config/alacritty/

# Copying additional scripts and files
cp -r bin/ ~/
cp ./fehbg ~/.fehbg
cp ./xinitrc ~/.xinitrc
cp ./gtkrc-2.0 ~/.gtkrc-2.0

# Updating font cache
fc-cache -fv

# Installing themes
mkdir -p ~/.themes
cp -r ./themes/* ~/.themes/

# Making scripts executable
chmod +x ~/.config/bspwm/bspwmrc
chmod +x ~/.config/sxhkd/sxhkdrc
chmod +x ~/bin/*

echo "Installation completed. Please restart your session or window manager. (startx)"