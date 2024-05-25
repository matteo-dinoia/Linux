<!-- addo paru, extra per microcode, 3 base for paru, systemd auto... -->

https://wiki.archlinux.org/title/Preload -> auto preload is probably best for more ram


### RANDOM
* uso bc al posto di calc
* no flag work better for brigness control
* systemd-analyze blame
* dosfstool for mkfs.fat
* for bios update temporaly turn off secure boot
* https://wiki.archlinux.org/title/Mkinitcpio#Possibly_missing_firmware_for_module_XXXX for warning in Mkinitcpio
* no icon in timezone -> install noto-fonts-emoji
* nmtui for setting wifi easier
* pacman -Fy/-F file/-Fx $expr for getting package containg file
* rm /var/lib/pacman/db.lck to remove pacman currently in use
* sudo passwd -l root
* cannot aur/git install base-devil
* Excluding packages is achieved by prefixing a number or range of numbers with a caret (^).
* cool page https://wiki.archlinux.org/title/KDE
* wrong cursor theming in plasma 5 app -> use plasma5-integration
* use at least 500mb for boot
* downgrade to downgrade packages
* ntfs-3g for ntfs and exfat-utils for exfat
* no cube -> paru -S qt6-quick3d
* needed (?) for hardware acc. -> libva-mesa-driver

### REFLECTOR
sudo reflector --threads 64 --save /etc/pacman.d/mirrorlist --protocol https --latest 200 --score 50 --fastest 20 --sort rate --country Italy

### KDE FILE PICKER
add to ~/.profile
```export GTK_USE_PORTAL=1```

### AUTO-CPUFREQ
auto-cpufreq install on aur than
sudo systemctl mask power-profiles-daemon.service
systemctl enable --now auto-cpufreq

### TPM
use sbctl (watch arch-wiki)

### Wonkie sddm
sddm -> apply plasma settings

### ASUS
see wiki page on my laptop
asusctl, supergfxctl, rog-control-center
supergfxctl need to be enable in systemctl
* integrated is slower and peraphs even worst in performance
reducing core seems useless
intel-media-driver

### BATTERY
better battey -> install auto-cpufreq
Install powertop (for suggestions)
write to ```/etc/systemd/system/powertop.service``` (any name is fine)
```bash
[Unit]
Description=Powertop tunings

[Service]
Type=oneshot
RemainAfterExit=yes
ExecStart=/usr/bin/powertop --auto-tune
ExecStartPost=/usr/bin/bash -c '/usr/bin/echo on > $(grep -Rl "Wired Mouse" /sys/bus/usb/devices/*/product | sed "s/product/power\/control/") || true'

[Install]
WantedBy=multi-user.target
```
Then enable it by ```sudo systemctl enable --now powertop```
TLP install than enable ```sudo systemctl enable --now tlp```
To configure i can use tlpui
Best combo for now seem tlp and auto-cpufreq (+ better powersave on GUI of auto-cpufreq)

### TO CHECK
/etc/sysctl.d/disable_watchdog.conf      kernel.nmi_watchdog = 0
/etc/sysctl.d/dirty.conf                vm.dirty_writeback_centisecs = 6000

### ULTIMATE LOCALE FIX
install all language I use then set the ```/etc/locale.conf```
```bash
LANG=en_US.UTF-8
```
**! It is case sensitive and require exact match !**
If it is still broken change setting in KDE

### BLURRY GTK APP (or wrong cursor)
sudo pacman -S xdg-desktop-portal-gtk
reboot

### REMOVE X11 ENTRIES
sudo mv /usr/share/xsessions/plasma.desktop /usr/share/xsessions/plasma.desktop.bak

### WINE
No sound ->paru -S lib32-alsa-plugins lib32-libpulse lib32-openal

### PACMAN IS ALREADY IN USE (LOCK)
sudo rm -f /var/lib/pacman/db.lck

### RECOVER DELETED PARTITION
disktest

### FOR LATEX INSTALLATION
install texinfo texlive-basic texlive-bin texlive-langenglish texlive-langitalian texlive-latex texlive-latexextra texlive-latexrecommended texlive-pictures

