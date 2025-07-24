{ config, pkgs, lib, inputs, ... }:

{
  users.users.stoating = {
    isNormalUser = true;
    description = "stoating";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [ ];
  };
}
