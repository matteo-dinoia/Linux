# Nvidia Installation Guide (for my setup)

Install nvidia driver **(for nvivida Maxwell and up (>=Geforce 700))**:
```bash
sudo pacman -S nvidia
```
add pacman hook to compile module on kernel upgrades creating file `/etc/pacman.d/hooks/nvidia.hook` with:
```bash
[Trigger]
Operation=Install
Operation=Upgrade
Operation=Remove
Type=Package
Target=nvidia
Target=linux
# Change the linux part above and in the Exec line if a different kernel is used

[Action]
Description=Update Nvidia module in initcpio
Depends=mkinitcpio
When=PostTransaction
NeedsTargets
Exec=/bin/sh -c 'while read -r trg; do case $trg in linux) exit 0; esac; done; /usr/bin/mkinitcpio -P'
```
blacklist nouveau driver
```bash
sudo bash -c "echo blacklist nouveau > /etc/modprobe.d/blacklist-nvidia-nouveau.conf"
```
Load nvidia modules on boot modifying file /etc/mkinitcpio.conf as:
```bash
MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)
```
and then remaking the kernel:
```bash
sudo mkinitcpio -P linux
```

## Install prime run
```bash
sudo pacman -S nvidia-prime
```

Run the game with
```bash
prime-run <program-to-run>
```
