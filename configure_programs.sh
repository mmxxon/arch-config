#!/bin/bash

log_file="error.log"

# Create /root/src directory if it doesn't exist
sudo mkdir -p /root/src

install_additional_software() {
  echo "Installing additional desired software..."

  while IFS=, read -r method name comment config_src config_dst build_script
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
          if [[ $build_script ]]; then
            source "../$build_script"
          else
            make > /dev/null && sudo make install > /dev/null
          fi
          cd ..
          ;;
      esac
      if [[ $config_src && $config_dst ]]; then
        if [[ -d $config_src ]]; then
          mkdir -p "$config_dst"
          sudo cp -r "$config_src"/* "$config_dst"/
        else
          sudo cp "$config_src" "$config_dst"
        fi
      fi
    } 2>> $log_file || echo "Error installing $name. See $log_file for details."
  done < "$1"
}

copy_additional_configs() {
  if [[ -z "$1" ]]; then
    return
  fi

  echo "Copying additional configs..."

  while IFS=, read -r program config_src config_dst
  do
    # Skip empty lines
    if [[ -z "$program" ]]; then
      continue
    fi

    echo "[$((++config_count))/$config_total] Installing additional configs for $program"

    {
      if [[ -d $config_src ]]; then
        sudo mkdir -p "$config_dst"
        sudo cp -r "$config_src"/* "$config_dst"/
      else
        sudo cp "$config_src" "$config_dst"
      fi
    } 2>> $log_file || echo "Error copying config for $program. See $log_file for details."
  done < "$1"
}

# Calculate total programs to install
total=$(grep -vcE '^(\s*(#.*)?$)' "$1")
config_total=$(grep -vcE '^(\s*(#.*)?$)' "$2")

# Call the functions
install_additional_software "$1"

# Only call copy_additional_configs if second argument is provided
if [[ ! -z "$2" ]]; then
  configure_programs.sh "$2"
fi
