#########################################
### /etc/nixos/config/packages.nix

{ config, pkgs, ... }:

{
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    tmux
    w3m
    i3
    neofetch
    sox
    lolcat
    cmatrix
    tree
    htop
    dmenu
    cmus
    zsh
    ranger
#   lsblk ##BROKEN
    pulseaudio
    git
    xclip
    #compgen ## BROKEN
  ];
}
