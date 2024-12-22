# Missing dependencies
1. **bluetooth not connecting** `sudo pacman -S pipewire-alsa`
2. **missing japanese** `sudo pacman -S adobe-source-han-sans-jp-fonts`


# INSTALLING PIPEWIRE INSTEAD OF PULSE (USEFUL IF FORGET VOLUME)
```sh
pacman -S plasma-pa pipewire pipewire-pulse kpipewire
systemctl --user enable --now pipewire-pulse.service
```


# MISSING /vmlinuz-linux,...
sudo pacman -S linux --overwrite="*"


# KDE FILE PICKER
add to ~/.profile
```export GTK_USE_PORTAL=1```


# Wonkie sddm
sddm -> apply plasma settings


# PACMAN IS ALREADY IN USE (LOCK)
sudo rm -f /var/lib/pacman/db.lck


# RECOVER DELETED PARTITION
disktest


# TO CHECK
/etc/sysctl.d/disable_watchdog.conf      kernel.nmi_watchdog = 0
/etc/sysctl.d/dirty.conf                vm.dirty_writeback_centisecs = 6000


# REMOVE X11 ENTRIES
sudo mv /usr/share/xsessions/plasma.desktop /usr/share/xsessions/plasma.desktop.bak


# No backlight
* no backlight -> acpi_backlight=native in /boot/loader/entries/arch.conf
