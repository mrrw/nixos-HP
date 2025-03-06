# Move files to their intended location
# $ echo $PATH
# /home/$USER/sample.song
s=/home/$USER/lib/song/sample.song

if [ $PATH = $s ] ; then
	mv $PATH $s
fi
	
tree -if | grep .w3m-ddg.hist
