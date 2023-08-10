# ==========================================
# Basic .zshenv Configuration
# ==========================================
# This file is the first one sourced by zsh in all kinds of shells
# It's a good place to set environment variables that need to be available in all types of shells

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
# Editor configuration
# ==========================================
# Set the default editor (uncomment the one you want)
# export EDITOR=nano
# export EDITOR=vi
# export EDITOR=emacs

# ==========================================
# Manpath Configuration
# ==========================================
# Manpath is the search path for man pages. If you installed man pages in non-standard locations, add those here
# export MANPATH="/usr/local/man:/usr/local/share/man:/usr/share/man"

# Remember to restart your terminal or run source ~/.zshenv to reflect these changes
