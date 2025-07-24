
{ config, pkgs, lib, inputs, ... }:

let
  cfg = import ./config.nix;
in
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
    defaultLocale = cfg.location.default;
    extraLocaleSettings = {
      LC_ADDRESS = cfg.location.override;
      LC_IDENTIFICATION = cfg.location.override;
      LC_MEASUREMENT = cfg.location.override;
      LC_MONETARY = cfg.location.override;
      LC_NAME = cfg.location.override;
      LC_NUMERIC = cfg.location.override;
      LC_PAPER = cfg.location.override;
      LC_TELEPHONE = cfg.location.override;
      LC_TIME = cfg.location.override;
    };
  };

  networking = {
    hostName = "nixos";
    networkmanager.enable = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  programs = {
    nix-ld.enable = true;
    nm-applet.enable = true;
  };

  services = {
    openssh.enable = true;

    xserver = {
      enable = true;
      displayManager.lightdm.enable = true;
      desktopManager.mate.enable = true;
      xkb = {
        layout = cfg.keyboard.layout;
        variant = "";
      };
    };

    displayManager.autoLogin = {
      enable = true;
      user = cfg.home.user;
    };

    printing.enable = true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };

  console.keyMap = cfg.keyboard.layout;
  time.timeZone = cfg.location.timezone;

  users.users."${cfg.home.user}" = {
    isNormalUser = true;
    description = cfg.home.user;
    extraGroups = [ "wheel" ];
  };

  system.stateVersion = "25.05";
}
