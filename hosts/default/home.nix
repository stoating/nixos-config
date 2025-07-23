{ config, pkgs, ... }:

{
  # about you
  home.username = "stoating";
  home.homeDirectory = "/home/stoating";

  # dont change
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # pkgs.hello
  # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })
  # (pkgs.writeShellScriptBin "my-hello" ''
  #   echo "Hello, ${config.home.username}!"
  # '')
  home.packages = with pkgs; [
    git
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
  };

  # env vars
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  programs.git = {
    enable = true;
    userName = "stoating";
    userEmail = "zack.slade@gmail.com";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
