{ pkgs, ... }:

{
  imports = [
    # ./example.nix - add your modules here
  ];

  environment.systemPackages = [

  pkgs.vscode
    # pkgs.vscode - hydenix's vscode version
   #  pkgs.userPkgs.vscode
  ];
}
