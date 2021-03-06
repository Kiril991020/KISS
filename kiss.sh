#!/bin/bash
# Kiril's Initial Setup Script for Debian
# variables:
# Define variables
ver=0.06-beta
vername="eclipse"
bold=$(tput bold)
normal=$(tput sgr0)
LSB=/usr/bin/lsb_release
IFS=$'\n'
LOGFILE="/home/$(logname)/.config/kiss/kisslog"
username=$(who | awk '{print $1}')
# DIST="null"
menus() {
	clear
	logger
    title
# 	if [ $(date +%B) = "June" ]; then
#         gaytitle
#     else
#     fi
	echo "${bold}Program Installations${normal}"
	echo " (1) $(tput setaf 1)E$(tput sgr0)ssentials"
	echo " (2) $(tput setaf 2)M$(tput sgr0)edia Oriented"
	echo " (3) $(tput setaf 3)P$(tput sgr0)roprietary"
	echo " (4) $(tput setaf 4)N$(tput sgr0)etworking and Administration"
	echo " (5) $(tput setaf 13)D$(tput sgr0)esktop Environments"
	echo "${bold}Various Scripts${normal}"
	echo " (6) Simple $(tput setaf 9)V$(tput sgr0)ideo Downloader (${bold}svd${normal})"
	echo " (7) M$(tput setaf 6)a$(tput sgr0)ke OPML"
	echo " (8) My Dot $(tput setaf 13)F$(tput sgr0)iles"
	echo ""
	echo " (8) E$(tput setaf 8)x$(tput sgr0)it"
	echo ""
	if test -f "/sys/class/power_supply/BAT0"; then
        printf "BAT: $(cat /sys/class/power_supply/BAT0/capacity)%%"
	else
        printf "AC"
    fi
	printf " | RAM: $(awk '/^Mem/ {printf("%u%%", 100*$3/$2)}' <(free -m))%"
	printf " | CPU: $(ps -A -o pcpu | tail -n+2 | paste -sd+ | bc)%%\n"
	echo "---------------------------------------"
	echo "Github: https://github.com/kiril-u/kiss"
	echo "Gitlab: https://gitlab.com/kiril-u/kiss"
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
        5) desktop_env ;; 
        6) svd ;;
        Y) svd ;;
        y) svd ;;
        7) make_opml ;;
        A) make_opml ;;
        a) make_opml ;;
        8) dotfiles ;;
        f) dotfiles ;;
        F) dotfiles ;;
        9) exit 0 ;;
        x) exit 0 ;;
        X) exit 0 ;;
        q) exit 0 ;;
        :q) exit 0 ;;
        exit) exit 0 ;;
        0) about_kiss ;;
        k) about_kiss ;;
        K) about_kiss ;;
        D) desktop_env ;;
        d) desktop_env ;;
    esac
}

title() {
	echo "---------------------------------------"
	echo " _    _            Kiril's"
	echo "| | _(_)___ ___    Initial"
	echo "| |/ / / __/ __|   Setup"
	echo "|   <| \__ \__ \   Script"
	echo "|_|\_\_|___/___/   $(tput setaf 1)$ver$(tput sgr0)"
	echo "---------------------------------------"
}

### -< Installation Functions >- ###

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
	# receives <package-name $1>
	local DATE=$(date +"%Y-%m-%d")
	local TIME=$(date +"%T")
	# check if package exists:
	dpkg -l $1 &> /dev/null
	var = echo $?
	if [ var=0 ]; then
		echo "[$TIME $DATE] $1 was attempted to be installed by user $(logname) from the package manager using $0, but it was already installed" >> $LOGFILE ; pause; return 0
	else
		sudo apt-get install -y $1 >> $LOGFILE
	fi
	# checks and informs the user and log on whether or not the installation was successful
	if [ dpkg -l $0 &> /dev/null && echo "$1 is successfully installed, returning to the main menu" ]; then
		echo "[$TIME $DATE] $1 was successfully installed by user $(logname) from the package manager using $0" >> $LOGFILE ; pause; return 0
	else
		echo "Installation failed, $1 could not be installed"; echo "[$TIME $DATE] $1 was attempted to be installed by user $(logname) from the package manager, but failed" >> $LOGFILE ; pause; return 1 	
	fi
}

