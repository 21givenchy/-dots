{ config, lib, pkgs, ... }:

{
  # Git configuration
  programs.git = {
    enable = true;
    userName = "imdead";
    userEmail = "user@example.com";  # Update with your email
    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = false;
    };
  };
  
  # Alacritty terminal
  programs.alacritty = {
    enable = true;
    settings = {
      window = {
        padding = {
          x = 10;
          y = 10;
        };
        opacity = 0.9;
      };
      font = {
        normal = {
          family = "FiraCode Nerd Font";
          style = "Regular";
        };
        size = 11.0;
      };
      colors = {
        primary = {
          background = "0x1e1e2e";
          foreground = "0xcdd6f4";
        };
      };
    };
  };
  
  # Zsh shell
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    
    shellAliases = {
      ll = "ls -lah";
      update = "sudo nixos-rebuild switch --flake .#imdead";
      nix-clean = "nix-collect-garbage -d";
    };
    
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "docker" "sudo" ];
      theme = "robbyrussell";
    };
  };
  
  # Neovim
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };
}
