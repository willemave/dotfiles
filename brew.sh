#!/usr/bin/env bash

# Install command-line tools using Homebrew.

# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Install GNU core utilities (those that come with OS X are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
sudo ln -s /usr/local/bin/gsha256sum /usr/local/bin/sha256sum

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed --with-default-names
# Install Bash 4.
brew install zsh zsh-completions zsh-syntax-highlighting zsh-autosuggestions



brew tap homebrew/versions

# We installed the new shell, now we have to activate it
echo "Adding the newly installed shell to the list of allowed shells"
# Prompts for password
sudo bash -c 'echo /usr/local/bin/zsh >> /etc/shells'
# Change to the new shell, prompts for password
chsh -s /usr/local/bin/zsh

brew install rg

# Install `wget` with IRI support.
brew install wget --with-iri

# Install Python
brew install python3
brew cask install java
curl -sSL https://get.rvm.io | bash -s stable
rvm install 2.6

# Install font tools.
brew install sfnt2woff
brew install sfnt2woff-zopfli
brew install woff2

# Lxml and Libxslt
brew install libxml2
brew install libxslt
brew link libxml2 --force
brew link libxslt --force

# Core casks
brew cask install alfred
brew cask install iterm2
brew cask install sublime-text
brew cask install macbreakz
brew cask install ngrok

# magent
brew install mas
mas install 441258766

# Xcode. Will take forever to download, yes. Not needed by everyone.
mas install 497799835

# Spotify
brew cask install spotify

brew cask install whatsapp

# Remove outdated versions from the cellar.
brew cleanup
