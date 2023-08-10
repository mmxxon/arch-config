# ==========================================
# Basic .zlogin Configuration
# ==========================================
# This file is sourced by zsh for login shells after reading .zshrc
# Useful for commands that need to be executed at login after .zshrc has been executed

# ==========================================
# MotD (Message of the Day)
# ==========================================
# Print a welcome message at login
echo "Welcome, $USER. Today is $(date +"%A, %B %d, %Y")."

# ==========================================
# Check for updates
# ==========================================
# On Arch Linux, use checkupdates command to see if there are any pending updates
# checkupdates is part of pacman-contrib package. Install it with: sudo pacman -S pacman-contrib
if command -v checkupdates &> /dev/null
then
    echo "Checking for updates..."
    echo "$(checkupdates)"
fi

# ==========================================
# Sessions
# ==========================================
# For screen and tmux users, automatically re-attach to a session, or create one if none exist
# Uncomment the section that applies to your system

# For GNU Screen:
# if command -v screen &> /dev/null
# then
#     [[ $STY ]] || exec screen -xRR
# fi

# For Tmux:
# if command -v tmux &> /dev/null
# then
#     [[ $TMUX ]] || exec tmux new-session -A -s main
# fi

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

# Remember to restart your terminal or run source ~/.zlogin to reflect these changes
