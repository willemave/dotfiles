#!/usr/bin/env bash
set -euo pipefail

# Ask for the administrator password upfront
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Step 1: Update the OS and Install Xcode Tools
echo "------------------------------"
echo "Updating macOS. If this requires a restart, run the script again."
echo "------------------------------"
sudo softwareupdate -ia

echo "------------------------------"
echo "Installing Xcode Command Line Tools."
echo "------------------------------"
xcode-select --install 2>/dev/null || true

# Accept Xcode license
sudo xcodebuild -license accept 2>/dev/null || true

echo "Done. Xcode Command Line Tools installed."
