#########################################
### services.nix
{

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Set your time zone.
  time.timeZone = "America/New_York";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
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
