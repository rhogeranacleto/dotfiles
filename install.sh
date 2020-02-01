#!/bin/bash

# Export the path to this directory
export DOTFILES_PATH=$PWD

yay -Sy ttf-joypixels ttf-croscore noto-fonts-cjk noto-fonts \
    ttf-fantasque-sans-mono ttf-linux-libertine ttf-fira-code \
    ttf-typicons nerd-fonts-iosevka

yay -Sy visual-studio-code-bin arandr docker docker-compose google-chrome \
    feh kitty kitty-terminfo nvm-git oh-my-zsh-git polybar-git postman \
    slack-desktop spotify whatsapp-nativefier xclip zsh zsh-autosuggestions \
    zsh-syntax-highlighting starship

yay -R arcolinux-conky-collection-git atom conky-lua-archers firefox geany \
    gmrun pragha sublime-text-dev termite termite-terminfo variety vi vim \
    vivaldi vivaldi-codecs-ffmpeg-extra-bin trizen urxvt-resize-font-git \
    urxvt-perls rxvt-unicode-terminfo rxvt-unicode xfce4-terminal xfce4-taskmanager \
    meld evolution

chsh -s $(which zsh)

sudo cp ./fonts/icomoon.ttf /usr/share/fonts

# Link all dotfiles into their appropriate locations
cd $HOME
ln -sf $DOTFILES_PATH/home/.* .

cd $HOME/.config
ln -sf $DOTFILES_PATH/config/* .