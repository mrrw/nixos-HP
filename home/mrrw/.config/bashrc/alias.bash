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

. $HOME/.alias
