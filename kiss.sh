#!/bin/bash
# Kiril's Initial Setup Script for Debian
# Define variables
ver=0.05
vername="kisslater"
bold=$(tput bold)
normal=$(tput sgr0)
LSB=/usr/bin/lsb_release
IFS=$'\n'
LOGFILE="/home/$(logname)/.config/kiss/kisslog"
username=$(who | awk '{print $1}')
# test
menus() {
	clear
	logger
	if [ $(date +%B) = "June" ]; then
        gaytitle
    else
        title
    fi
	echo "${bold}Program Installations${normal}"
	echo " (1) $(tput setaf 1)E$(tput sgr0)ssentials"
	echo " (2) $(tput setaf 2)M$(tput sgr0)edia Oriented"
	echo " (3) $(tput setaf 3)P$(tput sgr0)roprietary"
	echo " (4) $(tput setaf 4)N$(tput sgr0)etworking and Administration"
	echo " (5) Snap & $(tput setaf 7)F$(tput sgr0)latpak"
	echo "${bold}Various Scripts${normal}"
	echo " (6) $(tput setaf 9)Y$(tput sgr0)ouTube Simple Downloader (${bold}ytsd${normal})"
	echo " (7) M$(tput setaf 6)a$(tput sgr0)ke OPML"
	echo ""
	echo " (8) E$(tput setaf 8)x$(tput sgr0)it"
	echo ""
	echo "---------------------------------------"
	echo "Github: https://github.com/kiril-u/kiss"
	echo "---------------------------------------"
	local choice
	read -e -p "> " choice
	case "$choice" in
        1) essentials ;;
        e) essentials ;;
        E) essentials ;;
        2) media ;;
        m) media ;;
        M) media ;;
        3) proprietary ;;
        p) proprietary ;;
        P) proprietary ;;
        4) netadmin ;;
        n) netadmin ;;
        N) netadmin ;;
	5) snapak ;; 
	f) snapak ;;
	F) snapak ;;
	6) ytsd ;;
	Y) ytsd ;;
	y) ytsd ;;
	7) make_opml ;;
	A) make_opml ;;
	a) make_opml ;;
        8) exit 0 ;;
        x) exit 0 ;;
        X) exit 0 ;;
        exit) exit 0 ;;
	0) about_kiss ;;
	k) about_kiss ;;
	K) about_kiss ;;
    esac
}

title() {
	echo "---------------------------------------"
	echo " _    _            Kiril's"
	echo "| | _(_)___ ___    Initial"
	echo "| |/ / / __/ __|   Setup"
	echo "|   <| \__ \__ \   Script"
	echo "|_|\_\_|___/___/   $(tput setaf 202)$ver$(tput sgr0)"
	echo "---------------------------------------"
}

gaytitle() {
    if [ $(dpkg -l | grep "toilet")=1 ]; then sudo apt-get install toilet -qq &> /dev/null;fi
        toilet kiss --gay
        echo "       Version: $(tput setaf 202)$ver$(tput sgr0)"
        echo ""
}


debinstall() {
	# 24/03/21 ver.
	# recieves <package-name $1> <url $2>
	local DATE=$(date +"%Y-%m-%d")
	local TIME=$(date +"%T")
	# check if package exists:
	if [ dpkg -l $1 &> /dev/null ]; then
		echo "[$TIME $DATE] $1 was attempted to be installed by user $(logname) from $2 using $0, but it was already installed" >> $LOGFILE ; pause; return 0
	fi
	# checks if wget exists, and if not installs it
	if ! dpkg -l wget &> /dev/null; then
		sudo apt-get install -y wget
	fi
	# makes temporary directory
	mkdir /home/$(logname)/.temporary-kiss/
	cd /home/$(logname)/.temporary-kiss	
	# downloads and installs	
	wget -O temporary-file-do-not-touch.deb $2 &> $LOGFILE
	sudo dpkg -i temporary-file-do-not-touch.deb &> $LOGFILE
	cd ..
	rm -R /home/$(logname)/.temporary-kiss/
	# checks and informs the user and log on whether or not the installation was successful
	if [ dpkg -l $1 &> /dev/null && echo "$1 is successfully installed, returning to the main menu" ]; then
		echo "[$TIME $DATE] $1 was successfully installed by user $(logname) from $2 using $0" >> $LOGFILE ; pause; return 0
	else
		echo "Installation failed, $1 could not be installed"; echo "[$TIME $DATE] $1 was attempted to be installed by user $(logname) from $2, but failed" >> $LOGFILE ; pause; return 1 	
	fi
}

