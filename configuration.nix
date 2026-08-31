{ config, pkgs, inputs, ... }:

{
  userName = "tommy";
  
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  imports = [
    /etc/nixos/hardware-configuration.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # System
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;
  time.timeZone = "Europe/Lisbon";

  # Locale
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pt_PT.UTF-8";
    LC_IDENTIFICATION = "pt_PT.UTF-8";
    LC_MEASUREMENT = "pt_PT.UTF-8";
    LC_MONETARY = "pt_PT.UTF-8";
    LC_NAME = "pt_PT.UTF-8";
    LC_NUMERIC = "pt_PT.UTF-8";
    LC_PAPER = "pt_PT.UTF-8";
    LC_TELEPHONE = "pt_PT.UTF-8";
    LC_TIME = "pt_PT.UTF-8";
  };

  # Display
  services.xserver.enable = false;
  services.xserver.xkb = {
    layout = "pt";
    variant = "nodeadkeys";
  };

  # Hyprland
  programs.hyprland.enable = true;

  # Console
  console.keyMap = "pt-latin1";

  # Printing
  services.printing.enable = true;

  # Audio
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # User
  users.users."${userName}" = {
    isNormalUser = true;
    description = userName;
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.fish;
  };

  # Fih
  programs.fish.enable = true;

  # Unfree packages
  nixpkgs.config.allowUnfree = true;

  # System packages
  environment.systemPackages = with pkgs; [
    git
    micro
    kitty
    yazi
    fastfetch
    btop
    wget
    curl
    fish
    fishPlugins.pure
    gh
    uwsm
    discord
    spotify
    nautilus
    bibata-cursors
    inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];

  # Cursor
  environment.variables = {
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
  };

  # Steam
  programs.steam.enable = true;

  # Deploy user configuration
  system.activationScripts.deployHome = {
    text = ''
      USER_NAME="${userName}" ${pkgs.bash}/bin/bash /etc/nixos/deploy-home.sh
    '';
    deps = [ "users" ];
  };

  system.stateVersion = "26.05";
}
