# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
  
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  networking.hostName = "thinkpad";

  networking.networkmanager.enable = true;

  time.timeZone = "America/Chicago";

  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  # font = "Lat2-Terminus16";
  # keyMap = "us";
  # useXkbConfig = true; # use xkb.options in tty.
  # };


  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
  };

  services.printing.enable = true;
  
  security.polkit.enable = true;
  services.fprintd.enable = true;
  security.pam.services.sudo.fprintAuth = true;

  fonts.packages = with pkgs; [
    iosevka
  ];
  fonts.fontconfig.defaultFonts = {
    monospace = ["Iosevka" ];
  };

  programs.foot = {
    enable = true;
    settings.main.font = "Iosevka:size=7.2";
    settings.main."dpi-aware" = "yes";
    settings."colors-dark".alpha = 0.9;
  };

  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  swapDevices = [{
    device = "/var/lib/swapfile";
    size = 33 * 1024;
  }];

  programs.zsh.enable = true;

  users.users.nixuser = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ]; 
    packages = with pkgs; [
      tree
    ];
    shell = pkgs.zsh;
  };

  nixpkgs.config.allowUnfree = true;

  programs.steam.enable = true;

  services.tlp = {
  enable = true;

  settings = {
    START_CHARGE_THRESH_BAT0 = 75;
    STOP_CHARGE_THRESH_BAT0 = 80;
    CPU_SCALING_GOVERNOR_ON_AC = "powersave";
    CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

    CPU_ENERGY_PERF_POLICY_ON_AC = "power";
    CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

    PLATFORM_PROFILE_ON_AC = "low-power";
    PLATFORM_PROFILE_ON_BAT = "low-power";
    };
  };

  services.openssh.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 53317 ];
  services.tailscale.enable = true;
  networking.firewall.trustedInterfaces = [ "tailscale0" ];

  environment.systemPackages = with pkgs; [
    git
    librewolf
    fastfetch
    fuzzel
    godot
    tmux
    ripgrep
    fd
    bat
    btop
    wl-clipboard
    playerctl
    python3
    gcc
    gnumake
    gdb
    cmake
    clang-tools
    tlp
    steam
  ];
  

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "26.05"; # Did you read the comment?

}