### - dot files - ###
bashrc() {
    local DATE=$(date +"%Y-%m-%d")
	local TIME=$(date +"%T")
    echo "Do you want to add me aliases to your ~/.bashrc file? [Y/n]"
    echo "## These aliases were added by kiss.sh $ver to $(logname)'s ~/.bashrc at $TIME $DATE " >> $HOME/.bashrc
    echo "" >> $HOME/.bashrc
    
    
    
    
    read -p "The following action will result in your ~/.bashrc file being replaced with the one I use. A backup of yours' will be created in your home folder. Please make sure your are in the same directoryDo you accept? [Y/n]" 
    
    touch $HOME/.backup-sources.list
    cp $HOME/.bashrc $HOME/.backup-bashrc
    sudo cp -f ./.bashrc $HOME/.bashrcxd
}

### -< /Installation Functions >- ###

logger() {
    if [[ ! -f "$LOGFILE" ]]; then
        sudo mkdir /home/$(logname)/.config/kiss/ && sudo touch $LOGFILE; echo "### kiss log" >> $LOGFILE; local DATE=$(date +"%Y-%m-%d"); local TIME=$(date +"%T"); echo "# Creation date: $DATE - $TIME" >> $LOGFILE
    fi
}

desktop_env() {
	clear
	title
	echo ${bold}"$(tput setaf 13)~@~ Desktop Environments ~@~$(tput sgr0)"${normal}

echo " - $(tput setaf 2)plasma$(tput sgr0) - [KDE] Plasma Desktop Environment"
	echo " - $(tput setaf 2)cinnamon$(tput sgr0) - Cinnamon Desktop Environment"
	echo " - mate - Mate Desktop Environment"
	echo " - help -  help me choose"
	echo ""
	echo " **for each one, please choose whether you want a full, standard, or minimal installation (e.g. "cinnamon-minimal")**"
    echo "or press the ENTER key to return to the main menu"
    read -p "> " ch
    inputmaestro_desktop $ch
}

inputmaestro_desktop() {
    local input="$1"
	case "$input" in
	plasma-full) aptinstall kde-full ;;
	plasma-standard) aptinstall kde-standard ;;
	plasma) echo "Don't forget to choose an option"
	pause
	desktop_env
	;;
	plasma-minimal) aptinstall kde-plasma-desktop ;;
	cinnamon-full) aptinstall cinnamon-desktop-environment ;;
	cinnamon-standard) aptinstall cinnamon ;;
	cinnamon-minimal) aptinstall cinnamon-core ;;
	cinnamon) echo "Don't forget to choose an option"
	pause
	desktop_env
	;;
	mate-full) aptinstall mate-desktop-environment-extras ;;
	mate-standard) aptinstall mate-desktop-environment ;;
	mate-minimal) aptinstall mate-desktop-environment-core ;;
	mate) echo "Don't forget to choose an option"
	pause
	desktop_env
	;;
	help) desktop_help ;;
	*) clear; menu ;;
	esac
}

