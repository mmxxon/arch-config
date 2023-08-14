#!/bin/bash

# Check if script is run as root
if [[ $EUID -ne 0 ]]; then
    echo "Please run this script as root." 
    exit 1
fi

# Create the xkb configuration file
mkdir -p /etc/X11/xkb/keymap
cat <<EOL > /etc/X11/xkb/keymap/mykbd
xkb_keymap {
    xkb_keycodes  { include "evdev+aliases(qwerty)" };
    xkb_types     { include "complete"  };
    xkb_compat    { include "complete"  };
    xkb_symbols   { include "pc+us+ua:2+ru:3+inet(evdev)+capslock(group_switch)+shift:both_capslock_cancel+group(alt_shift_toggle)" };
    xkb_geometry  { include "pc(pc105)" };
};
EOL

# Create the script to apply the keyboard layout
cat <<EOL > /usr/local/bin/keyboard-switch.sh
#!/bin/bash
setxkbmap -model pc105 -layout us,ua,ru -option 'grp:caps_toggle,grp_led:caps'
xkbcomp /etc/X11/xkb/keymap/mykbd \$DISPLAY 2>/dev/null
EOL
chmod +x /usr/local/bin/keyboard-switch.sh

# Create a udev rule to trigger the script when a keyboard is plugged in
cat <<EOL > /etc/udev/rules.d/99-keyboard.rules
SUBSYSTEM=="input", ACTION=="add", ATTRS{bInterfaceClass}=="03", ATTRS{bInterfaceProtocol}=="01", RUN+="/usr/local/bin/keyboard-switch.sh"
EOL

# Reload udev rules without rebooting
udevadm control --reload-rules && udevadm trigger

# Add the script to .xprofile for it to run at boot
echo "/usr/local/bin/keyboard-switch.sh" >> ~/.xprofile

echo "Setup complete. You may need to restart for all changes to take effect."