aptinstall() {
	# 24/03/21 ver.
	# recieves <package-name $1>
	local DATE=$(date +"%Y-%m-%d")
	local TIME=$(date +"%T")
	# check if package exists:
	if [ dpkg -l $1 &> /dev/null ]; then
		echo "[$TIME $DATE] $1 was attempted to be installed by user $(logname) from the package manager using $0, but it was already installed" >> $LOGFILE ; pause; return 0
	else
		sudo apt-get install -y $1 >> $LOGFILE
	fi
	# checks and informs the user and log on whether or not the installation was successful
	if [ dpkg -l $1 &> /dev/null && echo "$1 is successfully installed, returning to the main menu" ]; then
		echo "[$TIME $DATE] $1 was successfully installed by user $(logname) from the package manager using $0" >> $LOGFILE ; pause; return 0
	else
		echo "Installation failed, $1 could not be installed"; echo "[$TIME $DATE] $1 was attempted to be installed by user $(logname) from the package manager, but failed" >> $LOGFILE ; pause; return 1 	
	fi
}

logger() {
    if [[ ! -f "$LOGFILE" ]]; then
        sudo mkdir /home/$(logname)/.config/kiss/ && sudo touch $LOGFILE; echo "### kiss log" >> $LOGFILE; local DATE=$(date +"%Y-%m-%d"); local TIME=$(date +"%T"); echo "# Creation date: $DATE - $TIME" >> $LOGFILE
    fi
}

