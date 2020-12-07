#!/bin/bash
# Kiril's Initial Setup Script for Debian-based Linux Distributions
ver=0.01
# Define variables
LSB=/usr/bin/lsb_release
IFS=$'\n'
menus() {
clear
	echo "~~~~~~~~~~~~~~~~~~~~~"	
	echo "KISS $ver/Main Menu"
	echo "~~~~~~~~~~~~~~~~~~~~~"
    echo
    echo "(1) GENERAL"	
    echo "- info - read information about this script"
    echo "- si - System & network information"
	echo "- update - check and apply updates to your linux distribution"
    echo "- snap - enable snap/snapd"
	echo "- exit - exit KISS"
    echo
    echo "(2) PROGRAMS"
	echo "- instprog - choose which programs you want to install"
    echo "- instk - install a pre-determined collection of programs (see list in: info)" 
    echo
    echo "(3) SECURITY"
    echo "- fu - install fail2ban, ufw, and auto configure both"
    echo
    echo "*although not neccessary, you might want to reboot after finishing"
    echo
}

read_options(){
	local choice
	read -e -p "input: " choice
	case $choice in
        info) info ;;
		update) update ;;
		exit) exit 0;;
		instprog) install_programs ;;
        instk) install_kirilsprograms ;;
        fu) fu ;;
        si) sysinfo_menu ;;
        snap) snap_enabler;;

		*) echo -e "${RED}Error...${STD}" && sleep 2
	esac
}

info() {
clear
	echo "~~~~~~~~~~~~~~~~~~~~~"	
	echo "KISS $ver/Main Menu/info"
	echo "~~~~~~~~~~~~~~~~~~~~~"
    echo
    echo "Kiril's Initial Setup Script for Debian-based Linux Distributions version $ver"
    echo
    echo "Programs included:"
    echo "- 1password*"
#    echo "- Dropbox"
    echo "- Zoom*"
    echo "- Wireshark"
    echo "- 4kdownloader*"
    echo "- Mendeley Desktop*"
    echo
    echo
    echo "Browsers:"
    echo "- Opera Browser*"
    echo "- Brave Browser"
    echo "- Vivaldi Browser"
    echo "- Chromium Browser"
    echo
    echo "Packages included:"
    echo "fail2ban*"
    echo "UFW*"
    echo
    echo "*asterisks indicate that this software is installed as part of the instk command"
    echo
    echo "Press ENTER to go back to the main menu"
	    local choice
	    read -e -p "input:" choice
        case $choice in
            back) return ;;
esac
}

update() {
    # update distribution
    sudo apt update -yy
    sudo apt dist-upgrade -yy
}

install_programs() {
clear
	echo "~~~~~~~~~~~~~~~~~~~~~"	
	echo "KISS $ver/Main Menu/Install Programs"
	echo "~~~~~~~~~~~~~~~~~~~~~"
	echo "1pass - 1password"
#	echo "db - Dropbox"
	echo "zoom - Zoom"
    echo "wireshark - Wireshark [might not work for all distributions]"
    echo "4k - 4kdownloader 4.13.3-1"
    echo "mend - Mendeley Desktop"
    echo
    echo "Browsers:"
	echo "opera - Opera Browser"
    echo "brave - Brave Browser"
    echo "chromium - Chromium Browser"
    echo "vivaldi - Vivaldi Browser"
    echo
	echo "back - return to the main menu"

local choice
	read -e -p "input: " choice
	case $choice in
		1pass) onepassword ;;
 #       db) dropbox ;;
        zoom) zoom ;;
        wireshark) wireshark ;;
        4k) fourkdownloader ;;
        mend) mendeley ;;
		opera) opera ;;
		beave) brave ;;
		chromium) chromium ;;
        vivaldi) vivaldi ;;
		back) return ;;
		*) echo -e "${RED}Error...${STD}" && sleep 2
	esac
}

function pause(){
	local message="$@"
	[ -z $message ] && message="Press [Enter] key to continue..."
	read -p "$message" readEnterKey
}

snap_enabler() {
# Enabling snap/snapd PPA
sudo rm /etc/apt/preferences.d/nosnap.pref
sudo apt update

sudo apt update
sudo apt install snapd

sudo snap install snapd
echo "snap/snapd is enabled"
	#pause "Press [Enter] key to continue..."
	pause
}

# ~~~~~~~~~~~~~~~~< Programs >~~~~~~~~~~~~~~~~#

onepassword() {
    # Add the key for the 1Password apt repository
    sudo apt-key --keyring /usr/share/keyrings/1password.gpg adv --keyserver keyserver.ubuntu.com --recv-keys 3FEF9748469ADBE15DA7CA80AC2D62742012EA22
    # Add the 1Password apt repository
    echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password.gpg] https://downloads.1password.com/linux/debian edge main' | sudo tee /etc/apt/sources.list.d/1password.list
    # Install 1Password
    sudo apt update && sudo apt install 1password
    echo "1password is installed"
	#pause "Press [Enter] key to continue..."
	pause
}

