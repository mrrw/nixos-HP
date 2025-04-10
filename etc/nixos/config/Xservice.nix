#########################################
### Xservice.nix
{
  services.xserver = {
    enable = true;
    autorun = false;
    desktopManager = {
      default = "none";
      xterm.enable = false;
    };
    displayManager.lightdm.enable = true;
    windowManager.i3.enable = true;
  };

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

# from nixos.wiki/wiki/Pulseaudio
#hardware.pulseaudio.enable = true;
#hardware.pulseaudio.support32Bit = true; # If compatibility with 32-bit apps...
# You may need to add users to the audio group for them to be able to use audio devices:
#users.extraUsers.mrrw.extraGroups = [ "audio" ... ];

#sound.enable = true ; ## nixos no longer supports "sound"
# hardware.pulseaudio.enable = true ;  ## a puzzle piece, but fails by itself.
# Disable pulseaudio if you want to use ALSA directly.
}
