#!/bin/bash
# Kiril's Initial Setup Script for Debian-based Linux Distributions
# Define variables
ver=0.041
vername="letmein" 
# Date
time=$(date +"%Y-%m-%d-%X")
bold=$(tput bold)
normal=$(tput sgr0)
LSB=/usr/bin/lsb_release
IFS=$'\n'
# title=./${bold}kiss${normal}_$ver
echo 'alias kiss="bash $pwd/kiss.sh"' >> /home/$USER/.bashrc/ 
sudo apt-get install make autoconf --no-install-recommends
menus() {
    clear
#	write_header " $title/menu "	
    title
    echo "(1) inst-prog - install programs and utilities"
    echo "(2) ku - kiss utilities"
    echo "(3) upgrade - check for package updates and/or kernel upgrades"
    echo "(4) about - information about this script"
    echo "(5) exit"
	echo "-------------------------------------"
    echo "Github: https://github.com/kiril-u/KISS"
	echo "-------------------------------------"
    }
title() {
	echo "-------------------------------------"
    echo " _    _            Kiril's"
    echo '| | _(_)___ ___    Initial'
    echo '| |/ / / __/ __|   Setup'
    echo '|   <| \__ \__ \   Script'
    echo "|_|\_\_|___/___/   $ver"
	echo "-------------------------------------"
    }

inst-prog() {
    clear
#	write_header " $title/menu/install-programs "	
    title
    echo "${bold}Package Managers${normal}"
        echo "- snap - enables Snap"
        echo "- flatpak - enables Flatpak"
    echo "${bold}Network Security${normal}"
        echo "- f2b - Fail2ban [autoconfigured]"
        echo "- ufw - Uncomplicated Firewall [autoconfigured]"
        echo "  - ufw-optional - block some ports used by microsoft systems"
    echo "${bold}Text Editors${normal}"
        echo "- vim - text editor"
        echo "- gedit - gnome text editor"
        echo "- kate - Kate editor"
    echo "${bold}Screenshooting${normal}"
        echo "- fshot - Flameshot"
        echo "- kspec - KDE Spectacle"
    echo "${bold}Partition Managers and Image Burners${normal}"
        echo "- gparted - Gnome partition editor" 
        echo "- gdu - Gnome disk utility"
        echo "- sdc - Startup Disk Creator"
    echo "${bold}Browsers${normal}"
        echo "- brave - Brave Browser"
        echo "- opera - Opera Browser"
        echo "- vivaldi - Vivaldi Browser"
    echo "${bold}PDF Readers${normal}"
        echo "- evince - Evince"
        echo "- zathura - Zathura"
     echo "${bold}Terminal Emulators${normal}"   
        echo "- tx - Tilix Terminal"
        echo "- d-ter - Deepin Terminal" 
    echo "${bold}Other essential programs: (for me)${normal}"
        echo "- 1pass - 1Password"
        #echo "- dbox - Dropbox"
        echo "- zoom - Zoom"
        echo "- wireshark - Wireshark"
        echo "- 4k - 4kvideodownloader 4.13.5-1"
        echo "- mend - Mendeley Desktop"
        echo "- times - Timeshift backup tool"
        echo "- tlp - saving laptop battery power"
        echo "- rhybox - Rhythmbox"
        echo "- mpv - mpv Media Player"
        echo "- ttf - TrueType Fonts (Microsoft)"
        echo "- tag - Easytag ID3 tags editor"
        echo "- signal - Signal application for desktop"
     echo "${bold}CLI Tools and Utilities${normal}"           
        echo "- ranger - Ranger file manager"
        #echo "- cmus - C* Music Player"
        #echo "- cmusfm - Scrobbler for cmus"
        echo "- iftop - Netowrk monitoring tool"
        echo "- newsboat - RSS feed tool"
        echo "- mpsyt - mps-youtube (using youtube in terminal"
    read_options
            }
read_options(){
	local choice
	read -e -p "> " choice
	case $choice in
# -- main menu
	inst-prog) inst-prog ;;
	1) inst-prog ;;
	in) inst-prog ;;
	install-programs) inst-prog ;;
	inst-prog) inst-prog ;;
	ku) kiss-util ;;
	2) kiss-util ;;
	kiss-utilities) kiss-util ;;
	3) upgrade ;;
	upgrade) upgrade ;;
	up) upgrade ;;
	4) kissinfo ;;
	about) kissinfo ;;
	ab) kissinfo ;;
	5) exit 0 ;;
	exit) exit 0 ;;
	ex) exit 0 ;;