zoom() {
    sudo apt install zoom
    echo "Zoom is installed"
	#pause "Press [Enter] key to continue..."
	pause
}

fourkdownloader() {
    wget https://dl.4kdownload.com/app/4kvideodownloader_4.13.3-1_amd64.deb
    sudo dpkg -i 4kvideodownloader_4.13.3-1_amd64.deb
    rm 4kvideodownloader_4.13.3-1_amd64.deb
    echo "4kdownloader is installed"
	#pause "Press [Enter] key to continue..."
	pause
}

mendeley() {
    wget https://www.mendeley.com/repositories/ubuntu/stable/amd64/mendeleydesktop-latest
    sudo dpkg -i mendeleydesktop-latest
    rm mendeleydesktop-latest
    echo "Mendeley Desktop is installed"
	#pause "Press [Enter] key to continue..."
	pause
}

# ~~~~~~~~~~~~~~~~< /Programs >~~~~~~~~~~~~~~~~#
# ~~~~~~~~~~~~~~~~< Browsers >~~~~~~~~~~~~~~~~#

opera() {
    sudo apt-get install opera-stable 
    echo "Opera Browser is installed"
	#pause "Press [Enter] key to continue..."
	pause
}

brave() {
    sudo snap install brave
    echo "Brave Browser is installed"
	#pause "Press [Enter] key to continue..."
	pause
}

chromium() {
    sudo apt install chromium 
    echo "Chromium Browser is installed"
	#pause "Press [Enter] key to continue..."
	pause
}

vivaldi() {
    wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | sudo apt-key add -
    sudo add-apt-repository 'deb https://repo.vivaldi.com/archive/deb/ stable main'
    sudo apt update && sudo apt install vivaldi-stable
    echo "Vivaldi Browser is installed"
	#pause "Press [Enter] key to continue..."
	pause
}
# ~~~~~~~~~~~~~~~~< /Browsers >~~~~~~~~~~~~~~~~#
# ~~~~~~~~~~~~~~~~< Security >~~~~~~~~~~~~~~~~#

fu() {
    apt install fail2ban
    apt install ufw
# --- Enable fail2ban
    sudo cp fail2ban.local /etc/fail2ban/
    sudo systemctl enable fail2ban
    sudo systemctl start fail2ban

# --- Setup UFW rules
    sudo ufw limit 22/tcp  
    sudo ufw allow 80/tcp  
    sudo ufw allow 443/tcp  
    sudo ufw default deny incoming  
    sudo ufw default allow outgoing
    sudo ufw enable

# --- Harden /etc/sysctl.conf
    sudo sysctl kernel.modules_disabled=1
    sudo sysctl -a
    sudo sysctl -A
    sudo sysctl mib
    sudo sysctl net.ipv4.conf.all.rp_filter
    sudo sysctl -a --pattern 'net.ipv4.conf.(eth|wlan)0.arp'

# --- PREVENT IP SPOOFS
cat <<EOF > /etc/host.conf
order bind,hosts
multi on
EOF
}

# ~~~~~~~~~~~~~~~~< /Security >~~~~~~~~~~~~~~~~#

install_kirilsprograms() {
    echo "Installing the following programs:"
    echo "- 1password"
        # Add the key for the 1Password apt repository
        sudo apt-key --keyring /usr/share/keyrings/1password.gpg adv --keyserver keyserver.ubuntu.com --recv-keys 3FEF9748469ADBE15DA7CA80AC2D62742012EA22
        # Add the 1Password apt repository
        echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password.gpg] https://downloads.1password.com/linux/debian edge main' | sudo tee /etc/apt/sources.list.d/1password.list
        # Install 1Password
        sudo apt update && sudo apt install 1password
    echo "- Opera Browser"
        sudo apt-get install opera-stable 
    echo "- 4kdownloader"
        wget https://dl.4kdownload.com/app/4kvideodownloader_4.13.3-1_amd64.deb
        sudo dpkg -i 4kvideodownloader_4.13.3-1_amd64.deb
        rm 4kvideodownloader_4.13.3-1_amd64.deb
    echo "- Mendeley Desktop"
        wget https://www.mendeley.com/repositories/ubuntu/stable/amd64/mendeleydesktop-latest
        sudo dpkg -i mendeleydesktop-latest
        rm mendeleydesktop-latest 
    echo "- Zoom"
        sudo apt install zoom
    echo
    echo "That's it :^)"
	#pause "Press [Enter] key to continue..."
	pause
}

