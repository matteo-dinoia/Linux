# Quick Fix Application
## Random Application
### MAN
```sh
pacman -S man-db man-pages
```
### SCREENSHOT
* Use command in the costum shortcut: ``` spectacle -brenc ```
* clipboard->config->general->non-text-selection->"Only when explecetly copied"
### GREETING FISH
function fish_greeting
end
### NO PDF PREVIEW
pacman -S kdegraphics-thumbnailers
### YAKUAKE NOT OPENING FIRST TIME
create costum shorcut
### INSTALLING PIPEWIRE INSTEAD OF PULSE
```sh
pacman -S plasma-pa pipewire pipewire-pulse lib32-pipewire kpipewire wireplumber
systemctl --user start pipewire-pulse.service
systemctl --user enable pipewire-pulse.service
```
### INSTALLING OSU LAZER (ONLY WORK TABLET ON WAYLAND WITHOUT OPEN TABLET DRIVER)
* Install osu (via a AUR manager for example)
* Use mouse to disable raw input so I can use touchpad and graphical tablet
* Use configurator for Xorg in Kde for configure area

## Nano Setup
### NANO NO COLOR
Nano ships with predefined syntax highlighting rules, defined in /usr/share/nano/*.nanorc. To enable them, add the following line to your ~/.config/nano/nanorc or to /etc/nanorc:
include "/usr/share/nano/*.nanorc"
### NANO AS DEFAULT
export VISUAL=nano
export EDITOR=nano
### SET GIT TO USE NANO
git config --global core.editor "nano"

## Drivers
### TABLET NOT WORKING PROPERLY
pacman -S xf86-input-wacom
pacman -S usbutils (temporaneo)
lsusb  (e certo tavoletta e codice <4 exa:4 exa>)
sudo nano /etc/X11/xorg.conf.d/50-tablet.conf
(E inserisco:
    Section "InputClass"
        Identifier "Tablet"
        Driver "wacom"
        MatchDevicePath "/dev/input/event*"
        MatchUSBID "INSERISCO CODICE TROVATO PRIMA"
    EndSection
)
pacman -Runsc usbutils
reboot

## Speed Up
### ADDING PARALLEL DOWNLOAD ON PACMAN/YAY
sudo nano /etc/pacman.conf
uncommnet: ParallelDownloads = 5
### SLOW PC
https://www.linkedin.com/pulse/how-make-your-archlinux-faster-sourav-goswami
### FIREFOX SLOW
change dns (in ipv4 del wifi)
a     8.8.8.8, 8.8.4.4

## Installation
### SETTING UP SYSTEMD-BOOT
https://www.addictivetips.com/ubuntu-linux-tips/set-up-systemd-boot-on-arch-linux/
file /boot/loader/entries/arch.conf
    title Arch Linux
    linux   /vmlinuz-linux
    initrd /initramfs-linux.img
    options "root=PARTUUID=52c6c8e8-99a9-fa47-8e66-869dfb3b8954 quiet loglevel=3 systemd.show_status=0 rw"
file /boot/loader/loader.conf
    default arch
    timeout menu-hidden
    console-mode auto
    editor no
