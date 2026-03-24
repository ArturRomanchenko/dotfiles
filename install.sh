#!/bin/bash
set -euo pipefail

LOG=install.log
exec > >(tee -i $LOG)
exec 2>&1

echo "Starting installation..."

# =========================
# CHECK REQUIRED FILES
# =========================
[ -f ./xinitrc ] || { echo "xinitrc missing"; exit 1; }
[ -d ./config/bspwm ] || { echo "bspwm config missing"; exit 1; }
[ -d ./config/sxhkd ] || { echo "sxhkd config missing"; exit 1; }

# =========================
# UPDATE SYSTEM
# =========================
sudo pacman -Syu --noconfirm

# =========================
# BASE PACKAGES
# =========================
sudo pacman -S --needed --noconfirm \
  base-devel git vim nano wget curl

# =========================
# XORG + WM
# =========================
sudo pacman -S --needed --noconfirm \
  xorg-server xorg-xinit xorg-xrandr xorg-xsetroot \
  lightdm lightdm-gtk-greeter \
  bspwm sxhkd

# =========================
# DESKTOP TOOLS
# =========================
sudo pacman -S --needed --noconfirm \
  polybar rofi picom alacritty nitrogen \
  flameshot dunst lxappearance qt5ct

# =========================
# SYSTEM TOOLS
# =========================
sudo pacman -S --needed --noconfirm \
  thunar firefox htop ranger flatpak \
  pavucontrol pulseaudio cmus \
  xclip imagemagick gpick \
  cmake make clang gcc

# =========================
# NVIDIA (optional)
# =========================
sudo pacman -S --needed --noconfirm \
  nvidia nvidia-utils nvidia-settings || echo "Skipping NVIDIA"

# =========================
# INSTALL YAY
# =========================
cd ~
rm -rf yay
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..
rm -rf yay

# =========================
# AUR PACKAGES
# =========================
yay -S --noconfirm cava google-chrome obsidian zsh-theme-powerlevel10k-git || echo "Some AUR packages failed"

# =========================
# ENVIRONMENT
# =========================
echo 'QT_QPA_PLATFORMTHEME=qt5ct' | sudo tee -a /etc/environment

# =========================
# DIRECTORIES
# =========================
mkdir -p ~/Downloads ~/Images ~/Music ~/Videos ~/Documents
mkdir -p ~/.config

# =========================
# COPY CONFIGS (STRICT)
# =========================
echo "Copying configs..."

cp -r ./config/* ~/.config/
cp ./xinitrc ~/.xinitrc

# =========================
# PERMISSIONS
# =========================
chmod +x ~/.config/bspwm/bspwmrc
chmod +x ~/.config/sxhkd/sxhkdrc
chmod +x ~/.xinitrc

# =========================
# FONTS CACHE
# =========================
fc-cache -fv

# =========================
# ENABLE SERVICES
# =========================
sudo systemctl enable lightdm

# =========================
# ZSH
# =========================
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo 'source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc

# =========================
# DONE
# =========================
echo "Installation completed."
echo "Check log: $LOG"
echo "Reboot and run: startx"
