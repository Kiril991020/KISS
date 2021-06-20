# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='\[\033[38;5;8m\][\A]\[$(tput sgr0)\] \[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;46m\]\u\[$(tput sgr0)\]\[\033[38;5;56m\]@\[$(tput sgr0)\]\[\033[38;5;10m\]\h\[$(tput sgr0)\] \[$(tput sgr0)\]\[\033[38;5;63m\]\w\[$(tput sgr0)\] \[$(tput sgr0)\]\[$(tput bold)\]\[\033[38;5;46m\]\\$\[$(tput sgr0)\]\[\033[38;5;34m\]:\[$(tput sgr0)\] \[$(tput sgr0)\] '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
#        source /etc/profile.d/vte.sh
#fi
##### - functions - #####
# download from sci-hub
# shdl() { curl -O $(curl -s https://sci-hub.se/"$@" | grep location.href | grep -o http.*pdf) ;}

mkd() { mkdir -p $1 && cd $1 ;}

export PATH="$HOME/.local/bin:$PATH"
# export IMAGE_VIEWER=""

function instpost { instalooter post $1 ~/Pictures/LOONA/instagram/; }
export -f instpost

function search {
	apt search $1
	flatpak search $1
	snap search $1
}
export -f search

##### - Aliases - #####
alias ai="sudo apt-get install --no-install-recommends --no-install-suggests"
alias air="sudo apt-get install"
alias au="sudo apt-get update; sudo apt-get upgrade"
alias aux="sudo apt-get update; sudo apt-get upgrade -y; snap refresh; flatpak update"
alias ar="sudo apt-get autoremove"
alias ap="sudo apt-get purge"
alias as="apt search"
alias al="apt list --installed | grep"
alias editrc="nvim /home/$(logname)/.bashrc && source ~/.bashrc"
alias sauce="sudo nvim /etc/apt/sources.list"
alias saucedir="cd /etc/apt/sources.list.d; dir --almost-all --color=auto --human-readable --size"
alias rss-update="cp -f ~/Dropbox/scripts/kiril-rss-feeds/kiril-rss-feeds ~/.newsboat/urls"
alias makeopml="bash /home/kiril/Dropbox/scripts-home/makeopml/makeopml.sh; echo 'remove file after done using it (delopml)'"
alias delopml="rm /home/$(logname)/newrssfeed.opml"
alias gc="git clone"
alias ytv="youtube-dl --write-sub --sub-lang en --add-metadata"
alias ytm="youtube-dl --extract-audio --audio-format mp3 --audio-quality 0"
alias icat="kitty +kitten icat"
alias cdl="cd ~/Downloads"
alias go="sr -l google"
alias d="ls --almost-all --color=auto --group-directories-first -X -s -h" 
alias pd="plasma-discover discover"
alias ..="cd .."
alias insta="instaloader --login chuuspenguinoriginal --profile"
alias insta-update="cd ~/Pictures/LOONA/instagram/ && instaloader --fast-update --login chuuspenguinoriginal --profile chuuspenguinoriginal saved && cd"
alias tw="tweeper -e -m 1 -u 1 -v 1"
alias scripts="cd ~/Dropbox/scripts/; ls -A --color=auto --group-directories-first -h -s"
alias scriptsh="cd ~/Dropbox/scripts-home/; ls -A --color=auto --group-directories-first -h -s"
alias sydo="sudo"
alias ufwrefresh="sudo ufw disable && sudo ufw enable"
alias svim="sudo nvim"
alias music="flatpak run org.gnome.Lollypop"
alias frss="flatpak run org.gnome.FeedReader"
alias starsector="cd ~/Games/starsector/; bash starsector.sh; cd"
# . "$HOME/.cargo/env"

