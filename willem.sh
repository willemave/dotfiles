#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p "${HOME}/Development"

cp "${SCRIPT_DIR}/.gitconfig" "${HOME}/.gitconfig"
cp "${SCRIPT_DIR}/.gitconfig_alias" "${HOME}/.gitconfig_alias"
cp "${SCRIPT_DIR}/.wgetrc" "${HOME}/.wgetrc"
cp "${SCRIPT_DIR}/.tmux.conf" "${HOME}/.tmux.conf"
cp "${SCRIPT_DIR}/.exports" "${HOME}/.exports"
cp "${SCRIPT_DIR}/.functions" "${HOME}/.functions"
cp "${SCRIPT_DIR}/.mise.toml" "${HOME}/.mise.toml"
mkdir -p "${HOME}/.config"
cp "${SCRIPT_DIR}/starship.toml" "${HOME}/.config/starship.toml"

# Install prezto
if ! [ -e "${HOME}/.zprezto" ]; then
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${HOME}/.zprezto"
fi

# my zsh defaults
mkdir -p "${HOME}/.zsh"
cp "${SCRIPT_DIR}/zsh/completion.zsh" "${HOME}/.zsh/completion.zsh"
cp "${SCRIPT_DIR}/zsh/zshrc" "${HOME}/.zshrc"
cp "${SCRIPT_DIR}/zsh/aliases" "${HOME}/.aliases"
cp "${SCRIPT_DIR}/zsh/zpreztorc" "${HOME}/.zprezto/runcoms/zpreztorc"
ln -sf "${HOME}/.zprezto/runcoms/zpreztorc" "${HOME}/.zpreztorc"
