# ==========================================
# Basic .zlogout Configuration
# ==========================================
# This file is sourced by zsh for login shells upon logout
# It's generally used for cleanup tasks and notifications

# ==========================================
# SSH Agent
# ==========================================
# If you've started ssh-agent during login, you might want to kill it upon logout
# This helps ensure that no stray ssh-agent processes remain
if pgrep -u "$USER" ssh-agent > /dev/null; then
    echo "Killing SSH Agent..."
    killall ssh-agent
fi

# ==========================================
# Cleanup Temporary Files
# ==========================================
# If you have scripts that create temporary files, you might want to clean them up here
# Be very careful with this, as you don't want to accidentally delete important files!
# Example:
# if [[ -d "$HOME/tmp" ]]; then
#     echo "Cleaning up temporary files..."
#     rm -rf "$HOME/tmp/*"
# fi

# ==========================================
# Logout Message
# ==========================================
# Print a goodbye message
echo "Goodbye, $USER. You have successfully logged out."

# There's no need to restart your terminal or run source ~/.zlogout since it's run automatically at logout
