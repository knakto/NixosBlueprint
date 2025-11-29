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
}