### DATABASE
sudo rm -fr /var/lib/postgres/data/*  # if want to remove data
sudo su postgres
initdb -D /var/lib/postgres/data
sudo systemctl enable --now postgresql
createdb tweb
createuser --interactive
psql -d tweb
\password jakartas

### ALTERNATIVE NVIDIA
install nvidia and envycontrol
create file /bin/nvrun:
```
#!/bin/sh
__NV_PRIME_RENDER_OFFLOAD=1 __VK_LAYER_NV_optimus=NVIDIA_only __GLX_VENDOR_LIBRARY_NAME=nvidia $@
```
envycontrol -s _status_ (can use integrated for battery or hybrid for nvrun)
envycontrol -q (to know the actual status)
To run program on GPU use ```nvrun program```

### PC
* no backlight -> acpi_backlight=native in /boot/loader/entries/arch.conf

#### Profile on AC to quiet
sudo nano /etc/asusd/asusd.ron
``` platform_policy_on_ac: Quiet ```

### Firefox picker
Each setting can have the following values:

    0 – Never
    1 – Always
    2 – Auto (typically depends on whether Firefox is run from within Flatpak or whether the GDK_DEBUG=portals environment is set)

The settings are:

    widget.use-xdg-desktop-portal.file-picker – Whether to use XDG portal for the file picker
    widget.use-xdg-desktop-portal.mime-handler – Whether to use XDG portal for the mime handler
    widget.use-xdg-desktop-portal.settings – Whether to try to use XDG portal for settings/look-and-feel information
    widget.use-xdg-desktop-portal.location – Whether to use XDG portal for geolocation
    widget.use-xdg-desktop-portal.open-uri – Whether to use XDG portal for opening to a file

### IBERNAZIONE
https://rusty-electron.github.io/blog/setting-up-hibernation-in-arch-linux.html

* Create swap and add to fstab
* Copy UUID
* add in systemd boot resume=UUID=<UUID-copied>
* add resume to HOOKS in /etc/mkinitcpio.conf
* sudo mkinitcpio -P
* restart


### POWERTOP (copio in file proprio)
sudo nano /etc/systemd/system/powertop-config-apply.service
```
[Unit]
Description=Powertop setting
Wants=network.target
After=syslog.target network-online.target

[Service]
Type=oneshot
User=root
ExecStart=-echo '1500' > '/proc/sys/vm/dirty_writeback_centisecs'
ExecStart=-echo '1' > '/sys/module/snd_hda_intel/parameters/power_save'
ExecStart=-echo '0' > '/proc/sys/kernel/nmi_watchdog'
ExecStart=-echo 'auto' > '/sys/bus/i2c/devices/i2c-10/device/power/control'
ExecStart=-echo 'auto' > '/sys/bus/i2c/devices/i2c-22/device/power/control'
ExecStart=-echo 'auto' > '/sys/bus/i2c/devices/i2c-23/device/power/control'
ExecStart=-echo 'auto' > '/sys/bus/i2c/devices/i2c-8/device/power/control'
ExecStart=-echo 'auto' > '/sys/bus/i2c/devices/i2c-11/device/power/control'
ExecStart=-echo 'auto' > '/sys/bus/i2c/devices/i2c-6/device/power/control'
ExecStart=-echo 'auto' > '/sys/bus/i2c/devices/i2c-21/device/power/control'
ExecStart=-echo 'auto' > '/sys/bus/i2c/devices/i2c-5/device/power/control'
ExecStart=-echo 'auto' > '/sys/bus/i2c/devices/i2c-7/device/power/control'
ExecStart=-echo 'auto' > '/sys/bus/i2c/devices/i2c-9/device/power/control'
ExecStart=-echo 'auto' > '/sys/bus/i2c/devices/i2c-3/device/power/control'
ExecStart=-echo 'auto' > '/sys/bus/i2c/devices/i2c-4/device/power/control'
ExecStart=-echo 'auto' > '/sys/bus/pci/devices/0000:00:18.1/power/control'
ExecStart=-echo 'auto' > '/sys/bus/pci/devices/0000:02:00.0/power/control'
ExecStart=-echo 'auto' > '/sys/bus/pci/devices/0000:00:01.0/power/control'
ExecStart=-echo 'auto' > '/sys/bus/pci/devices/0000:00:04.0/power/control'
ExecStart=-echo 'auto' > '/sys/bus/pci/devices/0000:00:14.3/power/control'
ExecStart=-echo 'auto' > '/sys/bus/pci/devices/0000:00:18.3/power/control'
ExecStart=-echo 'auto' > '/sys/bus/pci/devices/0000:00:18.0/power/control'
ExecStart=-echo 'auto' > '/sys/bus/pci/devices/0000:00:08.0/power/control'
ExecStart=-echo 'auto' > '/sys/bus/pci/devices/0000:03:00.0/power/control'
ExecStart=-echo 'auto' > '/sys/bus/pci/devices/0000:00:00.2/power/control'
ExecStart=-echo 'auto' > '/sys/bus/pci/devices/0000:00:18.6/power/control'
ExecStart=-echo 'auto' > '/sys/bus/pci/devices/0000:00:18.4/power/control'
ExecStart=-echo 'auto' > '/sys/bus/pci/devices/0000:00:00.0/power/control'
ExecStart=-echo 'auto' > '/sys/bus/pci/devices/0000:35:00.2/power/control'
ExecStart=-echo 'auto' > '/sys/bus/pci/devices/0000:00:14.0/power/control'
ExecStart=-echo 'auto' > '/sys/bus/pci/devices/0000:00:18.7/power/control'
ExecStart=-echo 'auto' > '/sys/bus/pci/devices/0000:00:02.0/power/control'
ExecStart=-echo 'auto' > '/sys/bus/pci/devices/0000:04:00.0/power/control'
ExecStart=-echo 'auto' > '/sys/bus/pci/devices/0000:00:18.2/power/control'
ExecStart=-echo 'auto' > '/sys/bus/pci/devices/0000:00:18.5/power/control'
ExecStart=-echo 'auto' > '/sys/bus/pci/devices/0000:00:03.0/power/control'
ExecStart=-echo 'auto' > '/sys/bus/pci/devices/0000:35:00.0/power/control'

ExecStart=-echo 'disabled' > '/sys/class/net/eno1/device/power/wakeup'


[Install]
WantedBy=multi-user.target
```
sudo systemctl enable --now powertop-config-apply

NO COPIA VERSIONE CORRETTA

### BETTER BATTERY
https://www.youtube.com/watch?app=desktop&v=YE431SYO2Is

### Adding cachyos
https://wiki.cachyos.org/cachyos_repositories/how_to_add_cachyos_repo/

