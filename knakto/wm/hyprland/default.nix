{pkgs, ...}: {
  wayland.windowManager.hyprland.enable = true;
  wayland.windowManager.hyprland.settings = {
    # decoration = {
    #   shadow_offset = "0 5";
    #   "col.shadow" = "rgba(00000099)";
    # };

    input = {
      kb_layout = "us,th";
      kb_options = "grp:win_space_toggle";
    };

    "$mod" = "SUPER";

    # bindm = [
    #   # mouse movements
    #   "$mod, mouse:272, movewindow"
    #   "$mod, mouse:273, resizewindow"
    #   "$mod ALT, mouse:272, resizewindow"
    # ];

    inherit (import ./binding.nix) bind;
    inherit (import ./binding.nix) bindel;
    inherit (import ./binding.nix) bindl;
    inherit (import ./binding.nix) bindm;
  };
  # wayland.windowManager.hyprland.plugins = [
    # pkgs.hyprlandPlugins.PLUGIN_NAME
  # ];
}
