#!/bin/bash

# Made by fernandomaroto for EndeavourOS and Portergos

# Adapted from AIS. An excellent bit of code!

# Super ugly command now :(
# If multiples partitions are used
chroot_path=$(lsblk |grep "calamares-root" |awk '{ print $7 }' |sed -e 's/\/tmp\///' -e 's/\/.*$//' |tail -n1)

arch_chroot(){
# Use chroot not arch-chroot because of the way calamares mounts partitions
    chroot /tmp/$chroot_path /bin/bash -c "${1}"
}  

# Anything to be executed outside chroot need to be here.

# Copy any file from live environment to new system

#local 
_files_to_copy=(

/etc/os-release
/etc/lightdm/*
/etc/sddm.conf.d/kde_settings.conf
/etc/pacman.d/hooks/*
/etc/lsb-release
/etc/default/grub


)

#local xx

for xx in ${_files_to_copy[*]}; do rsync -vaRI $xx /tmp/$chroot_path; done

#cp -f /etc/os-release $chroot_path/etc/os-release
#cp -rf /etc/lightdm $chroot_path/etc
#cp -rf /etc/sddm.conf $chroot_path/etc
#rsync -vaRI /etc/os-release /etc/lightdm/* /etc/sddm.conf.d/kde_settings.conf $chroot_path

# For chrooted commands edit the script bellow directly
arch_chroot "/usr/bin/chrooted_cleaner_script.sh"
