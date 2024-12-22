# Mouse and autocomp in nano (best use old file)
add to /etc/nanorc
include "/usr/share/nano/*.nanorc"
set mouse

# NANO NO COLOR
Nano ships with predefined syntax highlighting rules, defined in /usr/share/nano/*.nanorc. To enable them, add the following line to your ~/.config/nano/nanorc or to /etc/nanorc:
include "/usr/share/nano/*.nanorc"

# NANO AS DEFAULT
export VISUAL=nano
export EDITOR=nano
git config --global core.editor "nano"
