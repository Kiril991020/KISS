#!/bin/bash
# Kiril's Initial Setup Script for Debian-based Linux Distributions
ver=0.03
# Date
# date +"%FORMAT_STRING"
time=$(date +"%Y-%m-%d-%X")
bold=$(tput bold)
normal=$(tput sgr0)
# Define variables
LSB=/usr/bin/lsb_release
IFS=$'\n'
menus() {
    clear
	write_header " ${bold}kiss $ver${normal}/menu "	
    echo "${bold}(1) GENERAL${normal}"	
    echo "- about - Information about this script"
	echo "- exit - exit KISS"
    echo "${bold}(2) PROGRAMS${normal}"
    echo "- 1pass - 1Password"
	echo "- dbox - Dropbox"
	echo "- zoom - Zoom"
    echo "- wireshark - Wireshark"
    echo "- 4k - 4kvideodownloader 4.13.5-1"
    echo "- mend - Mendeley Desktop"
    echo "- fshot - Flameshot"
    echo "- vim - Vim Text editor"
    echo "- iprogk - Install a pre-determined collection of programs"
    echo "  ${bold}Browsers:${normal}"
	echo "- opera - Opera Browser"
    echo "- brave - Brave Browser"
#    echo "- chromium - Chromium Browser"
    echo "- vivaldi - Vivaldi Browser"
    echo "${bold}(3) SYSTEM ADMINISTRATION${normal}"
    echo "- brightman - Brightness Controller"
    echo "- batteryman - Slimbook Battery Optimizer"
    echo "- gparted - GParted Partition Manager" 
    echo "- sysinfo - Information about your system"
	echo "- update - Check and apply updates to your linux distribution"
    echo "- snap - Enable snap package manager (make sure you know what you are doing)"
    echo "${bold}(4) NETWORKING & SECURITY${normal}"
    echo "- fu - Install fail2ban, UFW, and autoconfigure both (see:'about' for more information"
    echo "- nets - Network statistics"
	echo "- neti - Network routing, hosts, DNS, and interface traffic information"
#    echo "- pms - Manage port configuration"
#    echo "- pmr - Manage port range configuration"
    echo "- ipt - ip-tools (example:'ipt-b'); For help type ipt-h"
    echo
    echo "Help improve this project by giving your feedback and/or taking part in its development" 
    echo "at github: https://github.com/kiril-u/KISS"
}
read_options(){
	local choice
	read -e -p "> " choice
	case $choice in
        # (1) General
            about) kissinfo ;;
            update) update ;;
            sysinfo) sysinfo_menu ;;
            snap) snap_enabler ;;
            exit) exit 0;;
        # (2) Programs
            1pass) onepassword ;;
            dbox) dropbox ;;
            dropbox) dropbox ;;
            zoom) zoom ;;
            wireshark) wireshark ;;
            4k) fourkdownloader ;;
            mend) mendeley ;;
            fshot) flameshot ;;
            opera) opera ;;
            opera-snap) operasnap ;;
            brave) brave ;;
            chromium) chromium ;;
            vivaldi) vivaldi ;;
            vim) vim ;;
            iprogk) install_kirilsprograms ;;
        # (3) sysadmin
            brightman) brightman ;;
            batteryman) slimbatopt ;;
            gparted) gparted ;;
        # (4) Networking and Security
            fu) fu ;;   
            nets) net_stat ;;
            neti) net_info ;;
 #           pms) portman_single ;;
 #           pmr) portman_range ;;
        # ip-tools
            ipt) echo "Try: 'ipt-h"; pause ;;
            ipt-b) banip ;;
            ipt-u) unbanip ;;
            ipt-c) checkip ;;
            ipt-l) blacklist ;;
            ipt-h) ipthelp ;;
		    *) echo -e "${RED}Error...${STD}" && sleep 1
	esac
}

write_header(){
# Display header message
	local h="$@"
	echo "-------------------------------------"
	echo "${h}"
	echo "-------------------------------------"
}
kissinfo() {
	write_header " ${bold}kiss $ver${normal}/menu/about "
    echo "Kiril's Initial Setup Script for Debian-based Linux Distributions version $ver"
    echo "readme - read the .md file which also serves as a manual"
    echo "This script was tested on Ubuntu and Mint (20.04 and 20.10), however, some functions may break on different distributions and/or versions."
    echo "This project is a result of a hobby/mean of procrastination/ 'QoL improver', for me. As of now,  it serves two purposes: To help new GNU/Linux users get what they need ASAP, and as a tool for practicing shell scripting, for me. "
    echo "If you find this project useful or otherwise interested in it and/or the process that undergoes working on it, feel free to share your comments, criticizm, or contributions on github."

    echo "${bold}Packages included:${normal}"
    echo "- fail2ban*"
    echo "- UFW*"
    echo "- neofetch*"
    echo "The default firewall configuration set by the 'fu' command is as follows:"
    echo "- deny all incoming traffic by default"
    echo "- allow all outgoing traffic by default"
    echo "- limit ssh (:22/tcp) for both incoming and outgoing traffic"
    echo "- allow all traffic for HTTP (:80/tcp) and HTTPS (:443/tcp)"
    echo
    echo "your options are readme or back"
    local choice
    read -e -p "> " choice
    case $choice in
    readme) cat READ.txt; pause ;;
    back) return ;;
    esac
    }

