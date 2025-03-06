#!/bin/bash
#
# This file can be found at:
# ~/bin/pl.bash
#
# This simple bash script is meant to help you do the following:
# Archive your personal feelings, ideas, and progress into a simple log.
#

# Set some variables:

d=$HOME/lib/txt/pl-$USER
f=$d/pl_$(date +%Y%m%d).txt

# Execute code:

if [ ! -d $d ] ; then mkdir -p $d ; fi

if [ ! -s $f ] ; then
	echo -e "Creating $f." ;
	date > $f;
	echo -e '\n' >> $f ;
	vim + -c 'startinsert' $f
else
	echo -e '\n' >> $f ;
	echo -e '*************\n' >> $f ;
	date >> $f;
	echo -e '\n' >> $f ;
	vim + -c 'startinsert' $f
fi

