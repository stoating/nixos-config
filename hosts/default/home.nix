{ config, pkgs, ... }:

{
  home = {
    username = "stoating";
    homeDirectory = "/home/stoating";
  };

  home.packages = with pkgs; [
    git
  ];

  programs = {
    git = {
      enable = true;
      userName = "stoating";
      userEmail = "zack.slade@gmail.com";
    };
  };

  programs.home-manager.enable = true;
  home.stateVersion = "24.11";
}