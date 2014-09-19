#!/bin/bash
# new_install.sh

# new_install.sh   -- Install and configure a new system in minutes
#                     Copyright (C) 2013, John Shanahan
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.


echo "Starting new_install.sh\n
This will tweak your new linux install to your specifications ...\n"


#Do updates first
echo "Updating and upgrading packages first ..."
sudo apt-get -y update
sudo apt-get -y upgrade

# Create backup of /etc/apt/sources.list before modifying
echo "Creating backup of /etc/apt/sources.list ..."
sudo cp /etc/apt/sources.list /etc/apt/sources.list.BACKUP

# Add repo for Spotify, it will be added under 'Add packages'
sudo echo "" >> /etc/apt/sources.list
sudo echo "deb http://repository.spotify.com stable non-free" >> /etc/apt/sources.list
sudo apt-key adv --keyserver keyserver.ubuntu.com:80 --recv-keys 94558F59
sudo apt-get update

# Add packages
echo "Adding packages..."
sudo apt-get install -y vim gvim aptitude ubuntu-restricted-extras
sudo apt-get install -y python python3 python3-docutils python-dev
sudo apt-get install -y gcc nmap clang
sudo apt-get install -y default-jre filezilla openssh openssh-server vsftpd
sudo apt-get install -y php mcrypt htop sysv-rc-conf nethack
sudo apt-get install -y transmission irssi build-essential make cmake autoconf
sudo apt-get install -y wget curl iptables git-core git-flow
sudo apt-get install -y gimp unetbootin nautilus-dropbox
sudo apt-get install -y transmission vlc spotify-client
sudo apt-get install -y bluefish phpmyadmin git
echo "Packages added..."

# Add / Setup Git
echo "Configuring git"
git config --global user.name "John Shanahan"
git config --global user.email "shanahan.jrs@gmail.com"
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=3600'

# Remove packages
echo "Removing unneccesary packages..."
sudo apt-get purge -y whoopsie rhythombox evolution
sudo apt-get purge -y ubuntuone-client thunderbird
sudo apt-get purge -y unity-lens-shopping shotwell
echo "Unneccesary packages removed..."

# Get dotfiles from github
echo "Restoring dotfiles ..."
cd
sudo git clone https://github.com/shanahanjrs/dotfiles ~/dotfiles
sudo cat ~/dotfiles/bashrc > ~/.bashrc
sudo cat ~/dotfiles/vimrc > ~/.vimrc
sudo cat ~/dotfiles/inputrc > ~/.inputrc
sudo cat ~/dotfiles/screenrc > ~/.screenrc
sudo cat ~/dotfiles/NERDTreeBookmars > ~/.NERDTreeBookmarks

