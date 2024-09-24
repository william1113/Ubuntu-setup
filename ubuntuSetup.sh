#!/bin/bash

# This script should only be used to setup a new ubuntu distro or give William
# his experience anything else fuck off ;)
# time taken to start doing this script 6 years of procrastination



# Update and upgrade system
sudo apt update && sudo apt upgrade -y

# install packages

while IFS=read -r package; do
	sudo apt install -y "$package"
done < "packages.txt"
echo "all packages done installing"

sudo snap install slack discord telegram-desktop

# makes mysql more secure and checks to see if it works
sudo mysql_secure_installation
sudo systemctl start mysql
sudo systemctl stop mysql

# Set environment variables and alias
echo 'export PATH=$PATH:$HOME/go/bin' >> ~/.bashrc
echo 'export PATH=$PATH:/usr/local/bin' >> ~/.bashrc
echo 'alias sl="sl -F -e"' >> ~/.bashrc
source ~/.bashrc

# creates github key
read -p "Email: " email
ssh-keygen -t ed25519 -C "$email" -N "" -f ~/.ssh/id_ed25519
echo "My SSH public key for github is: "
echo ~/.ssh/id_ed25519.pub

# vim install?
read -p "Have you set your git key to github? " answer
if [["${answer,,}" -eq "y"]]; then

	# setup needed modules for vim config
	sudo apt install -y ripgrep fd-find
	sudo ln -s $(which fdfind) /usr/local/bin/fd
	curl -sS https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | bash
	echo 'eval "$(zoxide init bash)"' >> ~/.bashrc
	source .bashrc
	
	# clones nvim config and sets it up
	mkdir ~/.config/nvim
	git clone git@github.com:rafi/vim-config.git ~/.config/nvim
	echo "Run nvim than :checkhealth than :LazyExtras and use 'x' to install extras"
else
	echo "Okay do it yourself than asshole :)"
fi

mkdir dev


# reboot system to make it healthy
read -p "Ready to reboot? " answer
if [[ "${reboot,,}" -eq "y"]]; then
	sudo reboot
else
	echo "Okay do it yourself ass hole"
fi

# whatcha dooooing :)
echo "goodbye have fun in ubuntu jackass ;)"
