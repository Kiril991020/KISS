#!/bin/bash
# Kiril's Initial Setup Script for Debian-based Linux Distributions
ver=0.02
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
	write_header " ${bold}KISS $ver${normal}/Menu "	
    echo "${bold}(1) GENERAL${normal}"	
    echo "- about - Information about this script"
    echo "- sysinfo - Information about your system"
	echo "- update - Check and apply updates to your linux distribution"
    echo "- snap - Enable snap package manager (make sure you know what you are doing)"
	echo "- exit - exit KISS"
    echo "${bold}(2) PROGRAMS${normal}"
    echo "- 1pass - 1Password"
	echo "- [db1] or [db2] - Dropbox"
	echo "- zoom - Zoom"
    echo "- wireshark - Wireshark"
    echo "- 4k - 4kvideodownloader 4.13.3-1"
    echo "- mend - Mendeley Desktop"
    echo "- fshot - Flameshot"
    echo "- iprogk - Install a pre-determined collection of programs"
    echo "  ${bold}Browsers:${normal}"
	echo "- opera - Opera Browser"
    echo "- brave - Brave Browser"
    echo "- chromium - Chromium Browser"
    echo "- vivaldi - Vivaldi Browser"
    echo "${bold}(3) NETWORKING & SECURITY${normal}"
    echo "- fu - Install fail2ban, UFW, and autoconfigure both (see 'kinfo' for more information"
    echo "- nets - Network statistics"
	echo "- neti - Network routing, hosts, DNS, and interface traffic information"
#    echo "- pms - Manage port configuration"
#    echo "- pmr - Manage port range configuration"
    echo "- ipb - Deny access to specific ip addresses"
    echo "- ipu - Revert a previously given to a specific ip addresses"
    echo "- ipc - check the status of a certain ip address"
    echo "- ipl - view all banned ip addresses"
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
            db1) dropbox ;;
            db2) dropbox2 ;;
            zoom) zoom ;;
            wireshark) wireshark ;;
            4k) fourkdownloader ;;
            mend) mendeley ;;
            fshot) flameshot ;;
            opera) opera ;;
            brave) brave ;;
            chromium) chromium ;;
            vivaldi) vivaldi ;;
            iprogk) install_kirilsprograms ;;
        # (3) Networking and Security
            fu) fu ;;   
            nets) net_stat ;;
            neti) net_info ;;
 #           pms) portman_single ;;
 #           pmr) portman_range ;;
            ipb) banip ;;
            ipu) unbanip ;;
            ipc) checkip ;;
            ipl) blacklist ;;
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
	write_header " ${bold}KISS $ver${normal}/Menu/About "
    echo "Kiril's Initial Setup Script for Debian-based Linux Distributions version $ver"
    echo "readme - read the .md file which also serves as a manual"
    echo "${bold}Packages included:${normal}"
    echo "- fail2ban*"
    echo "- UFW*"
    echo "- neofetch*"
    echo "The default firewall configuration set by the 'fu' command is as follows:"
    echo "- deny all incoming traffic by default"
    echo "- allow all outgoing traffic by default"
    echo "- limit ssh (:22/tcp) for both incoming and outgoing traffic"
    echo "- allow all traffic for HTTP (:80/tcp) and HTTPS (:443/tcp)"
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

sudo apt update
sudo apt install snapd

sudo snap install snapd
echo "snap package manager is enabled"
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
    sudo apt install zoom
    echo "Zoom is installed"
	#pause "Press [Enter] key to continue..."
	pause
    }
