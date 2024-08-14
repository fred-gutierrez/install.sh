#!/bin/bash

# ln -s /media/fred/EHD1/Fred/Code code

# Variables
USER="$(whoami)"

# Basic Installs
sudo apt update

sudo apt install nala

sudo nala install git

# Homebrew - https://www.digitalocean.com/community/tutorials/how-to-install-and-use-homebrew-on-linux
sudo apt install build-essential

curl -fsSL -o brewInstall.sh https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh

/bin/bash brewInstall.sh

echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >>/home/${USER}/.bashrc
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

if command -v brew &>/dev/null; then
  brew install gcc
  brew doctor
  echo ""
  echo "The homebrew installation may have an error, it's alright as long as the script installs gcc, node and neovim"
  echo "The script will continue in 10 seconds..."
  sleep 10
else
  echo ""
  echo "Homebrew installation failed"
  echo "The script will continue in 10 seconds..."
  sleep 10
fi

# Neovim with current config (Lazyvim)
if command -v brew &>/dev/null; then
  brew install node
  brew install neovim
else
  echo ""
  echo "Homebrew not available/installed to install node and neovim"
  echo "The script will continue in 10 seconds..."
  sleep 10
fi

git clone https://github.com/fred-gutierrez/lazyvim-myconfig ~/.config/nvim

# tmux
sudo nala install tmux

git clone https://github.com/fred-gutierrez/tmux-myconfig ~/.config/tmux

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

brew tap arl/arl

brew install gitmux

# ScreenKey (for detecting key input for Videos)
sudo nala install screenkey

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

# Razer Genie (Optional)
sudo gpasswd -a $USER plugdev

# Remove libreoffice (Onlyoffice is my preferred and can be installed by the software manager)
echo ""
echo "This next script is to remove LibreOffice (Which the preferred is Only Office via Software Manager"
sleep 5
sudo nala remove --purge "libreoffice*"

# Redshift and set it automatically
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

# Font manager
sudo nala install font-manager

# --- END --- #
echo "Please remember to restart for some of the installations to work (like Razergenie, QEMU, etc.)"
echo "Things to note:"
echo " - Nerd fonts must be installed manually (https://www.nerdfonts.com/font-downloads)"
echo " - For tmux and it's plugins to work, run: tmux source ~/.config/tmux/tmux.conf - And enter to tmux and do prefix + I to install the plugins - The prefix is CTRL + Space"
