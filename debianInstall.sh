#!/bin/bash

# Variables
USER="$(whoami)"

# Basic Installs
sudo apt update

sudo apt install nala

sudo nala install git

sudo nala install xclip # Copy from the terminal

# Homebrew - https://www.digitalocean.com/community/tutorials/how-to-install-and-use-homebrew-on-linux
sudo apt install build-essential

curl -fsSL -o brewInstall.sh https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh

/bin/bash brewInstall.sh

echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>/home/${USER}/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

brew install gcc
brew doctor
echo "Homebrew was successfully installed!"
sleep 5

# Neovim with current config (Lazyvim)
brew install node@22 neovim fzf

brew link --overwrite --force node@22 #22 is the current LTS and this will set it as the path

git clone https://github.com/fred-gutierrez/lazyvim-myconfig ~/.config/nvim

# tmux
sudo nala install tmux

git clone https://github.com/fred-gutierrez/tmux-myconfig ~/.config/tmux

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

brew tap arl/arl

brew install gitmux

# ScreenKey (for detecting key input for Videos)
read -p "Do you want to install Screenkey - For detecting key input for videos - (yes/no): " screenkey_choice

if [[ "$screenkey_choice" == "yes" || "$screenkey_choice" == "y" ]]; then
  sudo nala install screenkey
else
  echo "Skipping Screenkey installation..."
fi

# Virtual Machine Manager and QEMU
sudo nala install qemu-kvm qemu-system qemu-utils python3 python3-pip libvirt-clients libvirt-daemon-system bridge-utils virtinst libvirt-daemon virt-manager -y

sudo systemctl status libvirtd.service

sudo virsh net-start default

sudo virsh net-autostart default

sudo virsh net-list --all

sudo usermod -aG libvirt $USER
sudo usermod -aG libvirt-qemu $USER
sudo usermod -aG kvm $USER
sudo usermod -aG input $USER
sudo usermod -aG disk $USER

# Razer Genie (Optional) - IMPORTANT: The download links vary on every distro - Check this page: https://software.opensuse.org//download.html?project=hardware%3Arazer&package=razergenie
read -p "Do you want to install Razer Genie (yes/no): " razergenie_choice

if [[ "$razergenie_choice" == "yes" || "$razergenie_choice" == "y" ]]; then
  # These commands are suited to work for a Debian 12 distro
  sudo gpasswd -a $USER plugdev

  echo 'deb http://download.opensuse.org/repositories/hardware:/razer/Debian_12/ /' | sudo tee /etc/apt/sources.list.d/hardware:razer.list

  curl -fsSL https://download.opensuse.org/repositories/hardware:razer/Debian_12/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/hardware_razer.gpg >/dev/null

  sudo apt update

  sudo apt install razergenie
else
  echo "Skipping Razer Genie installation..."
fi

# Remove libreoffice (Onlyoffice is my preferred and can be installed by the software manager)
echo "This next script is to remove LibreOffice (Which the preferred is Only Office via Software Manager"
sleep 5
sudo nala remove --purge "libreoffice*"

# Redshift (and automatically configured)
read -p "Do you want to install Redshift (yes/no): " redshift_choice

if [[ "$redshift_choice" == 'yes' || "$redshift_choice" == 'y' ]]; then
  sudo nala install redshift redshift-gtk

  sudo apt-get install libxcb1-dev libxcb-randr0-dev libx11-dev

  touch ~/.config/redshift.conf #redshift.conf MUST be within the .config file and cannot be within any other folder

  cat <<EOL >~/.config/redshift.conf
[redshift]
temp-day=4000
temp-night=4000
transition=0
gamma=1.0:1.0:1.0
adjustment-method=randr
location-provider=manual

[manual]
lat=0
lon=0

[randr]
screen=0
EOL
else
  echo "Skipping Redshiift installation..."
fi

# Font manager
sudo nala install font-manager

# TLP | For laptops only
read -p "Are you using a laptop? (yes/no): " laptop_choice

if [[ "$laptop_choice" == "yes" || "$laptop_choice" == "y" ]]; then
  # Prompt the user if they want to install TLP
  read -p "Do you want to install TLP for power management? (yes/no): " tlp_choice
  if [[ "$tlp_choice" == "yes" || "$tlp_choice" == "y" ]]; then
    sudo nala install tlp -y
    sudo tlp start
    sudo tlp bat
    echo "TLP installation and configuration completed."
  else
    echo "TLP installation skipped."
    sleep 5
  fi
else
  echo "This script is intended for laptops. TLP installation skipped."
fi

# Install Syncthing - http://127.0.0.1:8384
sudo nala install syncthing

sudo systemctl start syncthing@fred

sudo systemctl enable syncthing@fred

# --- END --- #
echo "Please remember to restart for some of the installations to work (like Razergenie, QEMU, etc.)"
echo "Things to note:"
echo " - TERMINAL: Nerd fonts must be installed manually (https://www.nerdfonts.com/font-downloads)"
echo " - TMUX: For tmux and it's plugins to work, run: tmux source ~/.config/tmux/tmux.conf - And enter to tmux and do prefix + I to install the plugins - The prefix is CTRL + Space"
echo " - SYNCTHING: In order to enter syncthing and set it up, it must be entered from: http://127.0.0.1:8384 - Reference vid: https://youtu.be/PSx-BkMOPF4"
echo " - RAZERGENIE: If razer genie doesn't appear as an app, check if the distro is debian 12, otherwise search for the correct links - If it appears, but doesn't detect any device, then it requires a restart."
echo "VERY IMPORTANT:"
echo " - DRIVERS (Desktop): ALWAYS check for a driver manager app installed (Usually comes installed in Ubuntu and Mint) and install the recommended drivers."
