#!/usr/bin/env bash
set -euo pipefail

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Detect architecture
if [[ "$(uname -m)" == "arm64" ]]; then
  HOMEBREW_PREFIX="/opt/homebrew"
else
  HOMEBREW_PREFIX="/usr/local"
fi

# Install Homebrew if not present
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"
fi

# Make sure we're using the latest Homebrew
brew update
brew upgrade

# Install everything from Brewfile
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
brew bundle --file="$SCRIPT_DIR/Brewfile"

# Set up fzf keybindings
"$(brew --prefix)/opt/fzf/install" --key-bindings --completion --no-update-rc --no-bash --no-fish

# Add Homebrew zsh to allowed shells and set as default
ZSH_PATH="$HOMEBREW_PREFIX/bin/zsh"
if ! grep -qF "$ZSH_PATH" /etc/shells; then
  echo "Adding $ZSH_PATH to /etc/shells"
  echo "$ZSH_PATH" | sudo tee -a /etc/shells
fi

if [[ "$SHELL" != "$ZSH_PATH" ]]; then
  echo "Changing default shell to $ZSH_PATH"
  chsh -s "$ZSH_PATH"
fi

# Clean up
brew cleanup

echo "Done. Homebrew and packages installed successfully."
