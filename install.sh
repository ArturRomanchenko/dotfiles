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

# List of essential packages

sudo pacman -S --needed --noconfirm xorg-server xorg-xinit xorg-xsetroot lightdm lightdm-gtk-greeter bspwm sxhkd polybar rofi ranger qt5ct picom alacritty papirus-icon-theme ttf-jetbrains-mono vim ttf-jetbrains-mono-nerd thunar pulseaudio cmus pavucontrol firefox htop fastfetch nitrogen flameshot lxappearance nano flatpak openssh dunst xclip imagemagick gpick nano iwd wget curl cmake make clang gcc git code obs-studio gnome-boxes obsidian nvidia-open nvidia nvidia-utils nvidia-settings

# Update the system and install necessary packages
sudo pacman -Syu

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
mkdir -p ~/.config/bspwm ~/.config/sxhkd ~/.config/flameshot ~/.config/gtk-3.0 ~/.config/picom ~/.config/polybar ~/.config/ranger ~/.config/rofi ~/.config/cmus ~/.config/alacritty ~/.config/nitrogen

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
cp -r ./config/nitrogen/* ~/.config/nitrogen/

# Copying additional scripts and files
cp -r bin/ ~/
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

# Installing zsh for Bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
yay -S --noconfirm zsh-theme-powerlevel10k-git
echo 'source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' >>~/.zshrc

echo "Installation completed. Please restart your session or window manager. (startx)"