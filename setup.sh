#!/bin/bash
set -e

# --- TARS SYSTEMS CHECK: Ensure Homebrew is in the PATH ---
if [[ ":$PATH:" != *":/opt/homebrew/bin:"* ]]; then
  echo "==> /opt/homebrew/bin not found in PATH. Adding it temporarily."
  export PATH="/opt/homebrew/bin:$PATH"
fi

# Optionally, ensure it's in .zshrc for the future
if ! grep -q '/opt/homebrew/bin' "$HOME/.zshrc" 2>/dev/null; then
  echo 'export PATH="/opt/homebrew/bin:$PATH"' >> "$HOME/.zshrc"
  echo "==> Added Homebrew to PATH in ~/.zshrc"
fi

echo "==> Installing Homebrew (if needed)..."
if ! command -v brew >/dev/null 2>&1; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    export PATH="/opt/homebrew/bin:$PATH"
fi

echo "==> Installing apps from Brewfile..."
brew bundle --file="$HOME/dotfiles/brewfile"

echo "==> Setting up Zsh plugins..."
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# Install Oh My Zsh if not present
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  echo "==> Installing Oh My Zsh..."
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Clone Zsh plugins if not already present
[ -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ] || \
git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions

[ -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ] || \
git clone --depth 1 https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting

[ -d "$ZSH_CUSTOM/plugins/fast-syntax-highlighting" ] || \
git clone --depth 1 https://github.com/zdharma-continuum/fast-syntax-highlighting.git $ZSH_CUSTOM/plugins/fast-syntax-highlighting

[ -d "$ZSH_CUSTOM/plugins/zsh-autocomplete" ] || \
git clone --depth 1 https://github.com/marlonrichert/zsh-autocomplete.git $ZSH_CUSTOM/plugins/zsh-autocomplete

echo "==> Installing Starship prompt..."
if ! command -v starship >/dev/null 2>&1; then
    curl -sS https://starship.rs/install.sh | sh
fi

echo "==> Linking dotfiles..."
ln -sf "$HOME/dotfiles/.zshrc" "$HOME/.zshrc"
mkdir -p "$HOME/.config/vscode"
ln -sf "$HOME/dotfiles/vscode-settings.json" "$HOME/.config/Code/User/settings.json"
#mkdir -p "$HOME/.config"
#ln -sf "$HOME/dotfiles/starship.toml" "$HOME/.config/starship.toml"

echo "==> All done. Please restart your terminal for all changes to take effect."