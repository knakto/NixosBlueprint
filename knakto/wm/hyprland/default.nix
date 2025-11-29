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

    "plugin:dynamic-cursors" = {
      # เปิดใช้งาน
      enabled = true;
      mode = "tilt";
      threshold = 2; # ความเร็วต่ำสุดที่จะเริ่ม effect

      # ตั้งค่าเฉพาะโหมด stretch (ยืดหด)
      stretch = {
        limit = 3000; # ยืดสูงสุดเท่าไหร่
        function = "quadratic"; # สูตรการยืด (linear, quadratic, negative_quadratic)
      };

      # ตั้งค่าเฉพาะโหมด shake (สั่นเวลาหาเมาส์ไม่เจอ)
      shake = {
        enabled = true;
        nearest = true; # ขยายใหญ่ขึ้นเวลาเขย่าแรงๆ (เหมือน macOS)
        threshold = 5.0;
        base = 4.0;
        speed = 3.0;
        influence = 0.0;
        limit = 0.0;
        timeout = 2000;
        effects = true;
        ipc = false;
      };
    };

    "plugin:hyprexpo" = {
      columns = 3; # จำนวนคอลัมน์ที่จะโชว์
      gap_size = 5; # ช่องว่างระหว่าง Workspace
      bg_col = "rgb(111111)"; # สีพื้นหลังตอนซูมออก (ดำ)
      workspace_method = "center current"; # ให้หน้าปัจจุบันอยู่ตรงกลาง

      # ตั้งค่าการขยับเมาส์/คีย์บอร์ดตอนอยู่ในหน้า Expo
      enable_gesture = true; # ใช้ Touchpad ปัดได้
      gesture_fingers = 3; # ใช้ 3 นิ้วปัด
      gesture_distance = 300;
      gesture_positive = true;
    };
  };
  wayland.windowManager.hyprland.plugins = [
    # pkgs.hyprlandPlugins.PLUGIN_NAME
    # hypr-dynamic-cursors
    # hyprbars
    # hyprexpo
    # hyprfocus
    inputs.hypr-dynamic-cursors.packages.${pkgs.system}.hypr-dynamic-cursors
    inputs.hyprland-plugins.packages.${pkgs.system}.hyprexpo
  ];
}
