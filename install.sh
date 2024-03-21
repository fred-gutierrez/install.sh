#!/bin/bash

# Variables
USER="$(whoami)"

# Basic Installs
sudo apt update

# sudo apt install nala
#
# sudo nala install git

# Install homebrew - https://www.digitalocean.com/community/tutorials/how-to-install-and-use-homebrew-on-linux
# sudo apt install build-essential

curl -fsSL -o brewInstall.sh https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh

/bin/bash brewInstall.sh

if command -v brew &>/dev/null; then
	echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>/home/${USER}/.bashrc
	eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

	brew doctor
else
	echo "Homebrew installation failed"
fi

# Install Neovim with current config (Lazyvim)
if command -v brew &>/dev/null; then
	brew install node
	brew install neovim
else
	echo "Homebrew not available/installed to install node and neovim"
fi

git clone https://github.com/fred-gutierrez/lazyvim-myconfig ~/.config/nvim

# Install tmux
sudo nala install tmux

git clone https://github.com/fred-gutierrez/tmux-myconfig ~/.config/tmux

# Install Virtual Machine Manager and QEMU

# Install Razer Genie (Optional)

# Install Solaar (Optional)

# Remove shiet libreoffice and install onlyoffice
sudo nala remove --purge "libreoffice*"
