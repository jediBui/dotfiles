# -----------------------------
# 1. PATH SETUP
# -----------------------------

export PATH="/opt/homebrew/bin:$PATH"
export PATH="$PATH:/Users/vu/.local/bin"  # Added by pipx

# -----------------------------
# 2. OH-MY-ZSH SETUP
# -----------------------------

export ZSH="$HOME/.oh-my-zsh"

plugins=(
  git
  colorize
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# -----------------------------
# 3. SHELL CUSTOMIZATIONS
# -----------------------------

eval "$(starship init zsh)"

# -----------------------------
# 4. ALIASES
# -----------------------------

alias schwab='op read op://personal/schwab/password | pbcopy'
alias icloud='cd ~/Library/Mobile\ Documents/com~apple~CloudDocs'

# -----------------------------
# 5. STARTUP COMMANDS
# -----------------------------

fastfetch