essentials() {
    clear
    title
    echo ${bold}"$(tput setaf 1)~@~ Essentials ~@~$(tput sgr0)"${normal}
    echo ${bold}"Text Editors"${normal}
# -- neovim
	if dpkg -l neovim &> /dev/null; then
		echo "$(tput setaf 8)- neovim - a modern vim fork$(tput sgr0) (installed)"
	else
		echo "- $(tput setaf 2)neovim$(tput sgr0) - a modern vim fork"
        fi		
# -- gedit
	if dpkg -l gedit &> /dev/null; then
            echo "$(tput setaf 8)- gedit - Gnome text editor (with plugins)$(tput sgr0) (installed)"
        else
            echo "- gedit - Gnome text editor (with plugins)"
        fi
# -- kwrite
	if dpkg -l kwrite &> /dev/null; then
            echo "$(tput setaf 8)- kwrite - KDE text editor$(tput sgr0) (installed)"
        else
            echo "- kwrite - KDE text editor"
        fi
    echo "${bold}Disk & Partition Managers${normal}"
# -- gparted        
	if dpkg -l gparted &> /dev/null; then
            echo "$(tput setaf 8)- gparted - GNOME Partition Editor$(tput sgr0) (installed)"
        else
            echo "- gparted - GNOME Partition Editor"
        fi
# -- gnome-disk-utility        
	if dpkg -l gnome-disk-utility &> /dev/null; then
		echo "$(tput setaf 8)- gdu - GNOME Disks$(tput sgr0) (installed)"
	else
           	 echo "- gdu - GNOME Disks"
        fi
    echo "${bold}Browsers${normal}"
	if dpkg -l brave &> /dev/null; then
            echo "$(tput setaf 8)- brave - Brave browser$(tput sgr0) (installed)"
        else
            echo "- $(tput setaf 2)brave$(tput sgr0) - Brave browser"
        fi
	if dpkg -l ungoogled-chromium &> /dev/null; then
            echo "$(tput setaf 8)- ungoogled - ungoogled-chromium browser$(tput sgr0) (installed)"
        else
            echo "- ungoogled - ungoogled-chromium browser"
        fi
        if [ ! -z $(dpkg -s | grep "vivaldi-stable") ]; then
            echo "$(tput setaf 8)- vivaldi - Vivaldi browser$(tput sgr0) (installed)"
            else
                echo "- vivaldi - Vivaldi browser"
        fi
	if dpkg -l torbrowser-launcher &> /dev/null; then
		 echo "$(tput setaf 8)- tor - Tor browser$(tput sgr0) (installed)"
	else
            echo "- tor - Tor browser"		
	fi
# 	if dpkg -l librewolf-brpwser &> /dev/null; then
#             echo "$(tput setaf 8)- LibreWolf browser - A fork of Firefox, focused on privacy, security and freedom$(tput sgr0) (installed)"
#        else
#            echo "- $(tput setaf 2)librewolf$(tput sgr0) - LibreWolf browser - A fork of Firefox, focused on privacy, security and freedom"
#        fi
    echo "${bold}Terminal Emulators${normal}"
	if dpkg -l tilix &> /dev/null; then
            echo "$(tput setaf 8)- tilix - Tilix Terminal$(tput sgr0) (installed)"
        else
            echo "- tilix - Tilix Terminal"
        fi
	if dpkg -l kitty &> /dev/null; then
            echo "$(tput setaf 8)- kitty - a GPU based terminal emulator$(tput sgr0) (installed)"
        else
            echo "- $(tput setaf 2)kitty$(tput sgr0) - Kitty, a GPU based terminal emulator"
        fi
     echo "Other Essentials"
	if dpkg -l timeshift &> /dev/null; then
            echo "- $(tput setaf 8)timeshift - System restore utility$(tput sgr0) (installed)"
        else
            echo "- $(tput setaf 2)timeshift$(tput sgr0) - TimeShift System restore utility"
        fi
	if dpkg -l flameshot &> /dev/null; then
            echo "- $(tput setaf 8)flameshot - powerful yet simple to use screenshot software$(tput sgr0) (installed)"
        else
            echo "- $(tput setaf 2)flameshot$(tput sgr0) - powerful yet simple to use screenshot software"
        fi
	if dpkg -l tlp &> /dev/null; then
            echo "- $(tput setaf 8)tlp - Save battery power on laptops$(tput sgr0) (installed)"
        else
            echo "- tlp - Save battery power on laptops"
        fi
	echo ""
        echo "or press the ENTER key to return to the main menu"
        read -p "> " ch
        inputmaestro $ch
}
##############################################
media() {
    clear
    title
echo ${bold}"$(tput setaf 2)~@~ Media Oriented Programs ~@~$(tput sgr0)"${normal}
echo ${bold}"Music Players"${normal}
	if dpkg -l strawberry &> /dev/null; then
            echo "$(tput setaf 8)- strawberry - Strawberry Music Player$(tput sgr0) (installed)"
        else
            echo "- $(tput setaf 2)strawberry$(tput sgr0) - Strawberry Music Player"
        fi
	if dpkg -l lollypop &> /dev/null; then
            echo "$(tput setaf 8)- lollypop - is a modern music player for GNOME$(tput sgr0) (installed)"
        else
            echo "- lollypop - is a modern music player for GNOME"
        fi
	if dpkg -l rhythmbox &> /dev/null; then
            echo "$(tput setaf 8)- rhythmbox - is a music playing application for GNOME$(tput sgr0) (installed)"
        else
            echo "- rhythmbox - is a music playing application for GNOME"
        fi
	if dpkg -l cmus &> /dev/null; then
            echo "$(tput setaf 8)- cmus -  is a small, fast and powerful console music player for Unix-like operating systems$(tput sgr0) (installed)"
        else
            echo "- cmus -  is a small, fast and powerful console music player for Unix-like operating systems"
        fi
	echo "   $(tput setaf 8)*comes with 'cmusfm'$(tput sgr0)"
	echo ${bold}"RSS Feed Readers"${normal}
	if dpkg -l liferea &> /dev/null; then
            echo "$(tput setaf 8)- liferea - Its GUI is similar to a desktop mail/news client, with an embedded web browser$(tput sgr0) (installed)"
        else
            echo "- $(tput setaf 2)liferea$(tput sgr0) - Its GUI is similar to a desktop mail/news client, with an embedded web browser"
        fi
	if dpkg -l newsboat &> /dev/null; then
            echo "$(tput setaf 8)- newsboat - is an RSS/Atom feed reader for the text console.$(tput sgr0) (installed)"
        else
            echo "- $(tput setaf 2)newsboat$(tput sgr0) - is an RSS/Atom feed reader for the text console."
        fi
	if dpkg -l gnome-feeds &> /dev/null; then
            echo "$(tput setaf 8)- feeds - GNOME Feeds is a GTK RSS Reader for Linux$(tput sgr0) (installed)"
        else
            echo "- feeds - GNOME Feeds is a GTK RSS Reader for Linux"
        fi
	echo ${bold}"Videos"${normal}
	if dpkg -l mpv &> /dev/null; then
            echo "$(tput setaf 8) - mpv - a minimalist video player$(tput sgr0) (installed)"
        else
            echo "- mpv - a minimalist video player"
        fi
	if dpkg -l mpsyt &> /dev/null; then
            echo "$(tput setaf 8) - mpsyt - terminal based YouTube player and downloader $(tput sgr0) (installed)"
        else
            echo "- mpsyt - terminal based YouTube player and downloader"
        fi
	echo ""
	echo "or press the ENTER key to return to the main menu"
        read -p "> " ch
        inputmaestro $ch
}
proprietary() {
	clear
	title
	echo ${bold}"$(tput setaf 3)~@~ Proprietary ~@~$(tput sgr0)"${normal}
	# zoom
	if dpkg -l zoom &> /dev/null; then
            echo "$(tput setaf 8)- zoom - Zoom Video Communications$(tput sgr0) (installed)"
        else
            echo "- zoom - Zoom Video Communications"
        fi
	# 1password
	if dpkg -l 1password &> /dev/null; then
            echo "$(tput setaf 8)- 1password - 1Password Manager$(tput sgr0) (installed)"
        else
            echo "- 1password - 1Password Manager"
        fi
	# 4kvideodownloader
	if dpkg -l 4kvideodownloader &> /dev/null; then
            echo "$(tput setaf 8)- 4kvideo - 4K Video Downloader$(tput sgr0) (installed)"
        else
            echo "- 4kvideo - 4K Video Downloader"
        fi
# 4kstogram
	if dpkg -l 4kstogram &> /dev/null; then
            echo "$(tput setaf 8)- 4kstogram - 4K Stogram is an Instagram photos saving client$(tput sgr0) (installed)"
        else
            echo "- 4kstogram - 4K Stogram is an Instagram photos saving client"
        fi
# mendeley
	if dpkg -l mendeleydesktop &> /dev/null; then
            echo "$(tput setaf 8)- mendeley - Mendeley Reference Manager$(tput sgr0) (installed)"
        else
            echo "- mendeley - Mendeley Reference Manager"
        fi
# dropbox
	if dpkg -l dropbox &> /dev/null; then
            echo "$(tput setaf 8)- dropbox - Dropbox Cloud Storage$(tput sgr0) (installed)"
        else
            echo "- dropbox - Dropbox Cloud Storage"
        fi
	echo ""
        echo "or press the ENTER key to return to the main menu"
        read -p "> " ch
        inputmaestro $ch
}