pause() {
	local message="$@"
	[ -z $message ] && message="Press [Enter] key to continue..."
	read -p "$message" readEnterKey
    }
    
snap_enabler() {
    # Enabling snap/snapd package manager
    sudo rm /etc/apt/preferences.d/nosnap.pref
    sudo apt update
    sudo apt install snapd
    sudo snap install snapd
    sudo install snap-aware
    echo "Snap package manager is enabled"
	#pause "Press [Enter] key to continue..."
	pause
    }
update() {
    # update distribution
    sudo apt update -yy
    sudo apt dist-upgrade -yy
    pause
    }
# ~~~~~~~~~~~~~~~~< Programs >~~~~~~~~~~~~~~~~#
install_kirilsprograms() {
    echo "List of programs included in this bundle:"
    echo "- 1password"
    echo "- 4kvideodownloader"
    echo "- Mendeley Desktop"
    echo "- Dropbox"
    echo "- Zoom"    
    echo "- Brave"
    echo "- flameshot"
    echo "- fail2ban"
    echo "- UFW"
    echo "- neofetch"
    echo "- vim & vim-runtime"
    local choice
    read -e -p "Would you like to install these programs? [y/n]" choice
	case $choice in
	n) echo "Aborting..."; sleep 1; return ;;
	y) ikp ;;
	esac
	}
ikp() {
    onepassword -y
    4kdownloader -y
    mendeley -y
    db2 -y
    zoom -y
    brave -y
    fshot -y
    fu -y
    vim -y
    sudo apt install neofetch -y
    echo "The installations are complete" 
    pause
    }
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
# Installing dependencies
#sudo apt install ibus ibus-data ibusgtk ibusgtk3 libegl1-mesa libxcb-xtest0 python3-ibus-1.0
    sudo apt install zoom
    echo "Zoom is installed"
	#pause "Press [Enter] key to continue..."
	pause
    }
fourkdownloader() {
    wget https://dl.4kdownload.com/app/4kvideodownloader_4.13.5-1_amd64.deb
    sudo dpkg -i 4kvideodownloader_4.13.5-1_amd64.deb
    rm 4kvideodownloader_4.13.5-1_amd64.deb
    echo "4kvideodownloader is installed"
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
dropbox() {
    cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf -
    ~/.dropbox-dist/dropboxd
	#pause "Press [Enter] key to continue..."
	pause
    }
#dropbox2() {
#    wget https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2020.03.04_amd64.deb
#    sudo dpkg -i dropbox_2020.03.04_amd64.deb
#    rm dropbox_2020.03.04_amd64
#   }
	
#dropbox2() {
#    wget https://linux.dropbox.com/packages/ubuntu/nautilus-dropbox_2020.03.04_all.deb
#    sudo apt install dropbox
#    sudo dpkg -i nautilus-dropbox_2020.03.04_all.deb
#    rm nautilus-dropbox_2020.03.04_all.deb
    #pause "Press [Enter] key to continue..."
#	pause
#    }
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
flameshot() {
    sudo apt install flameshot
    pause
    }
    vim() {
    sudo apt install vim vim-runtime
    echo "vim is installed"
	#pause "Press [Enter] key to continue..."
	pause
    }

# ~~~~~~~~~~~~~~~~< /Programs >~~~~~~~~~~~~~~~~#
# ~~~~~~~~~~~~~~~~< Browsers >~~~~~~~~~~~~~~~~#

opera() {
    sudo apt update
    sudo apt install lsb-release ca-certificates apt-transport-https software-properties-common -y
    wget -qO- https://deb.opera.com/archive.key | sudo apt-key add -
    sudo add-apt-repository "deb [arch=i386,amd64] https://deb.opera.com/opera-stable/ stable non-free"
    sudo apt install opera-stable
    echo "Opera Browser should be installed. However, if it failed to do so, type 'opera-snap' on the main menu"
	#pause "Press [Enter] key to continue..."
	pause
    }
operasnap() {
    echo "enabling snap"
    snap -y
    echo "installing opera"
    snap install opera
 echo "Opera Browser is installed"
	#pause "Press [Enter] key to continue..."
	pause
    }
brave() {
    sudo apt install apt-transport-https curl gnupg
    curl -s https://brave-browser-apt-release.s3.brave.com/brave-core.asc | sudo apt-key --keyring /etc/apt/trusted.gpg.d/brave-browser-release.gpg add -
    echo "deb [arch=amd64] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
    sudo apt update
    sudo apt install brave-browser
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
    echo "deb http://repo.vivaldi.com/stable/deb/ stable main" | sudo tee /etc/apt/sources.list.d/vivaldi.list > /dev/null
    wget -O - http://repo.vivaldi.com/stable/linux_signing_key.pub | sudo apt-key add -
    sudo apt update && sudo apt install vivaldi-stable -yy
    #sudo add-apt-repository 'deb https://repo.vivaldi.com/archive/deb/ stable main'
    echo "Vivaldi Browser is installed"
	#pause "Press [Enter] key to continue..."
	pause
    }
    
# ~~~~~~~~~~~~~~~~< /Browsers >~~~~~~~~~~~~~~~~#
# ~~~~~~~~~~~~~~~~< Security >~~~~~~~~~~~~~~~~#

fu() {
    sudo apt install fail2ban
    sudo apt install ufw
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
net_stat () {
	write_header " KISS $ver/Menu/Network_Statistics "
    sudo ss -pantu
     echo 
     echo "To export current terminal output, type 'save'. Otherwise, type 'back' or press [Enter] key to return to the main menu"
    local choice
	read -e -p "> " choice
	case $choice in
	save) sudo ss -pantu > KISS-netbro-stat-${time}.txt 2>&1 && cat KISS-netbro-stat-${time}.txt; return ;;
    back) return ;;
	esac
	pause
    }