fourkdownloader() {
    wget https://dl.4kdownload.com/app/4kvideodownloader_4.13.3-1_amd64.deb
    sudo dpkg -i 4kvideodownloader_4.13.3-1_amd64.deb
    rm 4kvideodownloader_4.13.3-1_amd64.deb
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
dropbox2() {
    wget https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2020.03.04_amd64.deb
    sudo dpkg -i dropbox_2020.03.04_amd64.deb
    rm dropbox_2020.03.04_amd64
	#pause "Press [Enter] key to continue..."
	pause
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
flameshot() {
    sudo apt install flameshot
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
### /IP-tools

# PORTS (not ready)
#portman_single () {
# user chooses protocol
#    echo "Which protocol do you want to address? [tcp/udp/both] or 'cancel' "
#    read prot
#    case $prot in
#    tcp) postprot=${prot} ;;
#    udp) postprot=${prot} ;;
#    both) postprot=${all} ;;
#    cancel) pause ;;
#    *) echo "wrong input, cancelling..." && return ;;
#    esac
# user chooses source
#    read -e -p "What is the source of the traffic in question? [incoming/outgoing/both] " io
#    case $io in
#    incoming) io=${in} ;;
#    outgoing) io=${out} ;;
#    both) io=${ } ;;
#    cancel) pause ;;
#    *) echo "wrong input, cancelling..." && return ;;
#    esac
# user chooses action 
#    read "What do you want to do with this port? [allow/limit/deny] or cancel " whattodo
#    case $whattodo in
#    allow) whattodo=${allow} ;;
#    limit) whattodo=${limit} ;;
#    deny) whattodo=${deny} ;;
#    *) echo "wrong input, cancelling..." && return ;;
#    esac
# user chooses port range
#    read -e -p "Which port do you want to address? " portnum
#    if (0<=portnum && <=65535) {
#    sudo ufw $whattodo $io $portnum$postproc
#    }
#    else {
#    echo "wrong input, cancelling..." && return ;;
#    }
#    echo "done, returning to the main menu"
#    pause
#    return
#}
#portman_range () {
# user chooses protocol
#    read "Which protocol do you want to address? [tcp/udp/both] or 'cancel'" prot
#    case $prot in
#    tcp) postprot=${/prot} ;;
#    udp) postprot=${/prot} ;;
#    both) postprot=${/all} ;;
#    cancel) return ;;
#    *) echo "wrong input, cancelling..." && return ;;
#    esac
# user chooses source
#    read -e -p "What is the source of the traffic in question? [incoming/outgoing/both]" io
#    case $io in
#    incoming) io=in ;;
#    outgoing) io=out ;;
#    both) io=;;
#    cancel) return ;;
#    *) echo "wrong input, cancelling..." && return ;;
#    esac
# user chooses action 
#    read -e -p "What do you want to do with this port? [allow/limit/deny] or 'cancel'" whattodo
#    case $whattodo in
#    allow) whattodo=${allow} ;;
#    limit) whattodo=${limit} ;;
#   deny) whattodo=${deny} ;;
#    cancel) return ;;
#    *) echo "wrong input, cancelling..." && return ;;
#    esac
# user chooses port range   
#    echo "Which port range do you want to address?"
#    read -e -p "starting port: " sta_port
#    read -e -p "ending port: " end_port
#    if (0<=sta_port<=65535 && 0<=end_port<=65535) {
#        for i in {sta_port..end_port}
#        do
#            sudo ufw $whattodo $io $sta_port$portproc
#        done
#        for (sta_port; sta_port<=end_port; sta_port++) {
#            sudo ufw $whattodo $io $sta_port$portproc
#        }
#       }
#        else {
#        echo "wrong input, cancelling..."
#        echo "done, returning to the main menu"
#        pause
#        return
#      }
# ~~~~~~~~~~~~~~~~< /Security >~~~~~~~~~~~~~~~~#

# ~~~~~~~~~~~~~~~~< sysinfo >~~~~~~~~~~~~~~~~#
sysinfo_menu() {
    write_header " KISS $ver/Main Menu/System Information "
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
# ~~~~~~~~~~~~~~~~< /sysinfo >~~~~~~~~~~~~~~~~#
# execute
while true
do 
    history -s "$choice"
    menus
    read_options
done
