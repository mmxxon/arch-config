#!/bin/bash

# Define the tasks in functions
configure_timezone() {
    echo "Setting the time zone..."
    ln -sf /usr/share/zoneinfo/Europe/Kyiv /etc/localtime
    hwclock --systohc
}

configure_localization() {
    echo "Configuring localization..."
    sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
    sed -i 's/^#uk_UA.UTF-8 UTF-8/uk_UA.UTF-8 UTF-8/' /etc/locale.gen
    locale-gen
    echo "LANG=en_US.UTF-8" > /etc/locale.conf
}

configure_network() {
    echo "Configuring network..."
    echo "archer" > /etc/hostname
    echo -e "127.0.0.1\tlocalhost\n::1\t\tlocalhost\n127.0.1.1\tarcher.localdomain\tarcher" >> /etc/hosts
    systemctl enable iwd dhcpcd
}

set_root_password() {
    echo "Setting root password..."
    passwd
}

create_new_user() {
    echo "Creating new user..."
    useradd -m -g users -G wheel -s /bin/zsh xon
    passwd xon
}

configure_sudo() {
    echo "Configuring sudo for the new user..."
    echo "%wheel ALL=(ALL) ALL" >> /etc/sudoers
}

install_configure_bootloader() {
    echo "Installing and configuring bootloader..."
    grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
    grub-mkconfig -o /boot/grub/grub.cfg
}

# Define task names and corresponding functions in an associative array
tasks=(
    configure_timezone
    configure_localization
    configure_network
    set_root_password
    create_new_user
    configure_sudo
    install_configure_bootloader
)

# Catch errors
trap 'echo "Script failed on task: $current_task"' ERR

# Execution of tasks
start_task=${1:-${tasks[0]}}
for ((current_task_index=0; current_task_index<${#tasks[@]}; current_task_index++)); do
    if [[ "${tasks[$current_task_index]}" == "$start_task" || -n "$execute" ]]; then
        ${tasks[$current_task_index]}
        execute=true
    fi
done
