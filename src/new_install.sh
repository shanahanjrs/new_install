#!/bin/bash
# new_install.sh

# new_install.sh
# Install and configure a new system in minutes
# 2013 - 2017, John Shanahan
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

# --- Functions

function check_root {
    printf "Checking UID...\n"
    if (( EUID != 0 )); then
        echo "You must be root to do this, Please use 'sudo ./new_install.sh'." 1>&2
        exit 10
    else
        printf "User is root ...\n"
    fi
}


function install_linux {
    #Do updates first
    echo "Updating and upgrading packages first ..."
    apt-get -y update
    apt-get -y upgrade

    # Create backup of /etc/apt/sources.list before modifying
    echo "Creating backup of /etc/apt/sources.list ..."
    cp /etc/apt/sources.list /etc/apt/sources.list.BACKUP

    # Add packages
    echo "Adding packages..."
    apt-get install -y vim gvim aptitude ubuntu-restricted-extras
    apt-get install -y python python3 python3-docutils python-dev
    apt-get install -y gcc nmap clang
    apt-get install -y default-jre filezilla openssh openssh-server vsftpd
    apt-get install -y php mcrypt htop sysv-rc-conf nethack
    apt-get install -y transmission irssi build-essential make cmake autoconf
    apt-get install -y wget curl iptables git-core git-flow
    apt-get install -y gimp unetbootin nautilus-dropbox
    apt-get install -y bluefish phpmyadmin git vlc
    echo "Packages added..."

    # Add / Setup Git
    echo "Configuring git"
    git config --global user.name "John Shanahan"
    git config --global user.email "shanahan.jrs@gmail.com"
    git config --global credential.helper cache
    git config --global credential.helper 'cache --timeout=3600'
    git config --global push.default matching


    # Remove packages
    echo "Removing unneccesary packages..."
    apt-get purge -y whoopsie rhythombox evolution
    apt-get purge -y ubuntuone-client thunderbird
    apt-get purge -y unity-lens-shopping shotwell
    echo "Unneccesary packages removed..."

    # Remember to fix sudoers!
    echo "Remember to add 'john	ALL=(ALL:ALL) ALL' to /etc/sudoers"

    # Get dotfiles from github
    echo "Restoring dotfiles ..."
    mkdir ~/prog && cd ~/prog || exit
    git clone https://github.com/shanahanjrs/dotfiles
    cd dotfiles && ./copyfiles.sh
}

function install_macos {
    # Get brew
    usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    # Brew packages to install
    packages1="zsh oh-my-zsh gcc htop-osx libtool libtorrent mcrypt openssl python python3 x264 erlang irssi shellcheck haskell-stack"
    packages2="glib neo4j php56 php56-mcrypt phpunit composer rtorrent go libtiff libtomath numpy wget elasticsearch logstash kibana"
    brewpackages="${packages1} ${packages2}"

    # Install brew packages
    brew install "${brewpackages}"

    # Add / Setup Git
    echo "Configuring git"
    git config --global user.name "John Shanahan"
    git config --global user.email "shanahan.jrs@gmail.com"
    git config --global credential.helper cache
    git config --global credential.helper 'cache --timeout=3600'
    git config --global push.default matching

    # Get dotfiles from github
    echo "Restoring dotfiles ..."
    mkdir ~/prog && cd ~/prog || exit
    git clone https://github.com/shanahanjrs/dotfiles
    cd dotfiles && ./copyfiles.sh
}

# --- Main

echo "=============="
echo "new_install.sh"
echo "=============="

# Privs
check_root

# Run
case "$(uname)" in

    "Linux")
        install_linux
        ;;
    "Darwin")
        install_macos
        ;;
    *)
        echo 'Case statement hit default...'
        ;;
 
esac

echo 'Done...'
