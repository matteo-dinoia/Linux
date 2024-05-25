# Arch Install

## Preparation for install
``` Bash
loadkeys it

nano /etc/pacman.conf
# uncomment parallel download
# uncomment color

iwctl
station wlan0 get-networks
station wlan0 connect <network>
#insert password
exit

archinstall
```

## Options
* Mirrors -> Italy
* Locals -> keyboard -> Italy
* Setup disk and user
* Profile -> Minimal
* Audio -> pipewire
* Network -> Network Manager

### Programs list
plasma-meta, firefox, dolphin, konsole, nano (+)

## Post installation
After quit and reboot:
