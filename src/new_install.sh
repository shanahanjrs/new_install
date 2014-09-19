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

# sudo apt-get install -y ubuntu-tweak
# sudo apt-get install -y gnome-shell gnome-tweak-tool gnome-shell-extensions
# sudo apt-get install -y compiz compiz-gnome

# Create backup of /etc/apt/sources.list before modifying
cp /etc/apt/sources.list /etc/apt/sources.list.BACKUP

# Add repo for Spotify, it will be added under 'Add packages'
echo "" >> /etc/apt/sources.list
echo "deb http://repository.spotify.com stable non-free" >> /etc/apt/sources.list
sudo apt-key adv --keyserver keyserver.ubuntu.com:80 --recv-keys 94558F59
sudo apt-get update

# Add packages
echo "Adding packages..."
sudo apt-get install -y vim gvim
sudo apt-get install -y g++
sudo apt-get install -y clang
sudo apt-get install -y wget curl iptables git-core git-flow
sudo apt-get install -y gimp unetbootin
sudo apt-get install -y transmission vlc spotify-client
sudo apt-get install -y bluefish phpmyadmin
echo "Packages added..."

# Add / Setup Git
sudo apt-get install git
git config --global user.name "John Shanahan"
git config --global user.email "shanahan.jrs@gmail.com"
git config --global credential.helper cache
git config --global credential.helper 'cache --timeout=3600'

# Remove packages
echo "Removing unneccesary packages..."
sudo apt-get purge -y whoopsie
sudo apt-get purge -y ubuntuone-client
sudo apt-get purge -y unity-lens-shopping
echo "Unneccesary packages removed..."

# Get dotfiles from github
# cd
# git clone https://github.com/shanahanjrs/dotfiles ~/dotfiles
# cat ~/dotfiles/bashrc > ~/.bashrc
# cat ~/dotfiles/vimrc > ~/.vimrc
# cat ~/dotfiles/inputrc > ~/.inputrc
# cat ~/dotfiles/screenrc > ~/.screenrc
# cat ~/dotfiles/NERDTreeBookmars > ~/.NERDTreeBookmarks

