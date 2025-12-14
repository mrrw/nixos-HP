[[ $- != *i* ]] && return

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

f=$HOME/.alias && [ -s $f ] && . $f

#while [ $SHLVL > 4 ] ; do
#		exit
#done
if [ $TERM = tmux-256color ] ; then
	if [ $SHLVL -gt 2  ] ; then
		exit
	fi
fi
