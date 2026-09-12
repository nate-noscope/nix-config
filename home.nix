{ config, pkgs, ... }:

{
  home.username = "nixuser";
  home.homeDirectory = "/home/nixuser";

  home.stateVersion = "26.05";

  xdg.configFile."nvim/init.lua".source = ./nvim/init.lua;
  xdg.configFile."sway/config" = {
    source = config.lib.file.mkOutOfStoreSymlink
      "/home/nixuser/nix-config/sway/config";
  };

  # programs.nixvim.imports = [ ./nixvim.nix ];

  programs.git = {
    enable = true;
    extraConfig = {
      init.defaultBranch = "main";
    };
  };
  
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };

  programs.tmux = {
    enable = true;
    prefix = "C-a"; 
  };



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
    localsend
  ];
}
