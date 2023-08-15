# Quick Fixes
## To add
reflector how

## Random app
### THUMBNAILERS IN DOLPHIN
kdegraphics-thumbnailers -> for pdf thumbnails


## Sddm
### WRONG LAYOUT SDDM
```sh
localectl set-x11-keymap --no-convert "it"
localectl set-keymap it
```
### NO SDDM THEMING
pacman -S sddm-kcm

## Settings
### NO OSD (ON-SCREEN DISPLAY)
* System Settings > Workspace Behavior > General Behavior
* Check: Display visual feedback for status change
### REMOVE MIDDLE CLICK PASTE (ONLY WAYLAND)
* System Settings > Workspace Behavior > General Behavior
* Unceck: Middle click > Paste Selected Text
### NOT ALL ACCOUNT IN ACCOUNT PAGE
```sh
pacman -S kaccounts-providers kio-gdrive
```
### TOO MUCH OPTION IN TOUCHPAD (NOT EVEN WORKING)
remove package synaptics
### SHUTTING DOWN SHORTCUT
qdbus org.kde.ksmserver /KSMServer logout 1 2 0
### SHUTTING DOWN TAKES AGES
install sddm-git instead og sddm
### LOCALE FIX
Install all needed locals (often missing italian)