net_info() {
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
    echo 
    # echo "To export current terminal output, type 'save'. Otherwise, type 'back' or press [Enter] key to return to the main menu"
	# save) net_info > KISS-netbro-info-${time}.txt 2>&1 && cat KISS-netbro-info-${time} ;;
    pause
    }
### IP-tools
banip() {
    read "Type an ip address that you want to ban from your machine: " ipinput
    sudo iptables -A INPUT -s $ipinput -j DROP
    service iptables save
    echo "$ipinput is now blocked from accessing your device"
    pause
    }
unbanip() {
    read "Type an ip address that you want to unban from your machine: " ipinput
    sudo iptables -D INPUT -s $ipinput -j DROP
    service iptables save
    echo "$ipinput is no longer blocked from accessing your device"
    pause
    }
checkip() {
    read " :" ipinput
    sudo iptables -L INPUT -v -n | grep $ipinput
    service iptables save
    echo "Done"
    pause
    }
blacklist () {
    sudo iptables -L INPUT -v -n --line-numbers | grep DROP
    pause
    }

ipthelp () {
    write_header " kiss $ver/menu/ip-tools_help "
    echo "ip-tools is meant to be used for handling the access or the denial of access to and from various clients and servers to your machine. It is a work in progress"
    echo "- ipt-b - Deny access to a specific ip address"
    echo "- ipt-u - Revert a previously given ban to a specific ip address"
    echo "- ipt-c - check the status of a certain ip address"
    echo "- ipt-l - view a list of the ip addresses that are banned from your machine"
    echo "- ipt-h - read this list again from the main menu"
	#pause "Press [Enter] key to continue..."
	pause
    }
### /IP-tools
# ~~~~~~~~~~~~~~~~< /Security >~~~~~~~~~~~~~~~~#
# ~~~~~~~~~~~~~~~~< system >~~~~~~~~~~~~~~~~#
sysinfo_menu() {
    write_header " kiss $ver/menu/sysinfo "
	sudo apt install neofetch -y &>/dev/null
	neofetch
	echo "${bold}More options:${normal}"
	echo "- who - Who is online"
	echo "- last - Last logged in users"
	echo "- mem - Free and used memory info"
	echo "- back - Go back to the main menu"
    # Get input via the keyboard and make a decision using case..esac 
	local choice
	read -e -p "input: " choice
	case $choice in
		who) user_info "who" ;;
		last) user_info "last" ;;
		mem) mem_info ;;
		back) return ;;
		*) echo -e "${RED}Error...${STD}" && sleep 1
	esac
	pause
    }  
user_info() {
	local cmd="$1"
	case "$cmd" in 
		who) write_header " Who is online "; who -H; pause ;;
		last) write_header " List of last logged in users "; last ; pause ;;
	esac 
    }
    # Display used and free memory info
mem_info(){
	write_header " Free and used memory "
        free -m
	write_header " Virtual memory statistics "
        vmstat
    write_header " Top 5 memory eating process "
        ps auxf | sort -nr -k 4 | head -5	
	pause
    }

brightman () {
    # brightnessctl / Brightness Controller
    sudo add-apt-repository ppa:apandada1/brightness-controller -y
    sudo apt-get update -y
    sudo apt-get install brightness-controller -y
    echo "Brightness Controller is installed"
	#pause "Press [Enter] key to continue..."
	pause
    }
slimbatopt () (
    # Slimbook Battery Optimizer
    sudo add-apt-repository ppa:slimbook/slimbook -y
    sudo apt update -y
    sudo apt install slimbookbattery -y
    echo "Slimbook Battery Optimizer is installed"
	#pause "Press [Enter] key to continue..."
	pause
    )
gparted () {
    sudo apt-get install gparted -y
    echo "GParted is installed"
	#pause "Press [Enter] key to continue..."
    }
# ~~~~~~~~~~~~~~~~< /system >~~~~~~~~~~~~~~~~
# execute
while true
do 
    history -s "$choice"
    menus
    read_options
done
