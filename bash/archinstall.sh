# loadkeys us
# get wifi
# mount partitions properly
# pacstrap /mnt base linux linux-firmware sof-firmware base-devel grub efibootmgr nano networkmanager
# genfstab /mnt > /mnt/etc/fstab
# arch-chroot /mnt
# ln -sf /usr/share/zoneinfo/Asia/Kolkata /etc/localtime
# hwclock --systohc
# nano /etc/locale.gen 
# uncomment en_US.UTF-8 UTF-8
# echo "LANG=en_US.UTF-8" > /etc/locale.conf
# echo "KEYMAP=us" > /etc/vconsole.conf 
# echo "Archie" > /etc/hostname
# passwd
# useradd -m -G wheel -s /bin/bash hrishabhmittal
# passwd hrishabhmittal
# EDITOR=nano visudo
# scroll down find => %wheel ALL=(ALL) ALL or similar -> uncomment
# systemctl enable NetworkManager 
# grub-install /dev/nvme0n1
# grub-mkconfig -o /boot/grub/grub.cfg
# (maybe disable os-prober)
# sudo pacman -S awesome sddm alacritty neovim firefox git 
# git config --global user.name "Your Name"
# git config --global user.email "your-email@example.com"
# sudo systemctl enable sddm
# sudo systemctl enable --now sddm



## ssh-keygen -t rsa -b 4096 -C "your-email@example.com"
## cat ~/.ssh/id_rsa.pub
## add to github