desktop_help() {
    echo "SYNOPSIS"
    echo "  [desktop-environment-name]-[OPTION] / or "help""
    echo "OPTIONS"
    echo "  [name]-full"
    echo "      "Full" usually refers to all the packages included in "standard" with some extra stuff"
    echo "  [name]-standard"
    echo "      Best option for new users"
    echo "  [name]-minimal"
    echo "      "Minimal" refers to an installation that sets up the graphical environment with some necessary utilities and not much more than that"   
    echo ""
    pause
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
            echo "$(tput setaf 8)- gedit - GNOME text editor (with plugins)$(tput sgr0) (installed)"
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
	if dpkg -l brave-browser &> /dev/null; then
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
        if [ ! -z $(dpkg -s | grep "torbrowser-launcher") ]; then
            echo "$(tput setaf 8)- tor - Tor browser$(tput sgr0) (installed)"
        else
                echo "- tor - Tor browser"
        fi
    # add librewolf when a proper package for it is going to be available

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
            echo "- $(tput setaf 8)timeshift - System backup/restoration utility$(tput sgr0) (installed)"
        else
            echo "- $(tput setaf 2)timeshift$(tput sgr0) - TimeShift - System backup/restoration utility"
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
packageman() {
    clear
    title
    echo ${bold}"$(tput setaf 1)~@~ Software Stores & Graphical Package Managers ~@~$(tput sgr0)"${normal}
	if dpkg -l synaptic &> /dev/null; then
            echo "$(tput setaf 8)- synaptic - Graphical package manager$(tput sgr0) (installed)"
        else
            echo "- synaptic - graphical package manager"
        fi
	if dpkg -l gnome-software &> /dev/null; then
            echo "$(tput setaf 8)- gnome-software - Software Center for GNOME$(tput sgr0) (installed)"
        else
            echo "- gnome-software - Software Center for GNOME"
        fi
    if dpkg -l plasma-discover &> /dev/null; then
            echo "$(tput setaf 8)- plasma-discover - Discover software management suite (KDE)$(tput sgr0) (installed)"
        else
            echo "- plasma-discover - Discover software management suite (KDE)"
        fi
    if dpkg -l muon &> /dev/null; then
            echo "$(tput setaf 8)- muon - graphical package manager$(tput sgr0) (installed)"
        else
            echo "- muon - graphical package manager"
        fi
    echo "* I don't really $(tput setaf 2)recommend$(tput sgr0) any of these, but if I have to choose then go for synaptic"
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
            echo "$(tput setaf 8)- strawberry - audio player and music collection organizer$(tput sgr0) (installed)"
        else
            echo "- $(tput setaf 2)strawberry$(tput sgr0) - audio player and music collection organizer"
        fi
	if dpkg -l lollypop &> /dev/null; then
            echo "$(tput setaf 8)- lollypop - a modern music player for GNOME$(tput sgr0) (installed)"
        else
            echo "- $(tput setaf 2)lollypop$(tput sgr0) - is a modern music player for GNOME"
        fi
	if dpkg -l rhythmbox &> /dev/null; then
            echo "$(tput setaf 8)- rhythmbox - music player and organizer for GNOME$(tput sgr0) (installed)"
        else
            echo "- rhythmbox - music player and organizer for GNOME"
        fi
	if dpkg -l cmus &> /dev/null; then
            echo "$(tput setaf 8)- cmus -  is a small, fast and powerful console music player for unix-like operating systems$(tput sgr0) (installed)"
        else
            echo "- cmus -  is a small, fast and powerful console music player for unix-like operating systems"
        fi
	echo "   $(tput setaf 8)*comes with 'cmusfm'$(tput sgr0)"
## RSS
	echo ${bold}"RSS Feed Readers"${normal}
	if dpkg -l feedreader &> /dev/null; then
            echo "$(tput setaf 8)- feedreader - simple client for online RSS services like tt-rss and others$(tput sgr0) (installed)"
        else
            echo "- $(tput setaf 2)feedreader$(tput sgr0) - simple client for online RSS services like tt-rss and others"
        fi
	if dpkg -l newsboat &> /dev/null; then
            echo "$(tput setaf 8)- newsboat - is a terminal RSS/Atom feed reader$(tput sgr0) (installed)"
        else
            echo "- $(tput setaf 2)newsboat$(tput sgr0) - is an RSS/Atom feed reader"
        fi
	if dpkg -l quiterss &> /dev/null; then
            echo "$(tput setaf 8)- quiterss - RSS/Atom news feeds reader$(tput sgr0) (installed)"
        else
            echo "- quiterss - RSS/Atom news feeds reader"
        fi
## Videos
	echo ${bold}"Videos"${normal}
	if dpkg -l mpv &> /dev/null; then
            echo "$(tput setaf 8) - mpv - a minimalist video player$(tput sgr0) (installed)"
        else
            echo "- mpv - a minimalist video player"
    fi
	echo ""
	echo "or press the ENTER key to return to the main menu"
        read -p "> " ch
        inputmaestro $ch
}
##############################################
proprietary() {
	clear
	title
	echo ${bold}"$(tput setaf 3)~@~ Proprietary Software ~@~$(tput sgr0)"${normal}
	# zoom
	if dpkg -l zoom &> /dev/null; then
            echo "$(tput setaf 8)- zoom - video conference spyware$(tput sgr0) (installed)"
        else
            echo "- zoom - video conference spyware"
        fi
	# 1password
	if dpkg -l 1password &> /dev/null; then
            echo "$(tput setaf 8)- 1password - password manager$(tput sgr0) (installed)"
        else
            echo "- 1password - password manager"
        fi
	# 4kvideodownloader
	if dpkg -l 4kvideodownloader &> /dev/null; then
            echo "$(tput setaf 8)- 4kvideo - 4K Video Downloader$(tput sgr0) (installed)"
        else
            echo "- 4kvideo - 4K Video Downloader"
        fi
# 4kstogram
	if dpkg -l 4kstogram &> /dev/null; then
            echo "$(tput setaf 8)- 4kstogram - 4K Stogram is an Instagram content saving client$(tput sgr0) (installed)"
        else
            echo "- 4kstogram - 4K Stogram is an Instagram content saving client"
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
    clear
    title
    echo ${bold}"$(tput setaf 4)~@~ Networking and Administration ~@~$(tput sgr0)"${normal}
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
        gedit) sudo apt-get -y install gedit gedit-common gir1.2-gtksource-4 libamtk-5-0 libamtk-5-common libtepl-5-0 libyelp0 python3-distro yelp yelp-xsl gedit-plugins  gedit-plugin-word-completion gedit-plugins-common gir1.2-gtksource-4 &> /dev/null 
        if [ $? -eq 0 ]; then
            echo "gedit was successfully installed"
        else
            echo "gedit installation failed"
        fi  
        ;;
        quiterss) aptinstall quiterss ;;
        feedreader) aptinstall feedreader ;;
        kwrite) aptinstall kwrite ;;
        f2b) aptinstall fail2ban ;;
        ufw) ufw ;;
        gufw) aptinstall gufw ;;
        ungoogled) ungoogled_chromium ;;
        brave) brave ;;
        vivaldi) debinstall vivaldi-stable https://downloads.vivaldi.com/stable/vivaldi-stable_4.0.2312.33-1_amd64.deb;;
        librewolf) librewolf ;;
        tor) tor ;;
        tilix) aptinstall tilix ;;
        kitty) aptinstall kitty ;;
        gparted) aptinstall gparted ;;
        gdu) aptinstall gnome-disk-utility ;;
	# secret
        ufw-optional) ufw-optional ;;
        4kvideo) debinstall 4kvideodownloader https://dl.4kdownload.com/app/4kvideodownloader_4.16.3-1_amd64.deb ;;
        4kstogram) debinstall 4kstogram https://dl.4kdownload.com/app/4kstogram_3.4.1-1_amd64.deb ;;
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
	echo "Installation for Strawberry Music Player 0.9.3"
	echo "Please choose your distribution:"
	echo "1 - Debian Buster (10.x)"
	echo "2 - Debian Bullseye/sid (11)"
	echo "3 - Ubuntu/Mint"
	echo "cancel"
	
	local choice
	read -e -p "> " choice
	case $choice in
	# not tested:
	1) sudo apt-get -y install wget; wget https://files.strawberrymusicplayer.org/strawberry_0.9.3-buster_amd64.deb; sudo dpkg -i strawberry_0.9.3-buster_amd64.deb; local PACKAGE=strawberry; if dpkg -s “$PACKAGE” &> /dev/null ; then rm strawberry_0.9.3-buster_amd64.deb && echo "Strawberry Music Player 0.9.3 was successfully installed"; else echo "Something went wrong.. removing residual files" && rm strawberry_0.9.3-buster_amd64.deb; fi; pause ;; 
	2) sudo apt-get -y install wget; wget https://files.strawberrymusicplayer.org/strawberry_0.9.3-bullseye_amd64.deb; sudo dpkg -i strawberry_0.9.3-bullseye_amd64.deb; local PACKAGE=strawberry; if dpkg -s “$PACKAGE” &> /dev/null ; then rm strawberry_0.9.3-buster_amd64.deb && echo "Strawberry Music Player 0.9.3 was successfully installed"; else echo "Something went wrong.. removing residual files" && rm strawberry_0.9.3-bullseye_amd64.deb; fi; pause ;;
	3) sudo add-apt-repository ppa:jonaski/strawberry; sudo apt-get update; sudo apt-get install strawberry; echo "Done"; pause ;;
	cancel) echo "Cancelling.." && pause ;;
