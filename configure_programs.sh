#!/bin/bash
# configure_programs.sh

log_file="error.log"
software_list="software_list.csv"
config_list="config_list.csv"

# Create /root/src directory if it doesn't exist
sudo mkdir -p /root/src

install_additional_software() {
  echo "Installing additional desired software..."

  while IFS=, read -r method name comment has_config
  do
    # Skip empty lines and comment lines
    if [[ -z "$method" || "$method" == \#* ]]; then
      continue
    fi

    echo "[$((++count))/$total] Installing $name"
    if [[ $comment ]]; then
      echo " - $comment"
    fi

    {
      case $method in
        P) sudo pacman -Sy --noconfirm "$name" > /dev/null ;;
        A) yay -Sy --noconfirm "$name" > /dev/null ;;
        G) 
          cd /root/src
          sudo git clone "$name"
          cd "$(basename "$name")"
          make > /dev/null && sudo make install > /dev/null
          cd ..
          ;;
      esac
    } 2>> $log_file || echo "Error installing $name. See $log_file for details."

    # If the program has a config, copy it
    if [[ $has_config == "+" ]]; then
      echo "Copying config for $name"
      copy_config "$name"
    fi
  done < "$software_list"
}

copy_config() {
  config_total=$(grep -c "^$1," "$config_list")
  # Find the line in the config file for this program
  config_count=0
  while IFS=, read -r program config_src config_dst
  do
    if [[ "$program" == "$1" ]]; then
      echo "[$((++config_count))/$config_total] Installing additional configs for $program"
      {
        sudo mkdir -p "$config_dst"
        sudo cp -r "$config_src"/* "$config_dst"/
      } 2>> $log_file || echo "Error copying config for $program. See $log_file for details."
    fi
  done < "$config_list"
}

# Calculate total programs to install
total=$(grep -vcE '^(\s*(#.*)?$)' "$software_list")

# Call the functions
install_additional_software
