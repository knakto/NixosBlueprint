{
  bind = [
    "$mod, return, exec, fuzzel --hide-before-typing --lines 3"
    "$mod, Q, killactive"
    "$mod, F, togglefloating"
    "$mod, G, togglegroup"
    "$mod, M, fullscreen, 0"
    "$mod, S, exec, search.sh"
    "$mod SHIFT, S, exec, search.sh newtab"

    "$mod, A, workspace, r-1"
    "$mod, D, workspace, r+1"
    "$mod SHIFT, A, movetoworkspace, r-1"
    "$mod SHIFT, D, movetoworkspace, r+1"

    "$mod, H, movefocus, l"
    "$mod, H, bringactivetotop,"
    "$mod, L, movefocus, r"
    "$mod, L, bringactivetotop,"
    "$mod, K, movefocus, u"
    "$mod, K, bringactivetotop,"
    "$mod, J, movefocus, d"
    "$mod, J, bringactivetotop,"

    # "$mod, G, hyprexpo:expo, toggle"

    "CTRL ALT, T, exec, kitty"
    # "CTRL ALT, L, exec, swaylock"
    "CTRL ALT, L, exec, hyprlock"

    "ALT, ESCAPE, exec, poweroff"
    "ALT, M, submap, movewindow"

    ", XF86AudioRaiseVolume, exec, pamixer -i 5" # เพิ่มเสียง 5%
    ", XF86AudioLowerVolume, exec, pamixer -d 5" # ลดเสียง 5%
    ", XF86AudioMute, exec, pamixer -t"          # ปิดเสียง
    ", XF86AudioMicMute, exec, pamixer --default-source -t" # ปิดไมค์

    # เพิ่มแสง 5%
    ", XF86MonBrightnessUp, exec, brightnessctl set +5%"
    # ลดแสง 5% (แต่ไม่ให้ต่ำกว่า 1% กันจอดับมืดตึ๊ด)
    ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
  ];

  bindel = [
    ", XF86AudioRaiseVolume, exec, ~/.config/hypr/scripts/volume.sh raise"
    ", XF86AudioLowerVolume, exec, ~/.config/hypr/scripts/volume.sh lower"
    ", XF86MonBrightnessUp, exec, brightnessctl -d intel_backlight set +2%"
    ", XF86MonBrightnessDown, exec, brightnessctl -d intel_backlight set 2%-"
  ];
  bindl = [
    ", XF86AudioMute, exec, ~/.config/hypr/scripts/volume.sh mute"
  ];
  bindm = [
    "$mod, mouse:272, movewindow"
    "$mod, mouse:273, resizewindow"
  ];
}
