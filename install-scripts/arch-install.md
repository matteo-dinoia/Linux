# Arch Install

## Actual install preparation
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

## Notes

## Possible programs to install
