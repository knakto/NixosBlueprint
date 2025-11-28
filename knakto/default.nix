{
  pkgs,
  lib,
  ...
}: {
  # nixpkgs.config.allowBroken = true;
  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "google-chrome"
      "minecraft-launcher"
      "obsidian"
      "steam"
      "steam-unwrapped"
      "unityhub"
      "spotify"
      "copilot.vim"
      "corefonts"
	"vscode"
    ];
  imports = [
    ./wm/i3
    # ./env.nix
    # ./package.nix
    # ./config/kitty
    # ./config/neovim
    ./software/nvf
    # ./config/shell
    # ./config/git
    # ./config/fastfetch
    # ./config/hyprland
    # ./config/zen
  ];
  home = {
    username = "knakto";
    homeDirectory = "/home/knakto";
    stateVersion = "24.11";
  };
}
