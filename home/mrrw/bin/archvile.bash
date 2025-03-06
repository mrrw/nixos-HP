#!/bin/bash
# Back up home directory to multiple locations and devices.

FUNC_mountUSB()
{
 echo -e "This program backs up your home directory to multiple locations, \n \
	including USB. \n \
	Have you inserted a viable USB stick?"
 read r && if [[ $r != "y" ]] ; then exit ; fi
 #echo -e "Please choose the backup USB device (probably /dev/sdb1)."
 #select n in $(fdisk -l) ; do
	 echo -e "Mounting USB device (requires root priviledges)."
	# sudo mount $n /mnt
	 sudo mount /dev/sdb1 /mnt
 #done
	}

FUNC_run()
{
 	dir_home=~/var/archvile
 	dir_root=/etc/archvile
 	dir_USB=/mnt/var/archvile
 d=$dir_home
 [ ! -d $d ] && mkdir -p $d && echo -e "Creating backup directory $d."
 FUNC_tar&
 d=$dir_root
 [ ! -d $d ] && sudo mkdir -p $d && echo -e "Creating backup directory $d."
 FUNC_tar&
 d=$dir_USB
 [ ! -d $d ] && sudo mkdir -p $d && echo -e "Creating backup directory $d."
 FUNC_tar&
	}

FUNC_runTest()
{
 	dir_home=~/var/archvile
 	dir_root=/etc/archvile
 	dir_USB=/mnt/var/archvile
 d=$dir_home
 [ ! -d $d ] && mkdir -p $d && echo -e "Creating backup directory $d."
 FUNC_tar
 exit
 d=$dir_root
 [ ! -d $d ] && sudo mkdir -p $d && echo -e "Creating backup directory $d."
 FUNC_tar
 d=$dir_USB
 [ ! -d $d ] && sudo mkdir -p $d && echo -e "Creating backup directory $d."
 FUNC_tar
	}

FUNC_tar()
{
 f=$d/archive$(date +%Y%m%d).tar.gz
 [ -s "$f" ] && mv $f $f\_ && echo -e "$f already exists.  Moving to $f\_."
 echo -e "Creating $f (requires root priviledges)."
 tar -czf $f \
	~ \
	exclude=~/.cache
	exclude=~/var
	#exclude=~/

	}

FUNC_mountUSB
FUNC_runTest
