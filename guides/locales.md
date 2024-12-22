# WRONG LAYOUT SDDM
```sh
localectl set-x11-keymap --no-convert "it"
localectl set-keymap it
```

# LOCALE FIX
Install all needed locals (often missing italian)
then set the `/etc/locale.conf`
```bash
LANG=en_US.UTF-8
```
**! It is case sensitive and require exact match !**
If it is still broken change setting in KDE
