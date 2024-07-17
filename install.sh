#!/bin/bash

###############################################
#                                             #
#                All packages                 #
#                                             #
###############################################


# Installing necessary packages
sudo pacman -S --needed --noconfirm \
    xorg-server xorg-xinit lightdm lightdm-gtk-greeter bspwm sxhkd polybar rofi ranger git lxappearance \
    qt5ct picom alacritty obs-studio papirus-icon-theme ttf-jetbrains-mono \
    thunar alsa-utils cmus pavucontrol firefox htop fastfetch feh flameshot

# Installing base development tools and yay
sudo pacman -S --needed --noconfirm base-devel git
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..
rm -rf yay

# Installing a package from AUR
yay -S --noconfirm cava

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
mkdir -p ~/.config/bspwm ~/.config/sxhkd ~/.config/flameshot ~/.config/gtk-3.0 ~/.config/picom ~/.config/polybar ~/.config/ranger ~/.config/rofi ~/.config/cmus

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

# Copying additional scripts and files
mkdir -p bin
cp -r ./bin/* ~/bin/
cp ./fehbg ~/.fehbg
cp ./xinitrc ~/.xinitrc
cp ./gtkrc-2.0 ~/.gtkrc-2.0

# Installing fonts
mkdir -p ~/.local/share/fonts
cp -r ./fonts/* ~/.local/share/fonts/

# Updating font cache
fc-cache -fv

# Installing themes
mkdir -p ~/.themes
cp -r ./themes/* ~/.themes/

# Making scripts executable
chmod +x ~/.config/bspwm/bspwmrc
chmod +x ~/.config/sxhkd/sxhkdrc
chmod +x ~/bin/*

echo "Installation completed. Please restart your session or window manager."
