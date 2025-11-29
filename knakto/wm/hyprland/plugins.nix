{
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

  "plugin:hyprfocus" = {
    enabled = true;

    # Focus Animation
    animate_floating = true;
    animate_workspacechange = true;
    focus_animation = "shrink"; # รูปแบบ: shrink, flash, flash_dim

    # Bezier Curve (ความสมูท)
    bezier = [
      "bezIn, 0.5,0.0,1.0,0.5"
      "bezOut, 0.0,0.5,0.5,1.0"
      "overshot, 0.05, 0.9, 0.1, 1.05"
      "smoothOut, 0.36, 0, 0.66, -0.56"
      "smoothIn, 0.25, 1, 0.5, 1"
      "realsmooth, 0.28,0.29,0.69,1.08"
    ];

    # Config ของ Flash effect
    flash = {
      flash_opacity = 0.7;
      in_bezier = "realsmooth";
      in_speed = 0.5;
      out_bezier = "realsmooth";
      out_speed = 3;
    };

    # Config ของ Shrink effect (หน้าต่างหดแล้วขยาย)
    shrink = {
      shrink_percentage = 0.95;
      in_bezier = "realsmooth";
      in_speed = 1;
      out_bezier = "realsmooth";
      out_speed = 2;
    };
  };
}
