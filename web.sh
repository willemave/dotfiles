#!/usr/bin/env bash
set -euo pipefail

echo "------------------------------"
echo "Setting up development runtimes via mise."
echo "------------------------------"

# Ensure mise is available
if ! command -v mise &>/dev/null; then
  echo "Error: mise is not installed. Run install.sh first."
  exit 1
fi

mise use --global node@lts
mise use --global python@latest

echo "Done. Node (LTS) and Python (latest) installed via mise."
