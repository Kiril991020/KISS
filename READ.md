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
