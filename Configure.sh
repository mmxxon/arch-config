#!/bin/bash

check_network() {
    echo "Checking network connection..."
    ping -c 3 archlinux.org || { echo "Error: Not connected to the network. Please connect to a network and run the script again." && exit 1; }
}

install_yay() {
    echo "Installing yay..."
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si
    cd ..
    rm -rf yay
}

configure_pipewire() {
    echo "Configuring Pipewire..."
    systemctl --user enable --now pipewire
    systemctl --user enable --now pipewire-pulse
    pactl info | grep "Server Name"
}

configure_i3() {
    echo "Configuring the i3 window manager..."
    cp /etc/i3/config ~/.config/i3/config
}

configure_programming_envs() {
    echo "Configuring your programming environments..."
    rustup install stable
    python --version
    gcc --version
}

install_additional_software() {
    echo "Installing additional desired software..."
    yay -Sy librewolf-bin
}

# List of all functions to be executed
tasks=(
    check_network
    install_configure_editor
    install_yay
    configure_pipewire
    configure_i3
    configure_programming_envs
    install_additional_software
)

# Catch errors
trap 'echo "Script failed on task: ${tasks[$current_task_index]}"' ERR

# Execution of tasks
start_task=${1:-${tasks[0]}}
for ((current_task_index=0; current_task_index<${#tasks[@]}; current_task_index++)); do
    if [[ "${tasks[$current_task_index]}" == "$start_task" || -n "$execute" ]]; then
        ${tasks[$current_task_index]}
        execute=true
    fi
done