# -- install-programs
    snap) snap_enabler ;;
    flatapk) flatapk ;;
    f2b) f2b ;;
    ufw) ufw ;;
    ufw-optional) ufw-optional ;;
    vim) vim ;;
    gedit) gedit ;;
    fshot) flameshot ;;
    flameshot) flameshot ;;
    kspec) kde-spectacle ;;
    gparted) gparted ;;
    gdu) gnomedu ;;
    sdc) usbcg ;;
    brave) brave ;;
    brave-fix) bravefix ;;
    opera) opera ;;
    operasnap) operasnap ;;
    vivaldi) vivaldi ;;
    1pass) onepassword ;;
    #dbox) dropbox ;;
    #dropbox) dropbox ;;
    #dbox-fix) wget https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2020.03.04_amd64.deb; sudo dpkg -i dropbox_2020.03.04_amd64.deb; sudo rm dropbox_2020.03.04_amd64; pause ;;
    #dropbox-fix) wget https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2020.03.04_amd64.deb; sudo dpkg -i dropbox_2020.03.04_amd64.deb; sudo rm dropbox_2020.03.04_amd64; pause ;;
    zoom) zoom ;;
    wireshark) wireshark ;;
    4k) fourkdownloader ;;
    mend) mendeley ;;
    times) timeshift ;;
    d-ter) deepin-terminal ;;
    evince) sudo apt-get -y install evince ; return ;;
    zathura) sudo apt-get -y install zathura ; return ;;
    tx) tilix ;;
    tlp) tlp ;;
    rhybox) rhybox ;;
    kwrite) kwrite ;;
    newsboat) newsboat ;;
    iftop) iftop ;;
    ranger) ranger ;;
    #cmus) cmus ;;
    #cmusfm) cmusfm ;;
    mpv) mpv ;;
    mpsyt) mpsyt ;;
    kate) kate ;;
    ttf) sudo apt-get -y install ttf-mscorefonts-installer; pause ;;
    tag) sudo apt-get -y install easytag; pause ;;
    signal) sudo apt-get -y install signal-desktop; pause ;;
# -- kiss-utilities
    ipt) echo "Try: 'ipt-h'"; pause ;;
    ipt-b) banip ;;
    ipt-u) unbanip ;;
    ipt-c) checkip ;;
    ipt-l) blacklist ;;
    ipt-h) ipthelp ;;
    nets) net_stat ;;
    neti) net_info ;;
    sysinfo) sysinfo_menu ;;
    who) user_info "who" ;;
    last) user_info "last" ;;
    mem) mem_info ;;
    insk) install_kirilsprograms ;;
# -- about
    readme) clear; title; sed -n 1,8p READ.md; pause ;;
    changelog) clear; title; sed -n 86,116p READ.md; pause ;;
    back) return ;;
    *) return ;;
	esac
	}
kiss-util() {
    clear
    #write_header " $title/menu/kiss-utilities "	
    title
    echo "- iftop - Network Monitoring Tool"
    echo "- ipt - IP-tools (howto:'ipt-< >'); For help type ipt-h"
    echo "- nets - Network statistics"
	echo "- neti - Network routing, hosts, DNS, and interface traffic information"
	echo "- sysinfo - System Information (Neofetch and some other stuff)"
    echo "- insk - Install a pre-determined collection of programs"
    read_options
    }
write_header(){
    Display header message
	local h="$@"
	echo "-------------------------------------"
	echo "${h}"
	echo "-------------------------------------"
    }

kissinfo() {
    clear
	#write_header " $title/menu/about "
    title
    echo
    echo "Kirils Initial Setup Script for Debian and Debian-based Linux Distributions version $ver"
    echo "The script was tested on Linux Mint (19-20.1), Ubuntu (20.04-20.10), Kubuntu and Debian 10"
    echo 
    echo "${bold}Menu Navigation:${normal}"
    echo "To navigate quickly in the main menu, users may type the first two letters of each section" 
    echo "(for instance, to access the program installation section (inst-prog) you may type 'in', or '1'."
    echo "Type 'back' anywhere to return to the main menu (or just leave it blank and press [ENTER]"
    echo "${bold}Information:${normal}"
    echo "changelog - Read the changelog"
    echo "readme - read some information about this script"
    read_options
    }
