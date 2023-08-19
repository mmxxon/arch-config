#!/usr/bin/env bash

# Check if script is run as root
if [[ $EUID -ne 0 ]]; then
    echo "Please run this script as root." 
    exit 1
fi

# Create the keyboard-settings script at /usr/local/bin
cat << 'EOF' > /usr/local/bin/keyboard-settings.sh
#!/usr/bin/env bash

(
    sleep 1

    DISPLAY=":0.0"
    XAUTHORITY="/home/xon/.Xauthority"
    export DISPLAY XAUTHORITY

    setxkbmap -layout us,ua -option grp:caps_toggle
    xset r rate 300 50
) &
EOF

# Make the script executable
chmod +x /usr/local/bin/keyboard-settings.sh

# Write the udev rule for keyboard detection
echo 'ACTION=="add|remove", SUBSYSTEM=="input", RUN+="/usr/local/bin/keyboard-settings.sh"' > /etc/udev/rules.d/99-external-keyboard.rules

# Reload udev rules
udevadm control --reload-rules
