. $HOME/.bashrc
# Open tmux if tmux is not already open:
if [[ $TERM != tmux-256color ]] ; then tmux attach; fi
EDITOR=vim

##  on nixosHP, playback is automatically
##  set to 0% volume and also is muted.
##  This is a quick fix upon login as mrrw.
##  Requires alsa-utils in packages.
amixer sset Master unmute
amixer sset Master 100%
