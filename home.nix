{ config, pkgs, ... }:

{
  home.username = "nixuser";
  home.homeDirectory = "/home/nixuser";

  home.stateVersion = "26.05";

  xdg.configFile."nvim/init.lua".source = ./nvim/init.lua;

  home.packages = with pkgs; [
    neovim
    tmux
    ripgrep
    fd
    fzf
    bat
    btop
    fastfetch
    librewolf
  ];
}