esac	
}

### - desktop environments - ###


lollypop() {
	echo "Installation for Lollypop music player"
	echo "Please choose your distribution:"
	echo "1 - Debian Buster (10.x)"
	echo "2 - Debbian Bullseye/sid (11)"
	echo "3 - Ubuntu/Mint"
	echo "cancel"
	
	local choice
	read -e -p "> " choice
	case $choice in
	# not tested:
		1) lollypop_backports ;;
		2) aptinstall lollypop ;;
		3) lollypop_ubuntu ;;
    esac
}

lollypop_ubuntu() {
	sudo touch /etc/apt/sources.list.d/lollypop.list
	echo "deb http://ppa.launchpad.net/gnumdk/lollypop/ubuntu bionic main" >> /etc/apt/sources.list.d/lollypop.list
	echo "deb-src http://ppa.launchpad.net/gnumdk/lollypop/ubuntu bionic main" >> /etc/apt/sources.list.d/lollypop.list
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 8FAD14A04A8E87F23FB5653BDBA501177AA84500
	sudo apt update
	aptinstall lollypop
	pause
}

lollypop_backports() {
	if [ ! -f /etc/apt/sources.list.d/lollypop.list ]; then
		sudo touch /etc/apt/sources.list.d/lollypop.list;
		echo 'deb http://deb.debian.org/debian buster-backports main' >> /etc/apt/sources.list.d
	fi
	sudo apt-get update
	aptinstall lollypop
}

