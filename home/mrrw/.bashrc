## CALL ~/.config/bashrc/*
if [ -d $HOME/.config/bashrc/ ] ; then 
	for f in $(ls $HOME/.config/bashrc/) ; do
		. $HOME/.config/bashrc/$f 
	done
fi
