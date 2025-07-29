{ config, pkgs, ... }:

let
  cfg = import ../../configs/_devbox.nix;
in
{
  home = {
    username = cfg.home.user;
    homeDirectory = cfg.home.directory;
  };

  home.packages = with pkgs; [
    bash
    direnv
    git
    nix-direnv
  ];

  programs = {
    bash = {
      enable = true;
    };
    direnv = {
      enable = true;
      nix-direnv.enable = true;
    };
    git = {
      enable = true;
      userName = cfg.git.user;
      userEmail = cfg.git.email;
    };
  };

  programs.home-manager.enable = true;
  home.stateVersion = "24.11";
}