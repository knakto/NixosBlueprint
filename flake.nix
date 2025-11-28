{
  description = "NixosBlueprint";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
    nvf = {
      url = "github:notashelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";
    hyprland.url = "github:hyprwm/Hyprland";
    stylix.url = "github:danth/stylix";
  };

  outputs = {self, ...} @ inputs: let
    inherit (self) outputs; #update outputs = self.outputs for get all output
    inherit (inputs.nixpkgs) lib;
    pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
  in {
    homeConfigurations = {
      knakto = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {inherit self inputs outputs;};
        modules = [
          # ./home/home.nix
          # inputs.nvf.homeManagerModules.default
          # inputs.caelestia-shell.homeManagerModules.default
        ];
      };
    };

    nixosConfigurations = {
      thinkpad-x390 = lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit self inputs outputs;};
        modules = [
          # ./host/config.nix
          # inputs.home-manager.nixosModules.home-manager
          # inputs.nixos-hardware.nixosModules.lenovo-thinkpad-x390
          # inputs.nix-flatpak.nixosModules.nix-flatpak
        ];
      };
    };
  };
}
