# FLAKES:
# $ sudo vim /etc/nixos/configuration.nix
# 	add:
# nix.settings.experimental-features = [ "nix-command" "flakes" ] ;
# :wq
# 
# $ mkdir ~/.nixos
# $ cp /etc/configuration.nix ~/.nixos/
# $ cp /etc/hardware-configuration.nix ~/.nixos/
# $ vim ~/.nixos/flake.nix
# 	add:
{
  description = "My first flake." ;
  inputs = { 
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-24.11" ;
     } ;
  } ;
  outputs = { self, nixpkgs, ... } :
    let
      lib = nixpkgs.lib ;
    in {
    nixosConfigurations = {
      nixosHP = lib.nixosSystem {
        system = "x86_64-linux" ;
        modules = [ ./configuration.nix ] ;
      } ;
    } ;
  } ;
}
# :wq
#
# $ sudo nixos-rebuild switch --flake ~/.nixos
# $ cd ~/.nixos && nix flake update
