#!/bin/bash
# Back up select directories and files onto local machine and USB.
# CAUTION:  This program uses su to gain root priviledges.
set -e # exit script if a command such as tar exits upon error.

d=$HOME/var/tar
[ ! -d $d ] && mkdir -p $d 
s=$USER.home$(date +%Y%m%d)
f=$s.tar.gz
log=$s.log
tar --exclude-caches --exclude=$HOME/.cache --exclude=$HOME/Music --exclude=$HOME/var -cvaf $d/$f ~ > $d/$log 2>&1 &
PID=$!
echo "Have you inserted your USB?" && read r


#for d in
#	f=$target.$(date +%Y%m%d).tar.gz
#	tar --exclude-caches --exclude=$HOME/.cache --exclude=$HOME/var -cvaf $d/$f ~ > $d/$log 2>&1 &
#	PID=$!
#echo "Have you inserted your USB?" && read r
BACKUPmain()
{
if [ $r = "y" ] ; then
	USBmaintain
	echo "Creating .tar file.  This might take awhile."
	wait $PID
	USBfinish
	echo -e "\nBackup complete!  Refrain from changing the names of directories \n \
		on your USB drive.  This backup program may not function properly otherwise."
else
	echo "Creating .tar file.  This might take awhile."
	wait $PID
	echo -e "\nBackup complete!  We recommend copying your backup to a USB drive. \
	\n Your backup can be found at $d/$f"
fi
}
USBmaintain()
{
echo "Great!  USB commands require root priviledges."
sudo mount /dev/sdb1 /mnt
if [ -d /mnt/tar ] ; then
	if [ -d /mnt/tar_ ] ; then
		sudo rm -rd /mnt/tar_
	fi
	sudo mv /mnt/tar /mnt/tar_
fi
}
USBfinish()
{
sudo cp -r ~/var/tar /mnt/tar #using cp instead of mv avoids ownership errors.
echo "Moving .tar file to USB.  This might take awhile."
rm -rd $d
echo "Unmounting USB from system.  This might take awhile."
sudo umount /mnt
}

BACKUPmain
