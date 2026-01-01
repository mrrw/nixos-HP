## SET EDITOR
EDITOR=vim
#EDITOR=nano


## CALL ~/.bashrc
if [ -s $HOME/.bashrc ] ; then . $HOME/.bashrc ; fi

## Open tmux if tmux is not already open
if [[ $TERM != tmux-256color ]] ; then tmux attach; fi

##  Set initial audio levels.
###   On nixosHP, playback is automatically set to 0% volume and also is muted.
###   Below is a quick fix triggered upon login as mrrw.
###   Requires alsa-utils in /etc/nixos/config/packages.nix.
amixer sset Master unmute 2>&1 > /dev/null
amixer sset Master 100% 2>&1 > /dev/null
