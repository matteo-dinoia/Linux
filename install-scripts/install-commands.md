# Arch Linux install

## Start
loadkeys it
timedatectl set-ntp true

## Internet
iwctl
station wlan0 get-networks
statuon wlan0 connect <SSID>
exit

## Partitioning and mounting
### use fdisk
mkfs.fat -F 32 <BOOT-PART>
mkswap <SWAP-PART>
mkfs.ext4 <LINUX-PART>

mount <LINUX-PART> /mnt
mount --mkdir <BOOT-PART> /mnt/boot
swapon <SWAP-PART>

## Basic install
reflector -l 20 -p https --sort rate --threads 64 --verbose --save /etc/pacman.d/mirrorlist
### Add parallel download to /etc/pacman.conf
### can be required -> pacman -S archlinux-keyring
pacstrap /mnt base linux linux-firmware git base-devel networkmanager nano sudo

## Chroot
genfstab -U /mnt >> /mnt/etc/fstab
### Check if the file is ok
arch-chroot /mnt

## Start of chroot
ln -sf /usr/share/zoneinfo/Europe/Rome /etc/localtime
hwclock --systohc
echo "arch" > /etc/hostname
systemctl enable NetworkManager

## Locales
### uncomment /etc/locale.gen (both)
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "KEYMAP=it" > /etc/vconsole.conf
localectl set-x11-keymap --no-convert "it"
localectl set-keymap it

## Users
useradd -m <USERNAME>
passwd <USERNAME>
usermod -aG wheel,audio,video,optical,storage <USERNAME>
EDITOR=visudo

## Boot manager
mkinitcpio -P
bootctl --path=/boot install
blkid <LINUX-PART>

file /boot/loader/entries/arch.conf
```
title Arch Linux
linux   /vmlinuz-linux
initrd  /initramfs-linux.img
options root=UUID=<insert_uuid> quiet loglevel=3 rw
```

file /boot/loader/loader.conf
```
default arch
timeout 0
console-mode max
editor no
```


## End
exit
umount -lf /mnt
reboot



# After Restart

## Base
### connect with nmtui
cd /tmp
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si
paru -S paru-bin

## Plasma install
### Add parallel download to /etc/pacman.conf
paru -S plasma sddm dolphin konsole ark okular gwenview firefox yakuake spectacle kate
paru -Runsc plasma-welcome discover
sudo systemctl enable --now sddm



# After Install

## Micro fix
paru -S man-db noto-fonts-emoji unrar kio-gdrive xwaylandvideobridge kdegraphics-thumbnailers pipewire-alsa
sudo systemctl enable --now bluetooth

## App install
paru -S xournalpp code discord partitionmanager systemmonitor
### install auto cpufreq TODO
paru -S powertop htop neofetch asusctl supergfxctl rog-control-center nvidia github-cli reflector
tolto rog-control-center tlp tlpui envycontrol
### Rerun reflector TODO
