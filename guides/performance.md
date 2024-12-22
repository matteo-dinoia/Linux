# ASUS Laptop (see wiki)
1. asusctl, supergfxctl (need enabled), rog-control-center
2. maybe needed for hardware acc. -> libva-mesa-driver

# Speed

## Blaming startup times
systemd-analyze blame
[tecmint](https://www.tecmint.com/systemd-analyze-monitor-linux-bootup-performance)

## Preloading
https://wiki.archlinux.org/title/Preload -> auto preload is probably best for more ram

## REFLECTOR
sudo reflector --threads 64 --save /etc/pacman.d/mirrorlist --protocol https --latest 200 --score 50 --fastest 20 --sort rate --country Italy

# FIREFOX SLOW TO BOOT
change dns (in ipv4 del wifi)
a     8.8.8.8, 8.8.4.4

# Battery
## AUTO-CPUFREQ
auto-cpufreq install on aur than
sudo systemctl mask power-profiles-daemon.service
systemctl enable --now auto-cpufreq

## TLP
TLP install than enable ```sudo systemctl enable --now tlp```
To configure i can use tlpui

## Powertop
Install powertop (for suggestions)
write to ```/etc/systemd/system/powertop-tuning.service``` (any name is fine)
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
Then enable it by ```sudo systemctl enable --now powertop-tuning```

## Profile on AC to quiet
sudo nano /etc/asusd/asusd.ron
``` change_throttle_policy_on_ac: false ```
also edit to prevent problem to
``` disable_nvidia_powerd_on_battery: false```
