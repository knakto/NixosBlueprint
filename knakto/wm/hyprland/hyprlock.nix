{self, pkgs, ...}: {
  # ถ้า Stylix แย่งซีน (มันชอบ gen config ทับ) ให้ปิด target นี้
  # stylix.targets.hyprlock.enable = false;

  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        no_fade_in = false;
        grace = 0;
        disable_loading_bar = true;
      };

      # 1. พื้นหลัง (เอา Wallpaper มาเบลอ)
      background = [
        {
          path = "${self}/images/1148498.jpg"; # ⚠️ เช็ค Path รูปให้ตรงเป๊ะๆ นะครับ!
          blur_passes = 2; # เบลอ 2 ชั้น (ยิ่งเยอะยิ่งนวล แต่กิน GPU)
          contrast = 0.8916;
          brightness = 0.8172;
          vibrancy = 0.1696;
          vibrancy_darkness = 0.0;
        }
      ];

      # 2. ช่องใส่รหัส (Input Field)
      input-field = [
        {
          size = "250, 60";
          position = "0, -20";
          monitor = "";
          dots_center = true;
          fade_on_empty = false;
          font_color = "rgb(202, 211, 245)";
          inner_color = "rgb(30, 30, 46)"; # พื้นหลังช่อง
          outer_color = "rgb(137, 180, 250)"; # ขอบสีฟ้า
          outline_thickness = 2;
          placeholder_text = "<i>Password...</i>";
          shadow_passes = 2;
        }
      ];

      # 3. นาฬิกาตัวใหญ่ (Label)
      label = [
        {
          text = "$TIME";
          color = "rgb(205, 214, 244)";
          font_size = 120;
          font_family = "JetBrainsMono Nerd Font Bold";
          position = "0, -300"; # ขยับขึ้นไปข้างบน
          halign = "center";
          valign = "top";
        }
        {
          text = "Hi there, Knakto";
          color = "rgb(205, 214, 244)";
          font_size = 25;
          font_family = "JetBrainsMono Nerd Font";
          position = "0, -130";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
