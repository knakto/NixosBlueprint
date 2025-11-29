{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./package.nix
    ./waybar.nix
  ];
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.package = inputs.hyprland.packages.${pkgs.system}.hyprland;
  wayland.windowManager.hyprland.settings = {
    xwayland = {
      force_zero_scaling = true;
      use_nearest_neighbor = true;
    };
    general = {
      # gaps_in = 14;
      gaps_out = 9;
      border_size = 2;
      layout = "dwindle";
      resize_on_border = true;
    };
    decoration = {
      rounding = 8;
    };
    exec-once = [
      # "hibernate.sh"
      # "caelestia shell"
      "waybar"
    ];
    monitor = [
      # monitor = ชื่อจอ, ความละเอียด, ตำแหน่ง, scale
      "eDP-1,1920x1080@60,0x0,1.2"
      # เผื่อเสียบจออื่นให้มัน Auto ไป
      ",preferred,auto,1"
    ];
    input = {
      kb_layout = "us,th";
      kb_options = "grp:win_space_toggle";
    };
    animations = {
      bezier = [
        "smooth, 0.14, 0.03, 0.09, 1"
        "ease, 0.25, 0.1, 0.25, 1"
        "ease-win, 0.27, 0.27, 0, 1.01"
      ];
      animation = [
        "windows, 1, 2, ease-win"
        "windowsOut, 1, 2, default, popin 100%"
        "border, 1, 7, smooth"
        "borderangle, 1, 8, default"
        "workspaces, 1, 2, ease"
      ];
    };

    "$mod" = "SUPER";

    inherit (import ./binding.nix) bind;
    inherit (import ./binding.nix) bindel;
    inherit (import ./binding.nix) bindl;
    inherit (import ./binding.nix) bindm;

	inherit (import ./plugins.nix) "plugin:hyprexpo";
	inherit (import ./plugins.nix) "plugin:dynamic-cursors";
	inherit (import ./plugins.nix) "plugin:hyprfocus";
  };
  wayland.windowManager.hyprland.plugins = [
    # pkgs.hyprlandPlugins.PLUGIN_NAME
    # hypr-dynamic-cursors
    # hyprbars
    # hyprexpo
    # hyprfocus
    inputs.hyprfocus.packages.${pkgs.system}.hyprfocus
    inputs.hypr-dynamic-cursors.packages.${pkgs.system}.hypr-dynamic-cursors
    inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
  ];
}
