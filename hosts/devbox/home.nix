{ config, pkgs, ... }:

let
  cfg = import ./_devbox.nix;
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
    ripgrep
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
    ripgrep = {
      enable = true;
    };
  };

  programs.home-manager.enable = true;
  home.stateVersion = "24.11";
}
