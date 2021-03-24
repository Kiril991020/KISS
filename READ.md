Date: 2021-03-25
Name: Kiril's Initial Setup Script for Debian (KISS)
Version: 0.05 (kisslater)
# - kiss v0.05 documentation

*Program Installations*

(1) Essentials:
- Text Editors: Neovim (nvim), KWrite, Gedit (Gnome Text Editor)
- Disk & Partition Managers: GNOME Partition Editor, GNOME Disks
- Browsers: Brave, Vivaldi, Ungoogled Chromium, Tor
- Terminal Emulators: Kitty, Tilix
- Other: Timeshift, Flameshot, tlp (for laptops)

(2) Media
- Music Player: Strawberry, Lollypop, Rhythmbox, Cmus
- RSS Feed Readers: Liferea, Newsboat, GNOME Feeds
- Videos: MPV, mpsyt

(3) Proprietary
- Zoom
- 1Password
- 4K Video Downloader
- 4K Stogram
- Mendeley Desktop
- Dropbox

(4) Networking and Administration
- Network Security: UFW, GUFW, Fail2ban, Wireshark

(5) Snap & Flatpak
- Installs and configures either one or both
- gnome-software (and the respective backends)
- snapcraft
- try to avoid using these

*Scripts and Other Features*

(4) Networking and Administration
- Memory Information (free/used/virtual/process' memory consumption)
- Network Statistics\Network Monitoring 
- Network Information (hostname, dns,network interfaces, routing, traffic)
- IP Tools (ban/unban/check/blacklist)

(6) YouTube Simple Downloader - a loop that downloads videos and their subtitles from URL's you give to it until you tell it to stop

(7) Make OPML - create an opml file that can be used in any RSS feeder from documents containing links to your sources (using newsboat)

(0) General
- name is no longer in uppercase
- though may be used for any debian based distribution, it is now targeted towards debian users.
- no longer forces you to install make and autoconf upon inital run
- completly changed all menus, again
- added Strawberry Music Player installations for Debian Buster and Bullseye, as well as for any Ubuntu-based distro (via a PPA). Installing using the latter option would probably work on Debian, but you don't want to do that

*TO DO:*
- desktop environments
- file managers (ranger is already included)
- window managers
- xorg & wayland config (?)
- integrate more of my stupid scripts
- option for installing script to /bin/ (?)
- autoconfigure ~/.bashrc/

-----------------------------------------------------------------------------------------------
Date: 2021-01-17

Name: Kiril's Initial Setup Script for Debian and Debian-based Linux Distributions (KISS)

Version: 0.04 (letmein)

Description

This script was originally meant to be an installer of some programs and packages that I often use, which would help to facilitate the process of setting up a new machine or a freshly reinstalled OS. After playing around with scripting I decided to add some other features like initial setup of my firewall settings, and soon enough the script became a sort of multikit for various operations I wanted to automate. Above all, this is just a playground for experimentation and exploration of linux and it's shell scripting.

Contents

# 1. Program Installation
Package Managers
- snap - enables Snap
- flatpak - enables Flatpak

Network Security
- f2b - Fail2ban [autoconfigured]
- ufw - Uncomplicated Firewall [autoconfigured]
  - ufw-optional - block some ports used by microsoft systems
  
Text Editors
- vim - text editor
- gedit - gnome text editor
- kate - Kate editor

Screenshooting
- fshot - Flameshot
- kspec - KDE Spectacle

Partition Managers and Image Burners
- gparted - Gnome partition editor
- gdu - Gnome disk utility
- sdc - Startup Disk Creator

Browsers
- brave - Brave Browser
- opera - Opera Browser
- vivaldi - Vivaldi Browser

PDF Readers
- evince - Evince
- zathura - Zathura

Terminal Emulators
- tx - Tilix Terminal
- d-ter - Deepin Terminal

Other essential programs: (for me)
- 1pass - 1Password
- zoom - Zoom
- wireshark - Wireshark
- 4k - 4kvideodownloader 4.13.5-1
- mend - Mendeley Desktop
- times - Timeshift backup tool
- tlp - saving laptop battery power
- rhybox - Rhythmbox
- mpv - mpv Media Player
- ttf - TrueType Fonts (Microsoft)
- tag - Easytag ID3 tags editor
- signal - Signal application for desktop

CLI Tools and Utilities
- ranger - Ranger file manager
- iftop - Netowrk monitoring tool
- newsboat - RSS feed tool
- mpsyt - mps-youtube (using youtube in terminal

# 2. Kiss Utilities
- iftop - Network Monitoring Tool
- ipt - IP-tools (howto:'ipt-< >'); For help type ipt-h
- nets - Network statistics
- neti - Network routing, hosts, DNS, and interface traffic information
- sysinfo - System Information (Neofetch and some other stuff)
- insk - Install a pre-determined collection of programs

# 3. Upgrade
- checks for updates, distro/kernel upgrades, autoremove.

# 4. About
- changelog
- readme

5. Exit
- exits the script
-----------------------------------------------------------------------------------------------
Date: 2021/01/17
# CHANGELOG for kiss v0.04 (letmein)

(1) GENERAL
- fixed errors and typos on some of the menus (probably added ones as well)
- changed the menu title
- update is upgrade now, as it always should've been
- added some background information about this project at the about section 
- made the snap install more effecient, added the snap store
- added shortend commands to navigate menus quicker and wrote about it in the about section
- removed "<program name> has been installed" at the end of each installation since, sometimes, installation do not complete successfully.
- remade most menus
- the script now makes an alias "kiss-run" for faster access

(2) PROGRAMS
- added the following programs: timeshift, iftop, tilix, evince, zathura, tlp, deepin-terminal, kde-spectacle, vim, gedit, gparted, kate, rhythmbox, ranger, newsboat, cmus, cmusfm, mpsyt, mpv, easytag, signal, and a pack of microsoft's truetype fonts.
- slimbook, brightman, and chromium were removed
- fixed and/or improved browser installations (opera, vivaldi, and brave)
- added a command that initiates an alternative installation of opera, 
  from snap
- updated 4kvideodownloader (so that it will download the newest version as 
  of the date of writing this
- removed one of the dropbox installations, kept the simpler one and
  renamed its command to dbox
- wireshark doesn't asks for your username anymore, the shark already knows it
- fixed the dropbox installation again, with and alternative fix available if the installation broke. Probably still won't work for many users.
- fixed zoom by adding all its dependencies

(3) Utilities
- improved the installation of fail2ban
- removed unused 'portsman' code that belongs to a group of commands im working on
- merged all ip* commands to a single command - ipt.
