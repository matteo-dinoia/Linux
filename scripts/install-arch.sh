#!/bin/bash
#TODO FUTURE os-prober
#TODO FUTURE is hour correct
#TODO FUTURE you need to partition your disk before

dryRun=0
biosMode=0;
getSetting(){

    while getopts ":h :b :d" option; do
        case "$option" in
            b)
                biosMode=1;
                ;;
            d)
                dryRun=1
                ;;
            h)
                echo -e "Usage: $0 [-b bios-mode] [-d dry-run] [-h help]" 1>&2; exit 1;
                ;;
        esac
    done

    #START OF DRY-RUN
    clear
    text=""
    if [ "$dryRun" = "1" ]; then
        text="dry run"
    else
        echo -e "Warning: Normal run not recommended for first run"
        text="normal run"
    fi

    if [ "$biosMode" = "1" ]; then
        echo -e "Warning: Uefi recommended if present"
        text="$text, bios mode"
    else
        text="$text, uefi mode"
    fi

    askYnContinue "Info:\t Starting up installation ($text)($dryRun,$biosMode)"
}


askYnContinue(){
    echo -e "$1"

    VAR=1
    while [ "$VAR" -ne "0" ]; do
        read -r -p "Ask:     Do you want to continue [Y/n]" input
        case $input in
            [nN][oO]|[nN])
                printf "Info:\t Stopping installation by user action\n"
                exit 2
                ;;
            [yY][eE][sS]|[yY]|"")
                VAR=0
                ;;
            *)
                echo "Invalid input..."
                ;;
        esac
    done
}

errorChecking(){
    #silent mode is default
    command="$1 > /dev/null >&1";

    if [ "$3" = "1" ]; then
        command="$1"
    fi

    #execute command
    if ! eval $command; then
        askYnContinue "\e[31mError:\t $2\e[0m"
    fi
}

#OBTAIN PARAMETER (d and h)
getSetting "$@"
shift $((OPTIND-1))
echo "$dryRun $biosMode $1 $2 $3"

#ACTUAL SCRIPT
printf "Cmd:\t loading italian keyboards\n"
    loadkeys it

printf "Cmd:\t syncing clock\n"
    errorChecking "timedatectl set-ntp true" "while syncing clock"

#END OF DRY-RUN
if [ "$dryRun" = "1" ]; then
        echo -e "Info:\t dry-run finished"
        exit 2;
fi

printf "Cmd:\t making fylesistem on partition (need to be already formatted)\n"
    askYnContinue "Info:\t $1 will be used for EFI boot $2 for swap and $3 for root (/)"
    errorChecking "mkfs.fat -F 32 $1" "while formatting in fat32 partition $1" 1
    errorChecking "mkswap $2" "while formatting in swap partition $2" 1
    errorChecking "mkfs.ext4 $3" "while formatting in ext4 partition $3" 1

printf "Cmd:\t install base package\n"
    errorChecking "pacstrap /mnt base linux linux-firmware" "while downloading basic package" 1

printf "Cmd:\t generating fstab\n"
    genfstab -U /mnt >> /mnt/etc/fstab

printf "Cmd:\t chrooting into new install\n"
    arch-chroot /mnt

printf "Cmd:\t setting regional to Rome and syncing local clock\n"
    ln -sf /usr/share/zoneinfo/Europe/Rome /etc/localtime
    hwclock --systohc

printf "Cmd:\t setting US language and IT keyboard\n"
    printf "\nen_US.UTF-8 UTF-8" >> /etc/locale.gen
    locale-gen
    printf "LANG=en_US.UTF-8" > /etc/locale.conf
    printf "KEYMAP=it" > /etc/vconsole.conf

printf "Cmd:\t setting hostname\nInfo:\t hostname=\"arch\"\n"
    printf "arch" > /etc/hostname

printf "Cmd:\t setting password, usarname and group\n"
    printf "Ask:\t write superuser password\n"
    passwd #set root pass
    read -r -p "Ask:     write a username:" username
    printf "Ask:\t write $username password\n"
    useradd -m "$username"
    passwd "$username" #user passwd
    usermod -aG wheel,audio,video,optical,storage "$username"

printf "Cmd:\t installing package (git, networkmanager, nano, sudo, grub)\n"
    printf "Info:\t os-prober install is not implemented yet\n"
    pacman -S sudo nano git networkmanager grub efibootmgr dosfstools mtools
    errorChecking "visudo -f sudoers.tmp" "trasporting file to visudo (try setting manually)"
    systemctl enable NetworkManager

printf "Cmd:\t creating linux boot image\n"
    mkinitcpio -P

printf "Cmd:\t grub install\n"
    if [ "$biosMode" = "1" ]; then
        printf "Cmd:\t check for uefi mode\n"
        errorChecking "ls /sys/firmware/efi/efivars" "BIOS MODE not supported yet (please exit)"
        printf "Info:\t installing grub in bios mode\n"
        grub-install  --recheck
        grub-mkconfig -o /boot/grub/grub.cfg

    else
        printf "Info:\t installing grub in uefi mode\n"
        grub-install --target=x86_64-efi --efi-directory=/boot --recheck
        grub-mkconfig -o /boot/grub/grub.cfg
    fi


printf "Cmd:\t exiting\nInfo:\t just need to reboot (with \"reboot\")\n"
    exit
    umount -lf /mnt