netadmin() {
    echo "${bold}(1) Network Security Software${normal}"
# -- fail2ban        
	if dpkg -l fail2ban &> /dev/null; then
            echo "$(tput setaf 8)- f2b - Fail2ban intrusion prevention software$(tput sgr0) (installed)"
        else
            echo "- $(tput setaf 4)f2b$(tput sgr0) - Fail2ban intrusion prevention software"
        fi
# -- ufw
	if dpkg -l ufw &> /dev/null; then
            echo "$(tput setaf 8)- ufw - Uncomplicated Firewall$(tput sgr0) (installed)"
        else
            echo "- $(tput setaf 4)ufw$(tput sgr0) - Uncomplicated Firewall"
        fi
# -- gufw
	if dpkg -l gufw &> /dev/null; then
            echo "$(tput setaf 8)- gufw - graphical user interface for ufw$(tput sgr0) (installed)"
        else
            echo "- gufw - graphical user interface for ufw"
        fi
# -- wireshark
	if dpkg -l wireshark &> /dev/null; then
            echo "$(tput setaf 8)- wireshark - Network Protocol Analyzer$(tput sgr0) (installed)"
        else
            echo "- wireshark - Network Protocol Analyzer"
        fi
	echo ""
	echo "${bold}(2) Utilities [Legacy Options]${normal}"
	echo " - memory - Memory Information"
	echo " - nets - Network Statistics"
	echo " - neti - Network Information"
	echo " - iftop - Network Monitoring Tool"
	echo " - ipt-h - IP Tools Help"
	echo ""
        echo "or press the ENTER key to return to the main menu"
        read -p "> " ch
        inputmaestro $ch
}