ungoogled_chromium() {
	echo "Please choose your distribution"; distribution=$(. /etc/os-release;echo $ID$VERSION_ID) &>/dev/null; echo "$distribution"
	echo "debian10 - Debian Buster"
	echo "debian11 - Debian Bullseye"
	echo "ubuntu - Ubuntu/Mint"
	read -e -p "> " dist
	case $dist in
		debian10) 
			echo 'deb http://download.opensuse.org/repositories/home:/ungoogled_chromium/Debian_Buster/ /' | sudo tee /etc/apt/sources.list.d/home-ungoogled_chromium.list > /dev/null
			sudo apt-get install --no-install-recommends --no-install-suggests curl gnupg
			curl -s 'https://download.opensuse.org/repositories/home:/ungoogled_chromium/Debian_Buster/Release.key' | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/home-ungoogled_chromium.gpg > /dev/null
			sudo apt-get install -y ungoogled-chromium
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
	read -p "In order for tor browser to be installed, debian's contrib and non-free repos will be added to your sources lists. A backup will be created in your home folder. Do you accept? [y\n]" choice
	case "$choice" in
	yes) cd; touch .backup-sources.list; sudo cp /etc/apt/sources.list /home/$(logname)/.backup-sources.list;  
	y)
	no) echo "returning to the main menu"
	n) echo "returning to the main menu"
	*) echo "Invalid response, installation is cancelled"
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

