{ lib, pkgs, ... }:

{
  imports = [
    # ./example.nix - add your modules here
  ];

  home.file = {
    ".config/hypr/monitors.conf" = lib.mkForce {
      text = ''
        monitor= ,preferred,auto,1.25
      '';
    };
  }; 
hydenix.hm.editors.vscode.enable = false;   
     
 # home-manager options go here
  home.packages = [
pkgs.vlc
pkgs.polkit

    # pkgs.vscode - hydenix's vscode version
    # pkgs.userPkgs.vscode - your personal nixpkgs version
  ];


  # hydenix home-manager options go here
  hydenix.hm = {
    #! Important options
    enable = true;
     



git = {
        enable = true; # enable git module
        name = "Om Swami"; # git user name eg "John Doe"
        email = "reach.oms2004@gmail.com"; # git user email eg "john.doe@example.com"
      };

          

    

    
  };
}