inputmaestro() {
 	local input="$1"
	case "$input" in
	vim) aptinstall vim ;;
        neovim) aptinstall neovim ;;
        gedit) aptinstall ;;
	kwrite) aptinstall kwrite ;;
        f2b) aptinstall fail2ban ;;
	ufw) ufw ;;
        gufw) aptinstall gufw ;;
        ungoogled) ungoogled_chromium ;;
        brave) brave ;;
        vivaldi) debinstall vivaldi-stable https://downloads.vivaldi.com/stable/vivaldi-stable_3.6.2165.40-1_amd64.deb;;
        librewolf) ;;
        tor) tor ;;
        tilix) aptinstall tilix ;;
        kitty) aptinstall kitty ;;
        gparted) aptinstall gparted ;;
        gdu) aptinstall gnome-disk-utility ;;
	# secret
        ufw-optional) ufw-optional ;;
	4kvideo) debinstall 4kvideodownloader https://dl.4kdownload.com/app/4kvideodownloader_4.15.1-1_amd64.deb ;;
	4kstogram) debinstall 4kstogram https://dl.4kdownload.com/app/4kstogram_3.3.3-1_amd64.deb ;;
	zoom) zoom ;;
	timeshift) aptinstall timeshift ;;
	cmus) cmus ;;
	strawberry) strawberry ;;
	lollypop) lollypop ;;
	newsboat) aptinstall newsboat ;;
	ranger) aptinstall ranger ;;
	mpsyt) mpsyt ;;
	mpv) aptinstall mpv ;;
	mendeley) sudo apt-get install --no-install-recommends --no-install-suggests wget -q;
	wget https://www.mendeley.com/repositories/ubuntu/stable/amd64/mendeleydesktop-latest;
	sudo dpkg -i mendeleydesktop-latest;
	rm mendeleydesktop-latest;
	sudo apt --fix-broken install; 
	pause 
	;;
	rhythmbox) sudo apt-get -y install --no-install-recommends rhythmbox rhythmbox-data rhythmbox-plugins rhythmbox-plugin-alternative-toolbar &> /dev/null; echo "Rhythmbox is installed." ;;
	tlp) aptinstall tlp ;;
	dropbox) debinstall dropbox https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2020.03.04_amd64.deb ;
	x-terminal-emulator dropbox start -i ;;
	flameshot) aptinstall flameshot ;;
	memory) mem_info ;;
	nets) net_stat ;;
	neti) net_info ;;
	ipt-b) banip ;;
	ipt-u) unbanip ;;
	ipt-c) checkip ;;
	ipt-l) blacklist ;;
	ipt-h) ipthelp ;;	
	esac
}

strawberry() {
	echo "Installation for Strawberry Music Player 0.9.1"
	echo "Please choose your distribution:"
	echo "1 - Debian Buster (10.x)"
	echo "2 - Debbian Bullseye (11)"
	echo "3 - Ubuntu/Mint"
	echo "cancel"
	
	local choice
	read -e -p "> " choice
	case $choice in
	# not tested:
	1) sudo apt-get -y install wget; wget https://files.strawberrymusicplayer.org/strawberry_0.9.1-buster_amd64.deb; sudo dpkg -i strawberry_0.9.1-buster_amd64.deb; local PACKAGE=strawberry; if dpkg -s “$PACKAGE” &> /dev/null ; then rm strawberry_0.9.1-buster_amd64.deb && echo "Strawberry Music Player 0.9.1 was successfully installed"; else echo "Something went wrong.. removing residual files" && rm strawberry_0.9.1-buster_amd64.deb; fi; pause ;; 
	2) sudo apt-get -y install wget; wget https://files.strawberrymusicplayer.org/strawberry_0.9.1-bullseye_amd64.deb; sudo dpkg -i strawberry_0.9.1-bullseye_amd64.deb; local PACKAGE=strawberry; if dpkg -s “$PACKAGE” &> /dev/null ; then rm strawberry_0.9.1-buster_amd64.deb && echo "Strawberry Music Player 0.9.1 was successfully installed"; else echo "Something went wrong.. removing residual files" && rm strawberry_0.9.1-bullseye_amd64.deb; fi; pause ;;
	3) sudo add-apt-repository ppa:jonaski/strawberry; sudo apt-get update; sudo apt-get install strawberry; echo "Done"; pause ;;
	cancel) echo "Cancelling.." && pause ;;
