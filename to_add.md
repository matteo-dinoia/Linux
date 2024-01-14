addo paru, extra per microcode, 3 base for paru, systemd auto...

https://wiki.archlinux.org/title/Preload -> auto preload is probably best for more ram


### RANDOM
* systemd-analyze blame
* dosfstool for mkfs.fastest
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

### REFLECTOR
reflector --threads 4 --latest 40 --score 40 --fastest 40 --sort rate --save /etc/pacman.d/mirrorlist
reflector --threads 4 --save /etc/pacman.d/mirrorlist --protocol https --latest 50 --sort rate --fastest 20 --country Italy,France,Germany
sudo reflector --verbose -l 200 -n 20 -p https --sort rate --save /etc/pacman.d/mirrorlist
reflector --threads 64 --save /etc/pacman.d/mirrorlist --protocol https --latest 200 --score 50 --fastest 20 --sort rate

### KDE FILE PICKER
add to ~/.profile
```export GTK_USE_PORTAL=1```

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

### BLURRY GTK APP
sudo pacman xdg-desktop-portal-gtk

### REMOVE X11 ENTRIES
sudo mv /usr/share/xsessions/plasma.desktop /usr/share/xsessions/plasma.desktop.bak

### WINE
No sound ->paru -S lib32-alsa-plugins lib32-libpulse lib32-openal

### PACMAN IS ALREADY IN user
rm /var/lib/pacman/db.lck

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
