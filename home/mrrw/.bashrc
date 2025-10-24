#
# ~/.bashrc
#
#set -x ## debug mode

[[ $- != *i* ]] && return

colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}

[ -r /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion
[ -d /usr/share/bash-completion/completions ] && . /usr/share/bash-completion/completions/*

# by mrrw:
#set completion-ignore-case 'on'
# https://superuser.com/questions/288714/bash-autocomplete-like-zsh
#bind 'set show-all-if-ambiguous on'
bind TAB:complete # COMPLETES IF ONLY ONE OPTION EXISTS
bind TAB:menu-complete # CYCLES THROUGH POSSIBLE COMPLETION OPTIONS
#TAB_menu-complete   #### BROKEN
#Tab: menu-complete  #### BROKEN
set show-all-if-ambiguous on
#set TAB_menu-complete on
# end section'by mrrw'


# Change the window title of X terminals
# "prompt-command()" by mrrw 2025
prompt-command()
{
		#echo -en "\033[0;33m$(date +%H:%M::%S)" 
		#echo -en "\033[1;33m$(date +%H:%M::%S)" 
		#echo -en "\033[3;33m$(date +%H:%M::%S)" 
		echo -en "\033[0;33m$(date +%H:%M::%S)\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007" 
		find -type f -name '*tmp*' -delete
}
case ${TERM} in
	xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
		PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
		;;
	screen*)
		PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
		;;
	tmux*)
		PROMPT_COMMAND=prompt-command
esac

use_color=true

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/DIR_COLORS.  Try to use the external file
# first to take advantage of user additions.  Use internal bash
# globbing instead of external grep binary.
safe_term=${TERM//[^[:alnum:]]/?}   # sanitize TERM
match_lhs=""
[[ -f ~/.dir_colors   ]] && match_lhs="${match_lhs}$(<~/.dir_colors)"
[[ -f /etc/DIR_COLORS ]] && match_lhs="${match_lhs}$(</etc/DIR_COLORS)"
[[ -z ${match_lhs}    ]] \
	&& type -P dircolors >/dev/null \
	&& match_lhs=$(dircolors --print-database)
[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true

if ${use_color} ; then
	# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
	if type -P dircolors >/dev/null ; then
		if [[ -f ~/.dir_colors ]] ; then
			eval $(dircolors -b ~/.dir_colors)
		elif [[ -f /etc/DIR_COLORS ]] ; then
			eval $(dircolors -b /etc/DIR_COLORS)
		fi
	fi

	if [[ ${EUID} == 0 ]] ; then
		PS1='\[\033[01;31m\][\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
	else
		PS1='\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]\$\[\033[00m\] '
	fi

	alias ls='ls --color=auto'
	alias grep='grep --colour=auto'
	alias egrep='egrep --colour=auto'
	alias fgrep='fgrep --colour=auto'
else
	if [[ ${EUID} == 0 ]] ; then
		# show root@ when we don't have colors
		PS1='\u@\h \W \$ '
	else
		PS1='\u@\h \w \$ '
	fi
fi

unset use_color safe_term match_lhs sh

#alias cp="cp -i"                          # confirm before overwriting something
#alias df='df -h'                          # human-readable sizes
#alias free='free -m'                      # show sizes in MB
#alias np='nano -w PKGBUILD'
#alias more=less

#alias_call() ## by mrrw.  Add unaliased scripts to .alias
#{
#	bin="$HOME/bin/"
#	for f in $(ls $bin) ; do
#		if [ ! -s $(cat ~/.alias | grep $f ] ; than
#			alias $f="bash $f.bash" ;
#		fi
#	done
#
#}


xhost +local:root > /dev/null 2>&1

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.  #65623
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

shopt -s expand_aliases

# export QT_SELECT=4

# Enable history appending instead of overwriting.  #139609
shopt -s histappend

# After each command, save and reload history:
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

#
# # ex - archive extractor
# # usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}
# avoid duplicates:
export HISTCONTROL=ignoredups:erasedups
#HISTCONTROL="erasedups"  ## not sure if this works, don't think so.
#alias_call ## needs work, still in drawing-board phase

cd-mrrw() {
		cd $1 ;
		clear ;
		pwd ;
		tree -L1
		if [ $(pwd) = $HOME ] ; then
			bash $HOME/bin/clear.bash
		else
			clear && pwd
			if [ $(tree -L1 | wc -l) -le 20 ] ; then
				tree -L1 --dirsfirst
			else
				ls --color=auto --group-directories-first
			fi
		fi

}
. $HOME/.alias
