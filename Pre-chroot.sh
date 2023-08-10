#!/bin/bash

# Define the tasks in functions
setup_partitions() {
    echo "Setting up partitions..."
    mkfs.fat -F32 /dev/nvme0n1p1
    mkswap /dev/nvme0n1p2
    swapon /dev/nvme0n1p2
    mkfs.ext4 /dev/nvme0n1p3
    mount /dev/nvme0n1p3 /mnt
}

mount_boot_partition() {
    echo "Mounting boot partition..."
    mkdir /mnt/boot
    mount /dev/nvme0n1p1 /mnt/boot
}

install_base_system() {
    echo "Installing base system..."
    pacstrap /mnt base base-devel linux linux-firmware neovim git dhcpcd iwd grub efibootmgr os-prober reflector zsh
}

generate_fstab() {
    echo "Generating fstab..."
    genfstab -U /mnt >> /mnt/etc/fstab
}

chroot_system() {
    echo "Chrooting into new system..."
    arch-chroot /mnt 
}

# Define task names and corresponding functions in an associative array
tasks=(
    setup_partitions
    mount_boot_partition
    install_base_system
    generate_fstab
    chroot_system
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
