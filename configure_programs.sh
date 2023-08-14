#!/bin/bash
# configure_programs.sh

log_file="error.log"
software_list="software_list.csv"

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
    } 2>> $log_file || echo "Error installing $name. See $log_file for details." | tee -a $log_file
  done < "$software_list"
}

# Calculate total programs to install
total=$(grep -vcE '^(\s*(#.*)?$)' "$software_list")

# Call the functions
install_additional_software
