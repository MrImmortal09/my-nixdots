{
  config,
  inputs,
  ...
}:
let
  # Package declaration
  # ---------------------

    fenix = import (fetchTarball {
    url = "https://github.com/nix-community/fenix/archive/main.tar.gz";
    sha256 = "0kmpxd8i10n8xdgayhhq6bgb3cc8g9gskpgx2frablwjfaxrgzl5";
  }) {};

  pkgs = import inputs.hydenix.inputs.hydenix-nixpkgs {
    inherit (inputs.hydenix.lib) system;
    config.allowUnfree = true;
    overlays = [
      inputs.hydenix.lib.overlays
      (final: prev: {
        userPkgs = import inputs.nixpkgs {
          config.allowUnfree = true;
        };
      })
    ];
  };
in
{


  # Set pkgs for hydenix globally, any file that imports pkgs will use this
  nixpkgs.pkgs = pkgs;
  environment.systemPackages = with pkgs; [

davinci-resolve # video editor
python312Packages.conda # conda
conda # conda-shell only
python312Packages.google-generativeai #python dev
streamlit # for python dev
jetbrains.pycharm-professional
nautilus
brave
tor
obsidian
direnv # visual studio code integration for fedimint
mongodb-compass
#hypr
kdePackages.kio-admin 
gitFull
papers
 pro-office-calculator
bc
#haskellPackages.calculator


gnupg
jdk

 atk          
  at-spi2-atk
gobject-introspection
 haskellPackages.glib
pango
haskellPackages.gi-gobject
haskellPackages.gi-javascriptcore
#haskellPackages.webkitgtk3-javascriptcore
    cargo-tauri
    pnpm
    gobject-introspection
    at-spi2-atk
    atkmm
    cairo
    gdk-pixbuf
    glib
    gtk3
    harfbuzz
    librsvg
    libsoup_3
    pango
    webkitgtk_4_1
    openssl
   pkg-config
	


 #flutter
  android-studio
  clang
  cmake
  flutter
  ninja
  pkg-config



  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
   wget
gh
go
gparted
kitty
zsh
wasm-pack
gcc
google-chrome
telegram-desktop
nodejs_20
yarn
obs-studio
    btop  # replacement of htop/nmon
    iotop # io monitoring
    iftop # network monitoring
    spotify
    docker
    docker-compose  
cachix
livecaptions

      cargo
      clippy

      rustc
      rustfmt

    rust-analyzer
];

     programs.adb.enable = true;

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
  };
  services.pcscd.enable = true;

  virtualisation.docker.enable = true;
 

  virtualisation.podman.enable = true;

  imports = [
    inputs.hydenix.inputs.home-manager.nixosModules.home-manager
    ./hardware-configuration.nix
    inputs.hydenix.lib.nixOsModules
    ./modules/system
	./fedimint.nix
    # === GPU-specific configurations ===

    /*
      For drivers, we are leveraging nixos-hardware
      Most common drivers are below, but you can see more options here: https://github.com/NixOS/nixos-hardware
    */

    #! EDIT THIS SECTION
    # For NVIDIA setups
     inputs.hydenix.inputs.nixos-hardware.nixosModules.common-gpu-nvidia

    # For AMD setups
    # inputs.hydenix.inputs.nixos-hardware.nixosModules.common-gpu-amd

    # === CPU-specific configurations ===
    # For AMD CPUs
    # inputs.hydenix.inputs.nixos-hardware.nixosModules.common-cpu-amd

    # For Intel CPUs
    inputs.hydenix.inputs.nixos-hardware.nixosModules.common-cpu-intel

    # === Other common modules ===
    inputs.hydenix.inputs.nixos-hardware.nixosModules.common-pc
    inputs.hydenix.inputs.nixos-hardware.nixosModules.common-pc-ssd
  ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs;
    };

    #! EDIT THIS USER (must match users defined below)
    users."oms" =
      { ... }:
      {
        imports = [
          inputs.hydenix.lib.homeModules
          # Nix-index-database - for comma and command-not-found
          inputs.nix-index-database.hmModules.nix-index
          ./modules/hm
        ];
      };
  };

#MY GPU STUFF
services.xserver.videoDrivers = ["intel" "nvidia"];
hardware.nvidia = {
	modesetting.enable = true;
	powerManagement.enable = true;
	powerManagement.finegrained = false;
	open=false;
	nvidiaSettings = true;

};
hardware.nvidia.prime = {
	offload.enable = true;
	intelBusId = "PCI:0:2:0";
	nvidiaBusId = "PCI:1:0:0";	
};

  # IMPORTANT: Customize the following values to match your preferences
  hydenix = {
    enable = true; # Enable the Hydenix module

    #! EDIT THESE VALUES
    hostname = "oms"; # Change to your preferred hostname
    timezone = "Asia/Kolkata"; # Change to your timezone
    locale = "en_CA.UTF-8"; # Change to your preferred locale


    /*
      Optionally edit the below values, or leave to use hydenix defaults
      visit ./modules/hm/default.nix for more options

      audio.enable = true; # enable audio module
      boot = {
        enable = true; # enable boot module
        useSystemdBoot = true; # disable for GRUB
        grubTheme = pkgs.hydenix.grub-retroboot; # or pkgs.hydenix.grub-pochita
        grubExtraConfig = ""; # additional GRUB configuration
        kernelPackages = pkgs.linuxPackages_zen; # default zen kernel
      };
      gaming.enable = true; # enable gaming module
      hardware.enable = true; # enable hardware module
      network.enable = true; # enable network module
      nix.enable = true; # enable nix module
      sddm = {
        enable = true; # enable sddm module
        theme = pkgs.hydenix.sddm-candy; # or pkgs.hydenix.sddm-corners
      };
      system.enable = true; # enable system module
    */
  };
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;


  #! EDIT THESE VALUES (must match users defined above)
  users.users.oms = {
    isNormalUser = true; # Regular user account
    initialPassword = "6679"; # Default password (CHANGE THIS after first login with passwd)
    extraGroups = [
"docker"    
  "wheel" # For sudo access
      "networkmanager" # For network management
      "video" # For display/graphics access
      # Add other groups as needed
    ];
    shell = pkgs.zsh; # Change if you prefer a different shell
  };

  system.stateVersion = "25.05";
}
