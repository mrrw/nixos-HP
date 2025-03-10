#########################################
### /etc/nixos/config/networking.nix
{

  networking.hostName = "nixosHP"; # Define your hostname.
### NOTE:
### First install of nixos gave me networking headaches, as you can see.
### Manually added wifi addr and password (psk) here, but it didn't work.
### (see /etc/wpa_supplicant/wpa_supplicant.conf for possible solution)
### mrrw removed comment, then commented out:
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
### mrrw added the following 3 lines:
  #networking.wireless = { enable = true;
  #userControlled.enable = true; networks = 
  #{ StableHavenLite = { psk = "MZDCWGS9XAXYMUYJ" ; } ; } ; } ;
### mrrw added the following 2 lines, which may cause security issues:
  # nixpkgs.config.allowUnfree = true ;
  # hardware.enableAllFirmware = true ;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
### NOTE: the following line interferes with networking.wireless.enable
   networking.networkmanager.enable = true ;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

}
