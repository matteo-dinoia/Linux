# Games

# Setup wine
https://www.gloriouseggroll.tv/how-to-get-out-of-wine-dependency-hell/

# Black screen on video
mf-install.sh

# No sound
No sound ->paru -S lib32-alsa-plugins lib32-libpulse lib32-openal


# Specific games
## INSTALLING OSU LAZER (ONLY WORK TABLET ON WAYLAND WITHOUT OPEN TABLET DRIVER)
* Install osu (via a AUR manager for example)
* Use mouse to disable raw input so I can use touchpad and graphical tablet
* Use configurator for Xorg in Kde for configure area

## MINECRAFT FAILING TO LAUNCH
```sh
pacman -S xorg-xrandr
```