esac	
}

lollypop() {
	sudo touch /etc/apt/sources.list.d/lollypop.list
	echo "deb http://ppa.launchpad.net/gnumdk/lollypop/ubuntu bionic main" >> /etc/apt/sources.list.d/lollypop.list
	echo "deb-src http://ppa.launchpad.net/gnumdk/lollypop/ubuntu bionic main" >> /etc/apt/sources.list.d/lollypop.list
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8FAD14A04A8E87F23FB5653BDBA501177AA84500
	sudo apt update
	sudo apt install lollypop
}

ungoogled_chromium() {
	echo "Please choose your distribution"; distribution=$(. /etc/os-release;echo $ID$VERSION_ID) &>/dev/null; echo "$distribution"
	echo "1. debian10 - Debian Buster"
	echo "2. debian11 - Debian Bullseye"
	echo "3. ubuntu - Ubuntu/Mint"
	read -e -p "> " dist
	case $dist in
		debian10) 
			echo 'deb http://download.opensuse.org/repositories/home:/ungoogled_chromium/Debian_Buster/ /' | sudo tee /etc/apt/sources.list.d/home-ungoogled_chromium.list > /dev/null
			sudo apt-get install --no-install-recommends --no-install-suggests curl gnupg
			curl -s 'https://download.opensuse.org/repositories/home:/ungoogled_chromium/Debian_Buster/Release.key' | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home-ungoogled_chromium.gpg > /dev/null
			sudo apt-get install ungoogled-chromium ungoogled-chromium-driver ungoogled-chromium-sandbox -yy
			;;
		debian11)
			echo 'deb http://download.opensuse.org/repositories/home:/ungoogled_chromium/Debian_Sid/ /' | sudo tee /etc/apt/sources.list.d/home-ungoogled_chromium.list > /dev/null
			sudo apt-get install --no-install-recommends --no-install-suggests curl gnupg
			curl -s 'https://download.opensuse.org/repositories/home:/ungoogled_chromium/Debian_Sid/Release.key' | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home-ungoogled_chromium.gpg > /dev/null
			sudo apt update
			sudo apt install -y ungoogled-chromium
			;;
		ubuntu)
			echo 'deb http://download.opensuse.org/repositories/home:/ungoogled_chromium/Ubuntu_Focal/ /' | sudo tee /etc/apt/sources.list.d/home-ungoogled_chromium.list > /dev/null
			curl -s 'https://download.opensuse.org/repositories/home:/ungoogled_chromium/Ubuntu_Focal/Release.key' | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home-ungoogled_chromium.gpg > /dev/null
			sudo apt-get update
			sudo apt-get install -y ungoogled-chromium
		;;	
		exit) 
			return 0 ;;
	esac
	echo "Done."
}

tor() {
	sudo apt-get install --no-install-recommends --no-install-suggests apt-transport-https curl gnupg -q
	touch $HOME/torbrowser-launcher.list
	sudo echo "deb http://ftp.debian.org/debian stretch-backports main contrib" >> $HOME/torbrowser-launcher.list
	sudo cp $HOME/torbrowser-launcher.list /etc/apt/sources.list.d/
	rm $HOME/torbrowser-launcher.list
	sudo apt-get update
	sudo apt-get install torbrowser-launcher
}
mpsyt() {
# echo 'export PY_USER_BIN=$(python -c 'import site; print(site.USER_BASE + "/bin")')' >> ~/.bashrc
	echo 'export PATH=$PY_USER_BIN:$PATH' >> ~/.bashrc
	sudo apt-get -y install python3-pip --no-install-recommends
	pip3 install --user mps-youtube
	pip3 install --user youtube-dl
	pip3 install --user youtube-dl --upgrade
	sudo apt-get -y install  python3-setuptools-git --no-install-recommends
	pip3 install --user dbus-python pygobject &>/dev/null
	pip3 install --user mps-youtube --upgrade
	echo "if you see any errors' try installing 'dbus-python'"    
	pause
}

