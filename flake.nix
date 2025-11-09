{
  description = "Simple NixOS Configuration with Hyprland Legacy Renderer and Qtile Fallback";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    
     home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";
    in {
      nixosConfigurations."imdead" = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./configuration.nix  # Your main config with Hyprland and Qtile
          home-manager.nixosModules.home-manager
        #  hyprland.nixosModules.default  # Official Hyprland module

          home-manager.nixosModules.home-manager
          ({ config, lib, ... }: {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.imdead = import ./home.nix;
            };
               })
                    ];
      };
    };
}