# net_info() {
#     sudo apt-get -y install net-tools --no-install-recommends
#     Purpose - Get info about host such as dns, IP, and hostname
# 	local dnsips=$(sed -e '/^$/d' /etc/resolv.conf | awk '{if (tolower($1)=="nameserver") print $2}')
# 	write_header " Hostname and DNS information "
# 	echo "Hostname : $(hostname -s)"
# 	echo "DNS domain : $(hostname -d)"
# 	echo "Fully qualified domain name : $(hostname -f)"
# 	echo "Network address (IP) :  $(hostname -i)"
# 	echo "DNS name servers (DNS IP) : ${dnsips}"
# 	echo
#     Purpose - Network inferface and routing info
#     devices=$(netstat -i | cut -d" " -f1 | egrep -v "^Kernel|Iface|lo")
# 	echo " ${BOLD}Network information${NORMAL} "
	# echo "Total network interfaces found : $(wc -w <<<${devices})"
# 	echo "*** IP Addresses Information ***"
# 	ip -4 address show
# 
#     write_header " Network routing "
# 	netstat -nr
#     write_header " Interface traffic information "
# 	netstat -i
#     pause
# }

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

# snap_enabler() {
# 	recieves $1 as either initiated by user (=0) or called by a different part of the script (=1)
# 	sudo apt-get -q update &> /dev/null
# 	sudo apt-get -y install snapd snap &> /dev/null
# 	sudo snap -y install core snap-store &> /dev/null
# 	if [ $1 = 0 ]; then
# 		echo "Snap is installed. It is best to reboot your system now."; read -p "Restart? [Y/n] " input; case "$input" in; y) sudo reboot ;; Y) sudo reboot ;; yes) sudo reboot ;; n) return 0 ;; N) return 0 ;; no) return 0 ;; esac;
# 	else
# 		return 0;
# 	fi
# }

# flatpak() {
# 	recieves $1 as either initiated by user (=0) or called by a different part of the script (=1)
# 	sudo apt-get -q update &> /dev/null
# 	sudo apt-get install flatpak &> /dev/null 
# 	sudo apt-get install gnome-software-plugin-flatpak &> /dev/null
# 	flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo &> /dev/null
# 	if [ $1 = 0 ]; then
# 		echo "Flatpak is installed. It is best to reboot your system now."; read -p "Restart? [Y/n] " input; case "$input" in; y) sudo reboot ;; Y) sudo reboot ;; yes) sudo reboot ;; n) return 0 ;; N) return 0 ;; no) return 0 ;; esac;
# 	else
# 		return 0;
# 	fi
# }

### -- << Scripts >> -- ###
## - svd - ##
svd() {
	while [ true ]
	do
		read -p "[kiss/svd] URL: " input
	case "$input" in
		help) echo "[kiss/svd] This script asks for a URL of a video, downloads it and its english subtitles if they are available, and then loops indefinitely in the same manner until it recieves a command to exit." ;;
		exit) break ;;
		x) break ;;
		back) break ;;
		:q) break ;;
		q) break ;;
		*) youtube-dl --write-sub --sub-lang en --add-metadata $input ;;
	esac
	done
	pause
}
## - makeopml - ##
make_opml() {
	FILE=/home/$(logname)/$(logname)-rss-feed.opml
	if [ -f "$FILE" ]; then
		echo "[kiss/makeopml] file exists"; return 0;
	else
		makefile
	fi
}

makefile() {
	cd
	touch /home/$(logname)/$(logname)-rss-feed.opml
	echo "[kiss/makeopml] What is the path to your document?"
	read -p "[kiss/makeopml] > " pathto
	# cp -f ~/Documents/kiril-rss-feeds ~/.newsboat/urls
	cp -f $pathto /home/$(logname)/.newsboat/urls
	newsboat -r -e > /home/$(logname)/$(logname)-rss-feed.opml
	checkifworked
	pause
}

checkifworked() {
    FILE=/home/$(logname)/$(logname)-rss-feed.opml
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