pause() {
	local message="$@"
	[ -z $message ] && message="Press [Enter] key to continue..."
	read -p "$message" readEnterKey
    }
snap_enabler() {
    # Enabling snap/snapd package manager
    sudo rm -q /etc/apt/preferences.d/nosnap.pref
    sudo apt-get -q update
    sudo apt-get -y install snapd
    sudo snap -y install snap-store
    echo "Snap package manager is enabled. You should restart your machine, or log out and in again to complete the installation. Would you like to reboot now? [Y/n]"
    local choice
    read -e -p "> " choice
    case $choice in
    y) sudo reboot ;;
    Y) sudo reboot ;;  
    yes) sudo reboot ;;  
    n) pause ;;
    N) pause ;; 
    no) pause ;; 
    esac
    }
upgrade() {
    # update distribution
    sudo apt -q update 
    sudo apt -yy dist-upgrade 
    sudo apt -yy autoremove
    pause
    }
### ikp
install_kirilsprograms() {
    echo "List of programs included in this bundle:"
    echo "- Fail2ban"
    echo "- UFW"
    echo "- Vim"
    echo "- gedit"
    echo "- Flameshot"    
    echo "- Gparted"
    echo "- Gnome disk utility"
    echo "- Startup Disk Creator"
    echo "- Brave Browser"
    echo "- Evince"
    echo "- Tilix"
    echo "- 1Password"
    echo "- Zoom"
    echo "- 4kvideodownloader"
    echo "- Mendeley Desktop"
    echo "- Timeshift"
    echo "- Rhythmbox"
    echo "- TrueType Fonts"
    echo "- Ranger"
    echo "- iftop"
    echo "- newsboat"    
    local choice
    read -e -p "Would you like to install these programs? [Y/n]" choice
	case $choice in
	n) echo "Aborting..."; sleep 1; return ;;
	no) echo "Aborting..."; sleep 1; return ;;
	N) echo "Aborting..."; sleep 1; return ;;
	y) ikp ;;
	yes) ikp ;;
	Y) ikp ;;
	esac
	}
ikp() {
    onepassword 
    4kdownloader 
    mendeley 
    zoom 
    brave 
    fshot 
    ufw
    ufw-optional
    f2b
    vim 
    gedit
    timeshift
    tilix
    gparted
    sdc
    rhybox
    ranger
    sudo apt -yy install neofetch iftop evince figlet signal-desktop --no-install-recommends
    echo "Done." 
    pause
    }
### programs
rhybox() {
    sudo add-apt-repository ppa:vascofalves/gnome-backports
    sudo apt-get update
    sudo apt-get -y install rhythmbox --no-install-recommends
    pause
    }

kate() {
    sudo apt-get -y git cmake
    git clone https://invent.kde.org/utilities/kate.git
    cd kate
    mkdir build
    cd build
    cmake .. -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=~/kde/usr \
  -DCMAKE_PREFIX_PATH=~/kde/usr
    make
    make install
    cd ~/kde/kate
    git pull --rebase
    pause
    }

mpsyt() {
    #echo 'export PY_USER_BIN=$(python -c 'import site; print(site.USER_BASE + "/bin")')' >> ~/.bashrc
    #echo 'export PATH=$PY_USER_BIN:$PATH' >> ~/.bashrc
    sudo apt-get -y install python3-pip --no-install-recommends
    pip3 install --user mps-youtube
    pip3 install --user youtube-dl
    pip3 install --user youtube-dl --upgrade
    pip3 install --user dbus-python pygobject
    sudo pip3 install mps-youtube --upgrade
    pause
    }
cmus() {
    # sudo add-apt-repository ppa:jmuc/cmus
    sudo apt-get update
    sudo apt-get -y install cmus --no-install-recommends
    read -e -p "Would you like to install cmusfm (audio scrobbler for cmus)? [Y/n]" choice
	case $choice in
        y) cmusfm ;;
        Y) cmusfm ;;
        yes) cmusfm ;;
        n) return ;;
        N) return ;;
        no) return ;;
    esac
    }
