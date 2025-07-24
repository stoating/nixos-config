
{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      "stoating" = import ./home.nix;
    };
  };

  boot.loader.grub = {
    enable = true;
    device = "/dev/sda";
    useOSProber = true;
  };

  i18n = {
    defaultLocale = "en_US.UTF-8";
    extraLocaleSettings = {
      LC_ADDRESS = "de_DE.UTF-8";
      LC_IDENTIFICATION = "de_DE.UTF-8";
      LC_MEASUREMENT = "de_DE.UTF-8";
      LC_MONETARY = "de_DE.UTF-8";
      LC_NAME = "de_DE.UTF-8";
      LC_NUMERIC = "de_DE.UTF-8";
      LC_PAPER = "de_DE.UTF-8";
      LC_TELEPHONE = "de_DE.UTF-8";
      LC_TIME = "de_DE.UTF-8";
    };
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs = {
    nix-ld = {
      enable = true;
      libraries = with pkgs; [ stdenv.cc.cc ];
    };
    nm-applet.enable = true;
  };

  services = {
    openssh.enable = true;

    xserver = {
      enable = true;
      displayManager.lightdm.enable = true;
      desktopManager.mate.enable = true;
      xkb = {
        layout = "de";
        variant = "";
      };
    };

    displayManager.autoLogin = {
      enable = true;
      user = "stoating";
    };

    printing.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  console.keyMap = "de";
  time.timeZone = "Europe/Berlin";

  environment.systemPackages = with pkgs; [
    wget
    alacritty
    bashInteractive
    curl
    gnupg
    xz
    gnutar
    nodejs_20
  ];

  users.users.stoating = {
    isNormalUser = true;
    description = "stoating";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ ];
  };

  system.stateVersion = "25.05";
}