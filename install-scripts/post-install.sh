#SDDM E THEMING
echo "enable sddm"
sudo systemctl enable sddm


#LANGUAGE
echo "language fix (maybe)"
printf "en_US.UTF-8 UTF-8\nit_IT.UTF-8 UTF-8\n" | sudo tee /etc/locale.gen
printf "[Formats]LANG=en_US.UTF-8\nLC_ADDRESS=it_IT.UTF-8\nLC_MEASUREMENT=it_IT.UTF-8\nLC_MONETARY=it_IT.UTF-8\nLC_NAME=it_IT.UTF-8\nLC_NUMERIC=it_IT.UTF-8\nLC_PAGE=it_IT.UTF-8\nLC_TELEPHONE=it_IT.UTF-8\nLC_TIME=it_IT.UTF-8" > ~/.config/plasma-localerc 
printf "LANG=en_US.UTF-8\nLC_ADDRESS=it_IT.UTF-8\nLC_MEASUREMENT=it_IT.UTF-8\nLC_MONETARY=it_IT.UTF-8\nLC_NAME=it_IT.UTF-8\nLC_NUMERIC=it_IT.UTF-8\nLC_PAGE=it_IT.UTF-8\nLC_TELEPHONE=it_IT.UTF-8\nLC_TIME=it_IT.UTF-8" | sudo tee /etc/locale.conf
sudo locale-gen

echo "change sddm and x11 keymap"
localectl set-x11-keymap --no-convert "it"
localectl set-keymap it


#YAY
sudo pacman -Syu --needed git base-devel
cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si


#APPLICATION
yay -S xournalpp code discord kio-gdrive kaccounts-providers touche fish sddm-kcm yakuake plasma kalgebra sddm-kcm kcm-wacomtablet pulseaudio-bluetooth partitionmanager ark unrar gwenview spectacle
yay -Runsc plasma-sdk kinfocenter
printf "function fish_greeting\nend"  | sudo tee /home/matteo/.config/fish/config.fish
sudo systemctl start touchegg
sudo systemctl enable touchegg
sudo systemctl start bluetooth
sudo systemctl enable bluetooth
yay -c

echo"still need to configure tablet -> See QuickFix.txt"