cmusfm() {
    read -e -p "Have you installed cmus? [Y/n]" choice
    case $choice in
        y) sudo apt-get -y install libnotify-cil-dev libnotify0.4-cil libcurl4-gnutls-dev libcurl4 git; git clone https://github.com/Arkq/cmusfm; cd cmusfm; autoreconf --install; mkdir build && cd build; ../configure --enable-libnotify; make && make install; cmusfm init; echo "make sure to open cmus and type ':set status_display_program=cmusfm'"; pause ;;
        Y) sudo apt-get -y install libnotify-cil-dev libnotify0.4-cil libcurl4-gnutls-dev libcurl4 git; git clone https://github.com/Arkq/cmusfm; cd cmusfm; autoreconf --install; mkdir build && cd build; ../configure --enable-libnotify; make && make install; cmusfm init; echo "make sure to open cmus and type ':set status_display_program=cmusfm'"; pause ;;
        yes) sudo apt-get -y install libnotify-cil-dev libnotify0.4-cil libcurl4-gnutls-dev libcurl4 git; git clone https://github.com/Arkq/cmusfm; cd cmusfm; autoreconf --install; mkdir build && cd build; ../configure --enable-libnotify; make && make install; cmusfm init; echo "make sure to open cmus and type ':set status_display_program=cmusfm'"; pause ;;
        n) echo "Since cmus is a dependency of cmusfm, this installation is aborting.."; pause ;; 
        N) echo "Since cmus is a dependency of cmusfm, this installation is aborting.."; pause ;;
        no) echo "Since cmus is a dependency of cmusfm, this installation is aborting.."; pause ;;
    esac
    }
newsboat () {
    # git clone git://github.com/newsboat/newsboat.git
    #dependencies
    sudo apt-get -y install newsboat --no-install-recommends
    pause
        }
mpv() {
    sudo apt-get -y install mpv --no-install-recommends
    pause
    }
ranger() {
    # main installation
    sudo apt-get -y install ranger --no-install-recommends
    echo "For configuration, check the files in ranger/config/ or copy the default config to ~/.config/ranger with ranger --copy-config"
    pause
    }
tilix() {
    # dependencies
    sudo apt-get -y install tilix --no-install-recommends
    pause
    }
tlp() {
    echo 'deb http://ftp.debian.org/debian buster-backports main' >> /etc/apt/sources.list
    sudo apt -y update
    sudo apt-get -y install tlp tlp-rdw
    pause
    }
timeshift() {
    sudo apt-add-repository -y ppa:teejee2008/ppa
    sudo apt-get update
    sudo apt-get install timeshift
    sudo chmod +x timeshift-latest-amd64.run
    sh ./timeshift-latest-amd64.run
    pause
    }
    
deepin-terminal() {
    sudo add-apt-repository ppa:noobslab/deepin-sc
    sudo apt-get update
    sudo apt-get -y install deepin-terminal --no-install-recommends
    pause
    }
    
kde-spectacle() {
    sudo apt-get update -y
    sudo apt-get install -y kde-spectacle --no-install-recommends
    pause
    }
gnomedu() {
    sudo apt-get -y install -y gnome-disk-utility gnome-disk-image-mounter gsd-disk-utility-notify --no-install-recommends
    pause
    }
usbcg() {
    sudo apt-get -y install usb-creator-gtk --no-install-recommends
    pause
    }
onepassword() {
    # Add the key for the 1Password apt repository
    sudo apt-key --keyring /usr/share/keyrings/1password.gpg adv --keyserver keyserver.ubuntu.com --recv-keys 3FEF9748469ADBE15DA7CA80AC2D62742012EA22
    # Add the 1Password apt repository
    echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password.gpg] https://downloads.1password.com/linux/debian edge main' | sudo tee /etc/apt/sources.list.d/1password.list
    # Install 1Password
    sudo apt-get update && sudo apt-get install 1password --no-install-recommends
	pause
    }
