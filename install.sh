#!/bin/bash

# Установка необходимых пакетов
sudo pacman -Syu --noconfirm \
    bspwm sxhkd polybar rofi ranger git fastfetch feh flameshot lxappearance \
    qt5ct picom alacritty obs-studio papirus-icon-theme ttf-jetbrains-mono \
    thunar alsa-utils cmus pavucontrol

# Установка базовых инструментов разработки и yay
sudo pacman -S --needed --noconfirm base-devel git
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ..
rm -rf yay

# Установка пакета из AUR
yay -S --noconfirm cava

# Настройка переменной окружения для qt5ct
echo 'QT_QPA_PLATFORMTHEME=qt5ct' | sudo tee -a /etc/environment > /dev/null

mkdir -p ~/Downloads ~/Images ~/Music ~/Videos ~/Documents
cp -r ./Images/* ~/Images/

# Создание конфигурационных директорий
mkdir -p ~/.config/bspwm ~/.config/sxhkd ~/.config/flameshot ~/.config/gtk-3.0 ~/.config/picom ~/.config/polybar ~/.config/ranger ~/.config/rofi ~/.config/cmus

# Копирование конфигурационных файлов
cp -r ./config/bspwm/* ~/.config/bspwm/
cp -r ./config/sxhkd/* ~/.config/sxhkd/
cp -r ./config/flameshot/* ~/.config/flameshot/
cp -r ./config/gtk-3.0/* ~/.config/gtk-3.0/
cp -r ./config/picom/* ~/.config/picom/
cp -r ./config/polybar/* ~/.config/polybar/
cp -r ./config/ranger/* ~/.config/ranger/
cp -r ./config/rofi/* ~/.config/rofi/
cp -r ./config/cmus/* ~/.config/cmus/

# Копирование дополнительных скриптов и файлов
cp -r ./bin/* ~/bin/
cp ./fehbg ~/
cp ./xinitrc ~/
cp ./gtkrc-2.0 ~/

# Установка шрифтов
mkdir -p ~/.local/share/fonts
cp -r ./fonts/* ~/.local/share/fonts/

# Обновление кэша шрифтов
fc-cache -fv

# Установка темы
mkdir -p ~/.themes
cp -r ./themes/* ~/.themes/

# Сделать скрипты исполняемыми
chmod +x ~/.config/bspwm/bspwmrc
chmod +x ~/.config/sxhkd/sxhkdrc
chmod +x ~/bin/*

echo "Installation completed. Please restart your session or window manager."

