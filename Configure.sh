#!/bin/bash

log_file="error.log"

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

run_additional_script() {
    # Assuming zsh is installed here as part of the additional script
	bash configure_programs.sh software_list.csv config_list.csv
}

configure_pipewire() {
    echo "Configuring Pipewire..."
    systemctl --user enable --now pipewire
    systemctl --user enable --now pipewire-pulse
    pactl info | grep "Server Name"
}


# List of all functions to be executed
tasks=(
    check_network
    install_yay
    run_additional_script
    configure_pipewire
)

# Catch errors
trap 'echo "Script failed on task: ${tasks[$current_task_index]}"; echo "Script failed on task: ${tasks[$current_task_index]}" >> $log_file' ERR

# Execution of tasks
start_task=${1:-${tasks[0]}}
for ((current_task_index=0; current_task_index<${#tasks[@]}; current_task_index++)); do
    if [[ "${tasks[$current_task_index]}" == "$start_task" || -n "$execute" ]]; then
        ${tasks[$current_task_index]}
        execute=true
    fi
done
