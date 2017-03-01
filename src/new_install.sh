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

function linux_or_osx {
    uname=$(uname)
    if [[ "${uname}" == "Linux" ]]; then
        export os="Linux"
    elif [[ "${uname}" == "Darwin" ]]; then
        export os="MacOS"
    fi
}


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
    sudo apt-get -y update
    sudo apt-get -y upgrade

    # Create backup of /etc/apt/sources.list before modifying
    echo "Creating backup of /etc/apt/sources.list ..."
    sudo cp /etc/apt/sources.list /etc/apt/sources.list.BACKUP

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
    sudo apt-get install -y transmission vlc
    sudo apt-get install -y bluefish phpmyadmin git
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
    sudo apt-get purge -y whoopsie rhythombox evolution
    sudo apt-get purge -y ubuntuone-client thunderbird
    sudo apt-get purge -y unity-lens-shopping shotwell
    echo "Unneccesary packages removed..."

    # Remember to fix sudoers!
    echo "Remember to add 'john	ALL=(ALL:ALL) ALL' to /etc/sudoers"

    # Get dotfiles from github
    echo "Restoring dotfiles ..."
    cd
    sudo git clone https://github.com/shanahanjrs/dotfiles ~/dotfiles
    sudo cat ~/dotfiles/bashrc > ~/.bashrc
    sudo cat ~/dotfiles/vimrc > ~/.vimrc
    sudo cat ~/dotfiles/inputrc > ~/.inputrc
    sudo cat ~/dotfiles/screenrc > ~/.screenrc
    sudo cat ~/dotfiles/NERDTreeBookmars > ~/.NERDTreeBookmarks
}

function install_osx {
    # Get brew
    usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    brogue        ffmpeg        glib        isl        libmpc        libvo-aacenc    neo4j        php56        redis        tpp        zlib
    cloog        fish        gmp        jasper        libpng        libxml2        neovim        php56-mcrypt    rtorrent    unixodbc    zsh
    cmake        fontconfig    go        jpeg        libtiff        little-cms2    node        phpdocumentor    scons        webp
    composer    freetype    haskell-stack    jrnl        libtommath    macvim        numpy        phpunit        shellcheck    wget

    # Brew packages to install
    packages1="zsh oh-my-zsh gcc htop-osx libtool libtorrent mcrypt openssl python python3 x264 erlang irssi shellcheck haskell-stack"
    packages2="glib neo4j php56 php56-mcrypt phpunit composer rtorrent go libtiff libtomath numpy wget"
    brewpackages="${packages1} ${packages2}"

    # Install brew packages
    brew install "${brewpackages}"

}

# --- Main

echo "=============="
echo "new_install.sh"
echo "=============="

# Privs
check_root

# Get OS
linux_or_osx

# Run
case "${os}" in

    "Linux")
        # Blah
        ;;
    "MacOS")
        # Blah but on a mac
        ;;
    *)
        # Blah but somewhere else
        ;;
 
esac