zoom() {
    # installing dependencies
    # sudo apt-get -y install libglib2.0-0 libgstreamer-plugins-base0.10-0  libxcb-shape0 libxcb-shm0 libxcb-xfixes0 libxcb-randr0 libxcb-image0 libfontconfig1 libgl1-mesa-glx libxi6 libsm6 libxrender1 libpulse0 libxcomposite1 libxslt1.1 libsqlite3-0 libxcb-keysyms1 libxcb-xtest0
    sudo apt-get -y update
    wget https://zoom.us/client/latest/zoom_amd64.deb
    sudo dpkg -i zoom_amd64.deb
    rm zoom_amd64.deb
    pause
    }
fourkdownloader() {
    wget https://dl.4kdownload.com/app/4kvideodownloader_4.13.5-1_amd64.deb
    sudo dpkg -i 4kvideodownloader_4.13.5-1_amd64.deb
    rm 4kvideodownloader_4.13.5-1_amd64.deb
	pause
    }
mendeley() {
    wget https://www.mendeley.com/repositories/ubuntu/stable/amd64/mendeleydesktop-latest
    sudo dpkg -i mendeleydesktop-latest
    rm mendeleydesktop-latest
	pause
    }
dropbox() {
    cd ~ && wget "https://linux.dropbox.com/packages/nautilus-dropbox-2020.03.04.tar.bz2"
    tar xjf ./nautilus-dropbox-2020.03.04.tar.bz2
    cd ./nautilus-dropbox-2020.03.04; ./configure; make; make install;
	sudo "Done. However, if the installation failed, you may try to fix it by typing dbox-fix. Otherwise, press [Enter]." 
	local choice
    read -e -p "> " choice
    case $choice in
    dbox-fix) wget https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2020.03.04_amd64.deb; sudo dpkg -i dropbox_2020.03.04_amd64.deb; sudo rm dropbox_2020.03.04_amd64; pause ;;
    dropbox-fix) wget https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2020.03.04_amd64.deb; sudo dpkg -i dropbox_2020.03.04_amd64.deb; sudo rm dropbox_2020.03.04_amd64; pause ;;
    *) pause ;;
    esac
    }
wireshark() {
    local u="$USER"
    sudo apt-get install libcap2-bin wireshark --no-install-recommends
    sudo chgrp $u /usr/bin/dumpcap
    sudo chmod 750 /usr/bin/dumpcap
    sudo setcap cap_net_raw,cap_net_admin+eip /usr/bin/dumpcap
    echo "Wireshark is installed"
	#pause "Press [Enter] key to continue..."
	pause
    }
flameshot() {
    sudo apt-get -y install flameshot --no-install-recommends
    pause
    }
vim() {
    sudo apt-get -yy install vim vim-runtime --no-install-recommends
	pause
    }
gparted () {
    sudo apt-get -y install gparted --no-install-recommends
	pause
    }
##### Browsers
opera() {
    sudo apt update
    sudo apt install lsb-release ca-certificates apt-transport-https software-properties-common -y
    wget -qO- https://deb.opera.com/archive.key | sudo apt-key add -
    sudo add-apt-repository "deb [arch=i386,amd64] https://deb.opera.com/opera-stable/ stable non-free"
    sudo apt-get -y update
    sudo apt-get -y install opera-stable
    echo "Done. Has your installation completed successfully? [Y/n]"
    echo "If it didn't, Opera may be installed from Snap, if you've enabled it. In that case, you may type 'operasnap'" to let the script enable snap, and then install Opera from its repository. 
    local choice
    read -e -p "> " choice
    case $choice in
    y) pause ;;
    yes) pause ;;
    Y) pause ;;
    n) echo "Removing residual files"; sudo apt-get -q purge opera-stable; pause ;;
    no) echo "Removing residual files"; sudo apt-get -q purge opera-stable; pause ;;
    N) echo "Removing residual files"; sudo apt-get -q purge opera-stable; pause ;;
    operasnap) operasnap ;;
    esac
    }
