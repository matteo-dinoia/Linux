# Quick Fix Application
## Random Application
### MAN
```sh
pacman -S man-db man-pages
```
### SCREENSHOT
* Use command in the costum shortcut: ``` spectacle -brenc ```
* clipboard->config->general->non-text-selection->"Only when explecetly copied"
### NO PDF PREVIEW
pacman -S kdegraphics-thumbnailers
### YAKUAKE NOT OPENING FIRST TIME
create costum shorcut
### INSTALLING PIPEWIRE INSTEAD OF PULSE (USEFUL IF FORGET VOLUME)
```sh
pacman -S plasma-pa pipewire pipewire-pulse kpipewire
systemctl --user start pipewire-pulse.service
systemctl --user enable pipewire-pulse.service
```
### INSTALLING OSU LAZER (ONLY WORK TABLET ON WAYLAND WITHOUT OPEN TABLET DRIVER)
* Install osu (via a AUR manager for example)
* Use mouse to disable raw input so I can use touchpad and graphical tablet
* Use configurator for Xorg in Kde for configure area

### MINECRAFT FAILING TO LAUNCH
```sh
pacman -S xorg-xrandr
```
### FIREFOX NO PINCH TO ZOOM
MOZ_ENABLE_WAYLAND=1 firefox

### MISSING HIDDEN IN MENU EDITOR
They must be enabled in the settings

### NO TITLEBAR FIREFOX
customize -> [] title bar

### NOT CONNECTING BLUETOOTH
sudo pacman -S pipewire-alsa

### Mouse and autocomp in nanot (best use old file)
add to /etc/nanorc
include "/usr/share/nano/*.nanorc"
set mouse

### NO JP
sudo pacman -S adobe-source-han-sans-jp-fonts


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
## Reducing problem with out of memory (kill first process not best)
sudo sysctl -w vm.oom_kill_allocating_task=1

## Reserve memory before dying
sudo sysctl -w vm.admin_reserve_kbytes=256000000


### DISABLING MODULE FOR WEBCAM
Cameras are controlled by the uvcvideo kernel module.

You can disable the camera until reboot by opening a terminal and typing sudo modprobe -r uvcvideo. You will be asked for your password, and after typing it, if there are no errors shown in the terminal, your webcam should be disabled.

If you got the error message: modprobe: FATAL: Module uvcvideo is in use. after trying to remove the uvcvideo module, you can try to force its removal with the following: sudo rmmod -f uvcvideo (thanks thiagowfx)

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
