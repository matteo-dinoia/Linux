# Nvidia Installation Guide (for my setup)

Install nvidia driver **(for nvivida Maxwell and up (>=Geforce 700))**:
```bash
sudo pacman -S nvidia
```
add pacman hook to compile module on kernel upgrades creating file `/etc/pacman.d/hooks/nvidia.hook` with:
```text
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
```sh
sudo bash -c "echo blacklist nouveau > /etc/modprobe.d/blacklist-nvidia-nouveau.conf"
```
Load nvidia modules on boot modifying file /etc/mkinitcpio.conf as:
```sh
MODULES=(nvidia nvidia_modeset nvidia_uvm nvidia_drm)
```
and then remaking the kernel:
```sh
sudo mkinitcpio -P linux
```
Add the kernel parameter nvidia-drm.modeset=1 to /etc/default/grub (or /boot/loader/entries/arch.conf) and run the command sudo update-grub

May be usefull to ensure some package are installed:
```sh
sudo pacman -Syu --needed xorg-xwayland libxcb egl-wayland
```

**IMPORTANT NOTE**: use ibt=off in kernel parameter in grub for avoid not booting (problem with intel)


## Using only on application (Prime-Run)
```bash
sudo pacman -S nvidia-prime
```

Run the game with
```bash
prime-run <program-to-run>
```


## ALTERNATIVE NVIDIA
install nvidia and envycontrol
create file /bin/nvrun:
```
#!/bin/sh
__NV_PRIME_RENDER_OFFLOAD=1 __VK_LAYER_NV_optimus=NVIDIA_only __GLX_VENDOR_LIBRARY_NAME=nvidia $@
```
envycontrol -s _status_ (can use integrated for battery or hybrid for nvrun)
envycontrol -q (to know the actual status)
To run program on GPU use ```nvrun program```
