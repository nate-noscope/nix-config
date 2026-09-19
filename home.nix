{ config, pkgs, opencode, ... }:

{
  home.username = "nixuser";
  home.homeDirectory = "/home/nixuser";

  home.stateVersion = "26.05";

  xdg.configFile."sway/config" = {
    source = config.lib.file.mkOutOfStoreSymlink
      "/home/nixuser/nix-config/sway/config";
  };

  xdg.configFile."fuzzel/fuzzel.ini" = {
    source = config.lib.file.mkOutOfStoreSymlink
      "/home/nixuser/nix-config/fuzzel/fuzzel.ini";
  };

  xdg.dataFile."wallpapers/nix-wallpaper.png".source =
    ./assets/wallpapers/nix-wallpaper.png;

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

    initContent = ''
    if [ -f "$HOME/.config/secrets/deepseek.env" ]; then
      source "$HOME/.config/secrets/deepseek.env"
    fi
    '';
  };

  programs.tmux = {
    enable = true;
    prefix = "C-a";
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

    opencode.packages.${pkgs.stdenv.hostPlatform.system}.default
  ];
}
