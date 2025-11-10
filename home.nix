{ config, lib, pkgs, ... }:

{
  imports = [
    ./modules/hyprland.nix
    ./modules/waybar.nix
    ./modules/themes.nix
    ./modules/programs.nix
  ];


  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
  "google-chrome"
  "microsoft-edge"
];
  # Basic packages
  home.packages = with pkgs; [
    # Core utilities
    mat2
    protonvpn-gui
    tree
    curl
    wget
    firefox
    fastfetch
    spotify
    telegram-desktop
    microsoft-edge
       nodejs
    git
    neovim
    docker
    alacritty
    google-chrome
    chromium
    unzip
    discord
    # Media
    mpv
    kdePackages.dolphin
    # System tools
    dunst

      wofi
   # hyprpaper
    #hyprland-protocols
    #grimblast
  ];

  programs.gurk-rs.enable = lib.mkDefault false;

  home.stateVersion = "25.11";
}