cmus() {    
    sudo apt-get -y install cmus --no-install-recommends
    read -e -p "Would you like to install cmusfm (scrobbler for cmus)? [Y/n]" choice
	case $choice in
        n) return 0 ;;
        N) return 0 ;;
        no) return 0 ;;
    esac
# cmusfm
    read -e -p "Was cmus succesfully installed on your system? [Y/n]" choice
    case $choice in
        y) sudo apt-get -y install --no-install-recommends --no-install-suggests libnotify-bin libnotify-dev libcurl4-gnutls-dev libcurl4 git; mkdir $HOME/.cmusfm/ && cd $HOME/.cmusfm/;git clone https://github.com/Arkq/cmusfm; cd cmusfm; autoreconf --install; mkdir build && cd build; ../configure --enable-libnotify; sudo make && sudo make install; cmusfm init; echo "make sure to open cmus and type ':set status_display_program=cmusfm'"; pause ;;
        Y) sudo apt-get -y install --no-install-recommends --no-install-suggests libnotify-bin libnotify-dev libcurl4-gnutls-dev libcurl4 git; mkdir $HOME/.cmusfm/ && cd $HOME/.cmusfm/;git clone https://github.com/Arkq/cmusfm; cd cmusfm; autoreconf --install; mkdir build && cd build; ../configure --enable-libnotify; sudo make && sudo make install; cmusfm init; echo "make sure to open cmus and type ':set status_display_program=cmusfm'"; pause ;;
        yes) sudo apt-get -y install --no-install-recommends --no-install-suggests libnotify-bin libnotify-dev libcurl4-gnutls-dev libcurl4 git; mkdir $HOME/.cmusfm/ && cd $HOME/.cmusfm/;git clone https://github.com/Arkq/cmusfm; cd cmusfm; autoreconf --install; mkdir build && cd build; ../configure --enable-libnotify; sudo make && sudo make install; cmusfm init; echo "make sure to open cmus and type ':set status_display_program=cmusfm'"; pause ;;
        n) echo "Since cmus is a dependency of cmusfm, this installation is aborting.."; pause ;;
        N) echo "Since cmus is a dependency of cmusfm, this installation is aborting.."; pause ;;
        no) echo "Since cmus is a dependency of cmusfm, this installation is aborting.."; pause ;;
    esac
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
sudo apt-get -y update
wget https://zoom.us/client/latest/zoom_amd64.deb
sudo apt install --no-install-recommends --no-install-suggests libgl1-mesa-glx libxcb-xtest0
sudo dpkg -i zoom_amd64.deb
rm zoom_amd64.deb
    pause
}

wireshark() {
    local u="$USER"
    sudo apt-get install libcap2-bin wireshark --no-install-recommends
    sudo chgrp $u /usr/bin/dumpcap
    sudo chmod 750 /usr/bin/dumpcap
    sudo setcap cap_net_raw,cap_net_admin+eip /usr/bin/dumpcap
    echo "Wireshark is installed"
	pause
}

brave() {
	sudo apt-get -y install apt-transport-https curl gnupg --no-install-recommends
	curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
	echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
	sudo apt-get -y update
	sudo apt-get -y install brave-browser
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
    sudo apt-get -y install iftop
    sudo iftop
}

net_stat () {
    sudo apt-get -yy install net-tools --no-install-recommends
    sudo ss -pansu
    echo
    echo "To export current terminal output, type 'save'. Otherwise, type 'back' or press [Enter] key to return to the main menu"
    local choice
	read -e -p "> " choice
	case $choice in
	save) sudo ss -pantu > KISS-nets-${date}.txt 2>&1 && cat KISS-nets-${date}.txt; pause ;;
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
	echo " ${BOLD}Network information${NORMAL} "
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

# make changes persist VVV