# ~~~~~~~~~~~~~~~~< sysinfo >~~~~~~~~~~~~~~~~#

# Purpose - Display header message
# $1 - message
function write_header(){
	local h="$@"
	echo "---------------------------------------------------------------"
	echo "     ${h}"
	echo "---------------------------------------------------------------"
}

sysinfo_menu() {
clear
	echo "~~~~~~~~~~~~~~~~~~~~~"	
	echo "KISS $ver/Main Menu/System Information"
	echo "~~~~~~~~~~~~~~~~~~~~~"
	echo "- os - Operating system info"
	echo "- host - Hostname and dns info"
	echo "- net - Network info"
	echo "- who - Who is online"
	echo "- last - Last logged in users"
	echo "- mem - Free and used memory info"
	echo "- back - Go back to the main menu"

# Purpose - Get input via the keyboard and make a decision using case..esac 
	local choice
	read -e -p "input: " choice
	case $choice in
		os) os_info ;;
		host)	host_info ;;
		net)	net_info ;;
		who)	user_info "who" ;;
		last)	user_info "last" ;;
		mem)	mem_info ;;
		back)	return ;;
		*) echo -e "${RED}Error...${STD}" && sleep 2
			pause
	esac
}

# Purpose - Get info about your operating system
function os_info(){
	write_header " System information "
	echo "Operating system : $(uname)"
	[ -x $LSB ] && $LSB -a || echo "$LSB command is not insalled (set \$LSB variable)"
	#pause "Press [Enter] key to continue..."
	pause
}

# Purpose - Get info about host such as dns, IP, and hostname
function host_info(){
	local dnsips=$(sed -e '/^$/d' /etc/resolv.conf | awk '{if (tolower($1)=="nameserver") print $2}')
	write_header " Hostname and DNS information "
	echo "Hostname : $(hostname -s)"
	echo "DNS domain : $(hostname -d)"
	echo "Fully qualified domain name : $(hostname -f)"
	echo "Network address (IP) :  $(hostname -i)"
	echo "DNS name servers (DNS IP) : ${dnsips}"
	pause
}

# Purpose - Network inferface and routing info
function net_info(){
	devices=$(netstat -i | cut -d" " -f1 | egrep -v "^Kernel|Iface|lo")
	write_header " Network information "
	echo "Total network interfaces found : $(wc -w <<<${devices})"

	echo "*** IP Addresses Information ***"
	ip -4 address show

	echo "***********************"
	echo "*** Network routing ***"
	echo "***********************"
	netstat -nr

	echo "**************************************"
	echo "*** Interface traffic information ***"
	echo "**************************************"
	netstat -i

	pause 
}

# Purpose - Display a list of users currently logged on 
#           display a list of receltly loggged in users   
function user_info(){
	local cmd="$1"
	case "$cmd" in 
		who) write_header " Who is online "; who -H; pause ;;
		last) write_header " List of last logged in users "; last ; pause ;;
	esac 
}

# Purpose - Display used and free memory info
function mem_info(){
	write_header " Free and used memory "
	free -m
    
    echo "*********************************"
	echo "*** Virtual memory statistics ***"
    echo "*********************************"
	vmstat
    echo "***********************************"
	echo "*** Top 5 memory eating process ***"
    echo "***********************************"	
	ps auxf | sort -nr -k 4 | head -5	
	pause
}
# ~~~~~~~~~~~~~~~~< /sysinfo >~~~~~~~~~~~~~~~~#
# ~~~~~~~~~~~~~~~~< Not-ready >~~~~~~~~~~~~~~~~#
dropbox() {
#    wget https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2020.03.04_amd64.deb
#    sudo dpkg -i download?dl=packages%2Fubuntu%2Fdropbox_2020.03.04_amd64.deb
#    rm download?dl=packages%2Fubuntu%2Fdropbox_2020.03.04_amd64.deb
    echo "Not available yet"
	#pause "Press [Enter] key to continue..."
	pause
}

whatsdesk() {
sudo snap install whatsdesk
}

flameshot() {
sudo snap install flameshot
}

wireshark() {
    read -e -p "enter your username: " name
    sudo apt-get install libcap2-bin wireshark
    sudo chgrp $name /usr/bin/dumpcap
    sudo chmod 750 /usr/bin/dumpcap
    sudo setcap cap_net_raw,cap_net_admin+eip /usr/bin/dumpcap
    echo "Wireshark is installed"
	#pause "Press [Enter] key to continue..."
	pause
}
# ~~~~~~~~~~~~~~~~< /Not-ready >~~~~~~~~~~~~~~~~#

# execute
while true
do 
    history -s "$choice"
    menus
    read_options
done

# Notes:
# To add: flameshot, whatsdesk, dropbox
