# Missing dependencies
1. **sddm theming missing** `sudo pacman -S sddm-kcm`
2. **missing google account in settings** `sudo pacman -S kaccounts-providers kio-gdrive`
3. **missing man** `sudo pacman -S man-db man-pages`
4. **missing dolphin pdf preview** `sudo pacman -S kdegraphics-thumbnailers` -> F12
5. **blurry gtk apps** `sudo pacman -S xdg-desktop-portal-gtk`
6. **font fuck ms** `sudo paru -S ms-font-ttf` (aur) 
* uso bc al posto di calc
* dosfstool for mkfs.fat
* no icon in timezone -> install noto-fonts-emoji
* nmtui for setting wifi easier
* wrong cursor theming in plasma 5 app -> use plasma5-integration
* ntfs-3g for ntfs and exfat-utils for exfat
* no cube -> paru -S qt6-quick3d
* downgrade to downgrade packages



# TOO MUCH OPTION IN TOUCHPAD (NOT EVEN WORKING)
remove package synaptics


# SCREENSHOT
* Use command in the costum shortcut: ``` spectacle -brenc ```
* clipboard->config->general->non-text-selection->"Only when explecetly copied"


# YAKUAKE NOT OPENING FIRST TIME
create costum shorcut


# MISSING HIDDEN IN MENU EDITOR
They must be enabled in the settings


# FOR LATEX INSTALLATION
install texinfo texlive-basic texlive-bin texlive-langenglish texlive-langitalian texlive-latex texlive-latexextra texlive-latexrecommended texlive-pictures


# DATABASE
sudo rm -fr /var/lib/postgres/data/*  # if want to remove data
sudo su postgres
initdb -D /var/lib/postgres/data
sudo systemctl enable --now postgresql
createdb tweb
createuser --interactive
psql -d tweb
\password jakartas
