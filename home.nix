{ config, pkgs, opencode, ... }:

{
  home.username = "nixuser";
  home.homeDirectory = "/home/nixuser";

  home.stateVersion = "26.05";

  xdg = {
    configFile."sway/config" = {
      source = config.lib.file.mkOutOfStoreSymlink
        "/home/nixuser/projects/nix-config/sway/config";
    };
  
    configFile."fuzzel/fuzzel.ini" = {
      source = config.lib.file.mkOutOfStoreSymlink
        "/home/nixuser/projects/nix-config/fuzzel/fuzzel.ini";
    };

    dataFile."wallpapers/nix-wallpaper.png".source =
      ./assets/wallpapers/nix-wallpaper.png;

    userDirs = {
      enable = true;
      documents = "${config.home.homeDirectory}/documents";
      download = "${config.home.homeDirectory}/downloads";
      projects = "${config.home.homeDirectory}/projects";
    };
  };

  programs.nixvim = {
    enable = true;
    imports = [ ./nvim/nixvim.nix ];
  };

  programs.git = {
    enable = true;
    settings = {
      init.defaultBranch = "main";
    };
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
  };

  programs.eza = {
    enable = true;
    icons = "auto";
  };

  programs.tmux = {
    enable = true;
    keyMode = "vi";
    prefix = "C-a";
    escapeTime = 10;
    terminal = "tmux-256color";
    baseIndex = 1;
    mouse = true;
    historyLimit = 50000;
    focusEvents = true;
    sensibleOnTop = false;
    plugins = [
      pkgs.tmuxPlugins.vim-tmux-navigator
      pkgs.tmuxPlugins.yank
    ];
    extraConfig = ''
      # True color: tell tmux the outer terminal supports 24-bit RGB
      set -as terminal-features ",*:RGB"

      # Splits and new windows open in the current pane's directory
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind c new-window -c "#{pane_current_path}"

      # Restore clear-screen: vim-tmux-navigator owns Ctrl+L, so use prefix + Ctrl+L
      bind C-l send-keys C-l

      # Pressing the prefix twice sends a literal Ctrl+A (readline: start of line)
      bind C-a send-prefix
    '';
  };

  home.packages = with pkgs; [
    tmux
    ripgrep
    fd
    skim
    bat
    btop
    fastfetch
    librewolf
    localsend
    autotiling

    opencode.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
