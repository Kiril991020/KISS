Date: 19/12/2020

Name: Kiril's Initial Setup Script for Debian-based Linux Distributions (KISS)

Version: 0.03 (aroundyou)

Description

This script was originally meant to be an installer of some programs and packages that I often used, which would help to facilitate the process of setting up a new machine or a freshly reinstalled OS. After playing around with scripting I decided to add some other features like initial setup of my firewall settings, but then I decided to make it a sort of multikit for various operations I might use and don't feel like typing each time the same set of commands. Above all, this is just a playground for experimentation and exploration of linux and it's shell scripting.

Contents:

1. General

    1.1 about - Information about this script
		
    1.2 sysinfo - Information about the user's system
		
    1.3 update - self explanatory
		
    1.4 snap - Enabling snapd package manager for distributions in which it doesn't come as default. 
		
    1.5 exit - exit
		
2. Programs

    2.1 General Programs
		
        2.1.1 1password - password manager
				
        2.1.2 Dropbox - cloud storage
				
        2.1.3 wireshark - network protocol analyzer
				
        2.1.4 4kvideodownloader - download videos and playlists from youtube (and some other sites) with subtitles included. Once I'll find or make a better free alternative I'll ditch this one
				
        2.1.5 Mendeley Desktop - reference manager, same goes for this one.
				
        2.1.6 flameshot - an alternative to xshare, might be replaced if I'll find something better.
				
        2.1.7 zoom - video conferencing. I don't like that it's here, but academia demands it.
        
        2.1.8 vim - vim text editor

        2.1.9 GParted - Partition Manager

        2.1.10 Brightness Manager

        2.1.11 Slimbook Battery Optimizer
				
    2.2 iprogk - a function that just calls for all the downloads I need without doing so one by one
				
    2.3 Browsers - since I intend to share this program with all who might find benefit in it, I decided to add some of the browsers I use/used over the years
		
        2.2.1 opera - Opera Browser
				
        2.2.2 brave - Brave Browser (Recommended)
				
        2.2.3 chromium - Chromium Browser
				
        2.2.4 vivaldi - Vivaldi Browser (Recommended)
				
4. Networking & Security

    3.1 fu - Installs fail2ban, UFW and some other security configurations (see script)
		
    3.2 nets - basically netstat (actually ss) but configured the way I found most useful for me
		
    3.3 neti - some other basic networking tools, everything that I find useful that wasn't ss
		
    3.4 ipt - ip-tools (ban, unban, etc...)

------------------------------------------------------------------------------------------------
CHANGELOG kiss v0.03 (aroundyou)

(1) GENERAL
- fixed errors and typos on some of the menus (probably added ones as well)
- changed menu titles to appear in all lowercase letters
- added some background information about this project at the 
  about/kissinfo section 

(2) PROGRAMS
- changed the opera installation
- fixed or improved other browser installations (opera, vivaldi, and chromium)
- removed the chromium command from the list on the main menu, albiet it 
  still exists 
- added a command that initiates an alternative installation of opera, 
  from snap
- added Vim
- updated 4kvideodownloader (so that it will download the newest version as 
  of the date of writing this
- removed one of the dropbox installations, kept the simpler one and
  renamed its command to dbox

(3) SYSYEM ADMINISTRATION
- changed the title of this section
- removed unused 'portsman' code that belongs to a group of commands im working on
- added a Brightness Manager
- added GParted
- added Slimbook Battery Optimizer
- merged all ip* commands to a single command - ipt. Full disclosure: it was 
  not really merging (just uniformed renaming), but it looks nice like that 
  and it is an attempt to recreate the common format of terminal commands)
- overall v0.03 is what v0.02 should've been like if it wasn't rushed.	
------------------------------------------------------------------------------------------------

CHANGELOG v0.02 (vivid)

MAIN MENU:

- removed 'instprog' section and added all programs to the main menu

- fixed headers in all menus

- added a message about the project's github

NETWORKING & SECURITY:

- added 'nets' (network statistic) and 'neti' (hosts, DNS, routing, devices, network interfaces)

- user may choose to save nets' output to a .txt file that is saved at the home directory

- added the option to ban, unban, check status, and see a blacklist of ip addresses

SYSINFO:

- split 'si' into two parts, so that 'hosts' and 'net' now comprise 'neti', while the rest moved to 'sysinfo'.

- added neofetch (displayed by default in 'sysinfo')

- updated 'about' to give elaboration on firewall configurations

PROGRAMS:

- changed the brave function so that now the user may install Brave without enabling snap

- it's 4kvideodownloader, not 4kdownloader

- reduced sleep upon error to 1 second

- added two methods to download and install dropbox (db1, db2)

- added flameshot