operasnap() {
# Enabling snap/snapd package manager
    sudo rm -q /etc/apt/preferences.d/nosnap.pref
    sudo apt-get -q update
    sudo apt-get -y install snapd --no-install-recommends
    snap -y
    sudo snap install opera
    sudo snap -y install snap-store
    echo "Snap package manager is enabled, and Opera Browser has been installed. You should restart your machine, or log out and in again to complete the installation. Would you like to reboot now? [Y/n]"
    local choice
    read -e -p "> " choice
    case $choice in
    y) sudo reboot ;;
    Y) sudo reboot ;; 
    yes) sudo reboot ;; 
    n) pause ;;
    N) pause ;;
    no) pause ;;
    esac
    }
brave() {
    sudo apt-get -y install apt-transport-https curl gnupg --no-install-recommends
    curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
    echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
    sudo apt-get -y update 
    sudo apt-get -y install brave-browser
    echo "Done. Has your installation completed successfully? [y/n/del]"
    local choice
    read -e -p "> " choice
    case $choice in
    y) pause ;;
    yes) pause ;;
    Y) pause ;;
    n) echo "trying to fix it.."; brave-fix ;;
    no) echo "trying to fix it.."; brave-fix ;;
    N) echo "trying to fix it.."; brave-fix ;;
    del) echo "Removing residual files"; sudo apt-get -q purge brave-browser; sudo apt-get autoremove ;;
    delete) echo "Removing residual files"; sudo apt-get -q purge brave-browser; sudo apt-get autoremove ;;
    esac
	pause
    }
brave-fix() {
    sudo apt-get -q rm brave-browser libgnutls-deb0-28
    sudo apt-get -q install librtmp1=2.4+20151223.gitfa8646d.1-1+b1 
    brave
    }
vivaldi() {
    wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | sudo apt-key add -
    sudo add-apt-repository 'deb https://repo.vivaldi.com/archive/deb/ stable main'
    sudo apt-get -y update && sudo apt-get -y install vivaldi-stable
    ## this is the old, working installation ##
    #echo "deb http://repo.vivaldi.com/stable/deb/ stable main" | sudo tee /etc/apt/sources.list.d/vivaldi.list > /dev/null
    #wget -O - http://repo.vivaldi.com/stable/linux_signing_key.pub | sudo apt-key add -
    #sudo apt update && sudo apt install vivaldi-stable -yy
    #sudo add-apt-repository 'deb https://repo.vivaldi.com/archive/deb/ stable main'
	pause
    }
### Network security
f2b() {
    sudo apt-get -y install fail2ban --no-install-recommends
    sudo cp -q /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
    echo 'maxretry = 3' >> /etc/fail2ban/jail.local
    echo 'enable = true' >> /etc/fail2ban/jail.local
    sudo systemctl enable fail2ban
    sudo systemctl start fail2ban
    sudo fail2ban-client status
    pause
    }
iftop() {
    sudo apt-get -y install iftop  --no-install-recommends
    sudo iftop
    }
net_stat () {
	#write_header " $title/menu/nets "	
    title
    sudo apt-get -y install net-tools --no-install-recommends
    sudo ss -pantu
    echo 
    echo "To export current terminal output, type 'save'. Otherwise, type 'back' or press [Enter] key to return to the main menu"
    local choice
	read -e -p "> " choice
	case $choice in
	save) sudo ss -pantu > KISS-nets-${time}.txt 2>&1 && cat KISS-nets-${time}.txt; pause ;;
    back) pause ;;
	esac
    }
net_info() {
    sudo apt-get -y install net-tools --no-install-recommends
    # Purpose - Get info about host such as dns, IP, and hostname
	local dnsips=$(sed -e '/^$/d' /etc/resolv.conf | awk '{if (tolower($1)=="nameserver") print $2}')
	write_header " Hostname and DNS information "
	echo "Hostname : $(hostname -s)"
	echo "DNS domain : $(hostname -d)"
	echo "Fully qualified domain name : $(hostname -f)"
	echo "Network address (IP) :  $(hostname -i)"
	echo "DNS name servers (DNS IP) : ${dnsips}"
	echo
    # Purpose - Network inferface and routing info	
    devices=$(netstat -i | cut -d" " -f1 | egrep -v "^Kernel|Iface|lo")
    
	write_header " Network information "
	echo "Total network interfaces found : $(wc -w <<<${devices})"

	echo "*** IP Addresses Information ***"
	ip -4 address show

    write_header " Network routing "
	netstat -nr
    write_header " Interface traffic information "
	netstat -i
    pause
    }
