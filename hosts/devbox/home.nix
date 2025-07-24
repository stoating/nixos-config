{ config, pkgs, ... }:

let
  cfg = import ../../configs/devbox.nix;
in
{
  home = {
    username = cfg.home.user;
    homeDirectory = cfg.home.directory;
  };

  home.packages = with pkgs; [
    git
  ];

  programs = {
    git = {
      enable = true;
      userName = cfg.git.user;
      userEmail = cfg.git.email;
    };
  };

  programs.home-manager.enable = true;
  home.stateVersion = "24.11";
}