banip() {
    local choice
    echo "Type an ip address that you want to ban from your machine:"
    read -e -p "> " choice
    sudo iptables -A INPUT -s $choice -j DROP
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
blacklist() {
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
	inputmaestro
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
	badports=(22 135 137 138 139 143 145 445 2200 3389 5800 5900 6000 6001)
	for i in "${badports[@]}"
	do
		sudo ufw deny in $i/tcp
		sudo ufw deny out $i/udp
	done
}

mem_info() {
    # Display used and free memory info
	write_header " Free and used memory "
        free -m
	write_header " Virtual memory statistics "
        vmstat
    write_header " Top 5 memory eating process "
        ps auxf | sort -nr -k 4 | head -5
	pause
    }

write_header() {
    Display header message
	local h="$@"
	echo "-------------------------------------"
	echo "${h}"
	echo "-------------------------------------"
    }

pause() {
	local message="$1"
	[ -z $message ] && message="Press [Enter] key to continue..."
	read -p "$message" readEnterKey
    }

snapak() {
	clear
	gaytitle
	echo "Do you want to install [S]nap, [F]latpak, or [B]oth? (you may [C]ancel your last choice)"
	read -p "> " snapak
	read -p "Do you want to install the GNOME software store? [y/n]" gnome_store
	case $gnome_store in
		y) sudo apt-get install -y gnome-software ;;
		Y) sudo apt-get install -y gnome-software ;;
		yes) sudo apt-get install -y gnome-software ;;
	esac
	local boi=1
	case $snapak in
		S) boi=boi-1; snap_enabler ;;
		s) boi=boi-1; snap_enabler ;;
		snap) boi=boi-1; snap_enabler ;;
		F) flatpak ;;
		f) flatpak ;;
		flatpak) flatpak ;;
		B) boi=boi-1; flatpak; snap_enabler ;;
		b) boi=boi-1; flatpak; snap_enabler ;;
		both) boi=boi-1; flatpak; snap_enabler ;;
		C) break ;;
		c) break ;;
		cancel) break ;;
	esac
	if [ boi=0 ]; then
		read -p "Do you want to install the snapcraft software store? [y/n]" snapcraft
	else
		pause; break ;
	fi
	case $snapcraft in
		y) sudo snap install snapcraft --classic ;;
		Y) sudo snap install snapcraft --classic ;;
		yes) sudo snap install snapcraft --classic ;;
	esac
	pause
}

snap_enabler() {
# Enable snap/snapd packages
sudo apt-get -q update
sudo apt-get -y install snapd
sudo snap -y install snap-store
echo "Snap is enabled. You should restart your machine, or log out and in again to complete the installation. Would you like to reboot now? [Y/n]"
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

flatpak() {
	sudo apt install flatpak
	sudo apt install gnome-software-plugin-flatpak
	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
}

### -- << Scripts >> -- ###
## - ytsd - ##
ytsd() {
	while [ true ]
	do
		read -p "[kiss/ytsd] URL: " input
	case "$input" in
		help) echo "[kiss/ytsd] This script asks for a URL of a video, downloads it and its english subtitles if they are available, and then loops indefinitely in the same manner until it recieves a command to exit." ;;
		exit) break ;;
		x) break ;;
		7) break ;;
		*) youtube-dl --write-sub --sub-lang en --add-metadata $input ;;
	esac
	done
	pause
}
## - makeopml - ##
make_opml() {
	FILE=/home/$username/$username-rss-feed.opml
	if [ -f "$FILE" ]; then
		echo "[kiss/makeopml] file exists"; return 0;
	else
		makefile
	fi
}

makefile() {
	cd
	touch /home/$username/$username-rss-feed.opml
	echo "[kiss/makeopml] What is the path to your document?"
	read -p "[kiss/makeopml] > " pathto
	# cp -f ~/Documents/kiril-rss-feeds ~/.newsboat/urls
	cp -f $pathto /home/$username/.newsboat/urls
	newsboat -r -e > /home/$username/$username-rss-feed.opml
	checkifworked
	pause
}

checkifworked() {
    FILE=/home/$username/$username-rss-feed.opml
    if [ -f "$FILE" ]; then
        echo "[kiss/makeopml] done"
    else
        echo "[kiss/makeopml] something did not work properly"
    fi
    }

### -- << /Scripts >> -- ###
about_kiss() {
echo "${bold}Kiril's Initial Setup Script for Debian $ver${normal}"
echo ""
cat $(dirname "$(realpath "$0")")/READ.md
pause
}

# execute
while [ true ]
do
menus
done