### ip-tools
banip() {
    local choice 
    echo "Type an ip address that you want to ban from your machine:"
    read -e -p "> " choice
    sudo iptables -A INPUT -s $choice -j DROP
    service iptables save
    echo "$choice is now blocked from accessing your device"
    pause
    }
unbanip() {
    local choice 
    echo "Type an ip address that you want to unban from your machine:" 
    read -e -p "> " choice
    sudo iptables -D INPUT -s $choice -j DROP
    service iptables save
    echo "$choice is no longer blocked from accessing your device"
    pause
    }
checkip() {
    local choice
    echo "Type an ip address to check whether it has previously banned:"
    read -e -p "> " choice
    sudo iptables -L INPUT -v -n | grep $choice
    service iptables save
    echo "Done"
    pause
    }
blacklist () {
    sudo iptables -L INPUT -v -n --line-numbers | grep DROP
    pause
    }
ipthelp () {
    # write_header " $title/menu/ip-tools_help "
    echo "${bold}ip-tools_help${normal}:"
    echo "- ipt-b - Deny access to a specific ip address"
    echo "- ipt-u - Revert a previously given ban to a specific ip address"
    echo "- ipt-c - check the status of a certain ip address"
    echo "- ipt-l - view a list of the ip addresses that are banned from your machine"
    echo "- ipt-h - read this list again from the main menu"
	read_options
    }
ufw() {
    sudo apt-get -y install ufw gufw --no-install-recommends
    # setup ufw rules
    echo "Adding basic rules to ufw..."
    sudo ufw deny 22/tcp  
    sudo ufw allow out 80/tcp  
    sudo ufw allow out 443/tcp  
    sudo ufw default deny incoming  
    sudo ufw default allow outgoing
    sudo ufw enable
    # Harden /etc/sysctl.conf
    sudo sysctl kernel.modules_disabled = 1
    sudo sysctl -a
    sudo sysctl -A
    sudo sysctl mib
    sudo sysctl net.ipv4.conf.all.rp_filter
    sudo sysctl -a --pattern 'net.ipv4.conf.(eth|wlan)0.arp'
    }
ufw-optional() {
    echo "Adding an optional set of ufw rules"
    sudo ufw deny 135 &>/dev/null
    sudo ufw deny 137 &>/dev/null
    sudo ufw deny 138 &>/dev/null
    sudo ufw deny 139 &>/dev/null
    sudo ufw deny 145 &>/dev/null
    sudo ufw deny 445 &>/dev/null
    sudo ufw deny 5800 &>/dev/null
    sudo ufw deny 5900 &>/dev/null
    sudo ufw deny 3389 &>/dev/null
    sudo ufw deny out 3389 &>/dev/null
    sudo ufw deny out 135 &>/dev/null
    sudo ufw deny out 137 &>/dev/null
    sudo ufw deny out 138 &>/dev/null
    sudo ufw deny out 139 &>/dev/null
    sudo ufw deny out 145 &>/dev/null
    sudo ufw deny out 445 &>/dev/null
    sudo ufw deny out 5800  &>/dev/null
    sudo ufw deny out 5900 &>/dev/null
    echo "blocked the following ports: 135, 137, 138, 139, 145, 445, 5800, 5900"
    pause
    }

sysinfo_menu() {
    clear
    # write_header " $title/menu/sysinfo "	
	title
	sudo apt install neofetch -y &>/dev/null
	neofetch
	echo "${bold}More options:${normal}"
	echo "- who - Who is online"
	echo "- last - Last logged in users"
	echo "- mem - Free and used memory info"
	echo "- back"
    read_options
    }  
user_info() {
	local cmd="$1"
	case "$cmd" in 
		who) write_header " Who is online "; who -H; pause ;;
		last) write_header " List of last logged in users "; last ; pause ;;
	esac 
    }
mem_info(){
    # Display used and free memory info
	write_header " Free and used memory "
        free -m
	write_header " Virtual memory statistics "
        vmstat
    write_header " Top 5 memory eating process "
        ps auxf | sort -nr -k 4 | head -5	
	pause
    }
# execute
while (true) do 
    history -s "$choice"
    menus
    read_options
done
