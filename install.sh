#!/bin/bash

GREEN='\033[0;32m'   
RESET='\033[0m'      

echo -e "${GREEN}
#
#  ██╗      █████╗ ██╗   ██╗███╗   ██╗ ██████╗██╗  ██╗███████╗██████╗ 
#  ██║     ██╔══██╗██║   ██║████╗  ██║██╔════╝██║  ██║██╔════╝██╔══██╗
#  ██║     ███████║██║   ██║██╔██╗ ██║██║     ███████║█████╗  █████╔╝
#  ██║     ██╔══██║██║   ██║██║╚██╗██║██║     ██╔══██║╚═══██╗██╔═══╝
#  ███████╗██║  ██║╚██████╔╝██║ ╚████║╚██████╗██║  ██║███████║███████╗
#  ╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝ ╚═════╝╚═╝  ╚═╝╚══════╝╚══════╝
#
#      - https://github.com/ArturRomanchenko/dotfiles
#
${RESET}"

# 1️⃣ Update the system
sudo pacman -Syu --noconfirm

# 2️⃣ Install base development tools and essential utilities
sudo pacman -S --needed --noconfirm base-devel git vim nano wget curl

# 3️⃣ Install X server and window manager
sudo pacman -S --needed --noconfirm xorg-server xorg-xinit lightdm lightdm-gtk-greeter bspwm sxhkd

# 4️⃣ Desktop utilities
sudo pacman -S --needed --noconfirm polybar rofi picom alacritty nitrogen flameshot

# 5️⃣ Audio and multimedia
sudo pacman -S --needed --noconfirm pulseaudio pavucontrol cmus

# 6️⃣ Browsers and utilities
sudo pacman -S --needed --noconfirm firefox thunar htop ranger flatpak lxappearance xclip imagemagick gpick cmake make clang gcc

# 7️⃣ NVIDIA drivers (optional)
sudo pacman -S --needed --noconfirm nvidia nvidia-utils nvidia-settings

# 8️⃣ Install yay (AUR helper)
cd ~
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..
rm -rf yay

# 9️⃣ Install AUR packages
yay -S --noconfirm cava google-chrome obsidian zsh-theme-powerlevel10k-git

# 10️⃣ Set environment variable for Qt5 theme
echo 'QT_QPA_PLATFORMTHEME=qt5ct' | sudo tee -a /etc/environment > /dev/null

# 11️⃣ Create standard directories
mkdir -p ~/Downloads ~/Images ~/Music ~/Videos ~/Documents

# 12️⃣ Create configuration directories
mkdir -p ~/.config/bspwm ~/.config/sxhkd ~/.config/flameshot ~/.config/gtk-3.0 \
         ~/.config/picom ~/.config/polybar ~/.config/ranger ~/.config/rofi \
         ~/.config/alacritty ~/.config/nitrogen

# 13️⃣ Copy configuration files (if they exist)
cp -r ./config/bspwm/* ~/.config/bspwm/ 2>/dev/null
cp -r ./config/sxhkd/* ~/.config/sxhkd/ 2>/dev/null
cp -r ./config/flameshot/* ~/.config/flameshot/ 2>/dev/null
cp -r ./config/gtk-3.0/* ~/.config/gtk-3.0/ 2>/dev/null
cp -r ./config/picom/* ~/.config/picom/ 2>/dev/null
cp -r ./config/polybar/* ~/.config/polybar/ 2>/dev/null
cp -r ./config/ranger/* ~/.config/ranger/ 2>/dev/null
cp -r ./config/rofi/* ~/.config/rofi/ 2>/dev/null
cp -r ./config/alacritty/* ~/.config/alacritty/ 2>/dev/null
cp -r ./config/nitrogen/* ~/.config/nitrogen/ 2>/dev/null

# 14️⃣ Copy additional scripts and files
cp -r bin/ ~/ 2>/dev/null
cp ./xinitrc ~/.xinitrc 2>/dev/null
cp ./gtkrc-2.0 ~/.gtkrc-2.0 2>/dev/null

# 15️⃣ Update font cache
fc-cache -fv

# 16️⃣ Install themes
mkdir -p ~/.themes
cp -r ./themes/* ~/.themes/ 2>/dev/null

# 17️⃣ Make scripts executable
chmod +x ~/.config/bspwm/bspwmrc ~/.config/sxhkd/sxhkdrc ~/bin/* 2>/dev/null

# 18️⃣ Install Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
echo 'source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc

echo -e "${GREEN}Installation completed. Please restart your session or run startx.${RESET}"