#!/bin/bash

#---------------------------------------------------------------------#
#-------------------------- new_install.sh ---------------------------#
# Run this after a fresh install of *buntu or any other Debian distro #
#---------------------------------------------------------------------#

#---------------------------------------------------------------------#
#new_install.sh   -- Install and configure a new system in minutes
#                    Copyright (C) 2013, John Shanahan
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
#---------------------------------------------------------------------#


echo "Starting new_install.sh\n
This will tweak your new linux install to your specifications.\n
Beware, this could take a very long time!\n"


#Do updates first
echo "Doing all neccesary updates..."
sudo apt-get -y update
sudo apt-get -y upgrade

# Desktop tweak
echo "Tweaking desktop settings..."

sudo add-apt-repository -y ppa:tualatrix/ppa
sudo add-apt-repository -y ppa:gnome3-team/gnome3
sudo add-apt-repository -y ppa:webupd8team/gnome3
sudo cat>/etc/apt/sources.list.d/google-chrome.list<<END
deb http://dl.google.com/linux/deb/ stable main
END
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add -
sudo apt-get update
sudo apt-get install -y ubuntu-tweak
sudo apt-get install -y gnome-shell gnome-tweak-tool gnome-shell-extensions
sudo apt-get install -y compiz compiz-gnome
echo"Desktop tweaked..."

# Add repo for Spotify, it will be added under 'Add packages'
echo "deb http://repository.spotify.com stable non-free" >> /etc/apt/sources.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 94558F59
sudo apt-get update

# Add packages
echo "Adding packages..."

sudo apt-get install -y vim gvim
sudo apt-get install -y g++
sudo apt-get install -y clang
sudo apt-get install -y wget curl iptables git-core git-flow
sudo apt-get install -y gimp unetbootin
sudo apt-get install -y google-chrome-stable
sudo apt-get install -y transmission pidgin vlc spotify-client spotify-client-gnome-support
sudo apt-get install -y bluefish phpmyadmin
echo "Packages added..."

# Add LAMP server stack
echo "Adding LAMP server stack..."
sudo apt-get install -y php5 libapache2-mod-php5 php5-common php5-gd php5-mdcrypt php5-memcache php5-memcached php5-mysql
sudo apt-get install -y mysql-client mysql-common mysql-server-5.5
sudo apt-get install -y apache2 
echo "LAMP server stack complete..."

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
cd
git clone https://github.com/shanahanjrs/dotfiles ~/dotfiles
cat ~/dotfiles/bashrc > ~/.bashrc
cat ~/dotfiles/vimrc > ~/.vimrc
cat ~/dotfiles/inputrc > ~/.inputrc
cat ~/dotfiles/screenrc > ~/.screenrc
cat ~/dotfiles/NERDTreeBookmars > ~/.NERDTreeBookmarks

