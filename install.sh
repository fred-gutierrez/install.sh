#!/bin/bash

# Re-usable variables
USER="$(whoami)"

# Basic Installs
sudo apt update

sudo apt install nala

sudo nala install git

# Install homebrew - https://www.digitalocean.com/community/tutorials/how-to-install-and-use-homebrew-on-linux
sudo apt install build-essential

# curl -fsSL -o brewInstall.sh https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
#
# /bin/bash brewInstall.sh

if command -v brew &>/dev/null; then
	echo 'eval "$(/home/${USER}/.linuxbrew/bin/brew shellenv)"' >>/home/${USER}/.profile
	eval "$(/home/${USER}/.linuxbrew/bin/brew shellenv)"

	brew doctor
	brew install node
	brew install neovim
else
	echo "Homebrew installation failed"
fi

# Install Neovim with current config = LazyVim
sudo
