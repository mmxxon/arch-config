# ==========================================
# Basic .zprofile Configuration
# ==========================================
# This file runs at login, it's the best place to define environment variables
# You should not place commands here that need to have a terminal attached

# ==========================================
# PATH modification
# ==========================================
# Add your custom bin directory to PATH
# This allows you to run scripts and binaries that you have placed in your local bin directory
export PATH=$HOME/bin:$PATH

# ==========================================
# Environment Variables
# ==========================================
# Set environment variables used by your system or applications
# For example, if you have Java installed, you can set JAVA_HOME here
# Remember to adjust the value based on your actual Java installation path
# export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk

# You might want to configure npm to install global packages in your home directory to avoid permission issues
# export NPM_CONFIG_PREFIX=~/.npm-global

# ==========================================
# Locale settings
# ==========================================
# Uncomment to set the system locale, this affects system language and regional settings like date and currency format
# Be sure to generate your chosen locale first by running locale-gen
# Example for United States:
# export LANG=en_US.UTF-8
# export LC_ALL=en_US.UTF-8

# ==========================================
# XDG Base Directory specification
# ==========================================
# XDG Base Directory is a standard for defining common directories for various files like configuration files and cache files.
# Uncomment the lines below to set these directories.
# export XDG_CONFIG_HOME="$HOME/.config"
# export XDG_DATA_HOME="$HOME/.local/share"
# export XDG_CACHE_HOME="$HOME/.cache"

# ==========================================
# SSH Agent
# ==========================================
# If you are using ssh a lot, you might want to start the ssh-agent automatically on login
# Remember to use ssh-add to add your private keys to the agent
if ! pgrep -u "$USER" ssh-agent > /dev/null; then
    ssh-agent > "$HOME/.ssh/agent.env"
fi

if [[ -f "$HOME/.ssh/agent.env" ]]; then
   . "$HOME/.ssh/agent.env" > /dev/null
fi

# ==========================================
# Editor configuration
# ==========================================
# Set the default editor (uncomment the one you want)
# export EDITOR=nano
# export EDITOR=vi
# export EDITOR=emacs

# Remember to restart your terminal or run source ~/.zprofile to reflect these changes
