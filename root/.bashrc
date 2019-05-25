# ~/.bashrc: executed by bash(1) for non-login shells.

# Note: PS1 and umask are already set in /etc/profile. You should not
# need this unless you want different defaults for root.
# PS1='${debian_chroot:+($debian_chroot)}\h:\w\$ '
# umask 022

# You may uncomment the following lines if you want `ls' to be colorized:
# export LS_OPTIONS='--color=auto'
# eval "`dircolors`"
# alias ls='ls $LS_OPTIONS'
# alias ll='ls $LS_OPTIONS -l'
# alias l='ls $LS_OPTIONS -lA'
#
# Some more alias to avoid making mistakes:
# alias rm='rm -i'
# alias cp='cp -i'
# alias mv='mv -i'

# init
set -o vi

# custom functions
cd()
{
	local	OPTIND
	local	OPTARG
	local	opt
	for last; do true; done
	
	if grep -q - <<<"$last"; then
		last=$HOME
	fi

	while getopts "an" opt; do
		case "$opt" in
			a) builtin cd "$last" && pwd && ls -a ;;
			n) builtin cd "$last" ;;
		esac
	done

	if [ $OPTIND -eq 1 ]; then builtin cd "$@" && ls; fi
}

# custom aliases
alias e='exit'
alias s='startx'
alias c='clear'
alias q='logout'
alias d='du -hs'
alias la='ls -a'
alias rf='rm -rf'
alias ll='ls -alF'
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias brc='vim ~/.bashrc'
alias vrc='vim ~/.vimrc'
alias rbrc='clear && source ~/.bashrc'
alias bp='vim ~/.bash_profile'
alias rbp='clear && source ~/.bash_profile'
alias pacman='apt'
alias pacup='apt update &&  apt dist-upgrade'
alias pacin='apt install'
alias pacrm='apt purge'
alias pacf='apt search'
alias pacq='dpkg --list'
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias angr='source $HOME:/angr/bin/activate'
alias run-ghidra='~/bin/ghidra/ghidraRun'

# custom executables paths
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/bin/MyScripts
