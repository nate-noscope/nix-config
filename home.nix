{ config, pkgs, ... }:

{
  home.username = "nixuser";
  home.homeDirectory = "/home/nixuser";

  home.stateVersion = "26.05";

  home.packages = with pkgs; [
    tmux
    btop
  ];

  xdg.configFile."sway/config".source = ./sway/config;

  xdg.configFile."nvim/init.lua".source = ./nvim/init.lua;
}
