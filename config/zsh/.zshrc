# ==========================================
# Basic .zshrc Configuration
# ==========================================
# Set name of the theme to load --- if set to "random", it will
# load a random theme each session
ZSH_THEME="agnoster"

# Example aliases
alias ll='ls -l'
alias la='ls -A'

# ==========================================
# Git Aliases
# ==========================================
# Useful aliases for git commands
alias gs='git status'
alias ga='git add'
alias gp='git push'
alias gd='git diff'

# ==========================================
# Zinit Plugin Manager
# ==========================================
# Load Zinit plugin manager. Install it first with:
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zinit/master/doc/install.sh)"
source ~/.zinit/bin/zinit.zsh

# ==========================================
# Syntax Highlighting with Zinit
# ==========================================
# Load the zsh-syntax-highlighting as a plugin from the official
# plugin repository. To install it, use: zinit light zdharma/fast-syntax-highlighting
zinit light zdharma/fast-syntax-highlighting

# ==========================================
# Auto-suggestions with Zinit
# ==========================================
# Load the zsh-autosuggestions plugin with Zinit
# Install it using: zinit load zsh-users/zsh-autosuggestions
zinit load zsh-users/zsh-autosuggestions

# ==========================================
# Other Zinit Plugins
# ==========================================
# Load other plugins with Zinit
# Install them using: zinit load {plugin-owner}/{plugin-repo}
# e.g. zinit load zsh-users/zsh-completions
zinit load zsh-users/zsh-completions

# ==========================================
# Autojump
# ==========================================
# Load the autojump plugin, a faster way to navigate your filesystem.
# Install it with: sudo pacman -S autojump
zinit load wting/autojump

# ==========================================
# Pure Prompt
# ==========================================
# A pretty, minimal and fast ZSH prompt
# It shows git status information and also how long the last command took
# You can install it with: zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
# zinit load sindresorhus/pure
zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit load sindresorhus/pure

# ==========================================
# Nvm (Node Version Manager)
# ==========================================
# Useful for managing multiple Node.js versions
# Install it using: curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
source ~/.nvm/nvm.sh

# ==========================================
# Enhancing cd command
# ==========================================
# Auto pushd. It makes cd behave like pushd, you can use popd to go back to previous directories
setopt AUTO_PUSHD

# ==========================================
# Set up the editor
# ==========================================
# Set vi as a default editor
export EDITOR='vi'

# ==========================================
# Random Quote Generator
# ==========================================
# On each login, print a random quote.
# Note: fortune is not a standard command and needs to be installed.
# On Arch Linux, use: sudo pacman -S fortune-mod
if command -v fortune &> /dev/null
then
    echo $(fortune)
fi

# Remember to restart your terminal or run source ~/.zshrc to reflect these changes
