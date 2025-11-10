{ config, pkgs, ... }:

{

   nixpkgs.config.allowUnfree = true;

  imports = [ ./hardware-configuration.nix

 ];


  boot.loader = {
    grub.enable = true;
    grub.device = "/dev/sda";
    grub.efiSupport = false;
    systemd-boot.enable = false;
  };

 boot.kernelModules = [ "fuse" ];
 services.gvfs.enable = true;

  networking.hostName = "imdead";
  networking.networkmanager.enable = true;
  networking.firewall.allowedTCPPorts = [ 5432 ];

  hardware.bluetooth.enable = true;
  time.timeZone = "Africa/Nairobi";
  i18n.defaultLocale = "en_US.UTF-8";
services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };
 hardware.alsa.enablePersistence = true;
  services.dbus.enable = true;
  programs.dconf.enable = true;
 users.users.imdead = {
    isNormalUser = true;
    extraGroups = ["bluetoothctl"  "wheel" "networkmanager" "fuse"  "docker" "video" "plugdev" "storage" ];
    shell = pkgs.zsh;
  };
  programs.zsh.enable = true;

  environment.systemPackages = with pkgs; [
       wireplumber   brightnessctl fuse  vim git libsForQt5.qt5ct qt6ct  gvfs bibata-cursors  mtpfs jmtpfs perl538Packages.ImageExifTool
       sbclPackages.selenium arp-scan-rs jetbrains.datagrip
       # Hyprland dependencies
       waybar dunst wofi hyprpaper swww grim slurp wl-clipboard pavucontrol
  ];

  virtualisation.docker = {
  enable = true;
  # Set up resource limits
  daemon.settings = {
    experimental = true;
default-address-pools = [
      {
        base = "172.30.0.0/16";
        size = 24;
      }
    ];
  };
};

  environment.sessionVariables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
    NIXOS_OZONE_WL = "1";
    WLR_RENDERER_ALLOW_SOFTWARE = "1";  # Fallback for legacy rendering issues
  };

  # Fonts (simplified, no override needed)
  fonts = {
    enableDefaultPackages = false;
    fontconfig.enable = true;
    packages = with pkgs; [
      noto-fonts noto-fonts-cjk-sans noto-fonts-emoji font-awesome
      nerd-fonts.fira-code nerd-fonts.droid-sans-mono
    ];
  };
};

  services.displayManager = {
    sddm.enable = true;
    sddm.wayland.enable = true;
    sddm.theme = "breeze";
    defaultSession = "hyprland";
  };
  
  # Enable Hyprland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  services.xserver.enable = true;

  # Qtile fallback
  services.xserver.windowManager.qtile.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];


  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    users.imdead = import ./home.nix;  # Imports your home.nix for user "imdead"
  };
  system.stateVersion = "25.11";
}
