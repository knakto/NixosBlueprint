{
  pkgs,
  inputs,
  ...
}: let
  inherit (inputs) stylix;
in {
  # 1. ติดตั้ง Package Font ที่จำเป็น
  fonts.packages = with pkgs; [
    # ฟอนต์หลักของโลก (Google Noto)
    noto-fonts
    noto-fonts-cjk-sans # ภาษาจีน/ญี่ปุ่น/เกาหลี
    noto-fonts-color-emoji # อิโมจิ 💩

    # ฟอนต์ภาษาไทย (เลือกตัวสวยๆ)
    # kanit
    # sarabun

    # ฟอนต์ที่โปรแกรม Java/Legacy ชอบเรียกหา (สำคัญสำหรับ Minecraft Launcher)
    liberation_ttf # ใช้แทน Arial/Times New Roman
    dejavu_fonts # Java ชอบตัวนี้มาก
    freefont_ttf
  ];

  # 2. ตั้งค่า Default Font (สำคัญ! ไม่งั้นโปรแกรมเลือกไม่ถูก)
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = ["Noto Serif" "Sarabun"];
      sansSerif = ["Noto Sans" "Kanit"];
      monospace = ["JetBrainsMono Nerd Font" "Noto Sans Mono"];
    };
    allowBitmaps = false;

    # บังคับลบเหลี่ยม (Anti-aliasing)
    antialias = true;
  };

  stylix = {
    image = ../images/1138398.jpg; # <-- ชี้ไปที่ไฟล์รูปในเครื่องนาย
    polarity = "dark"; # หรือ "light"
    cursor = {
      package = pkgs.bibata-cursors; # แนะนำตัวนี้! ยอดฮิต เห็นชัด
      name = "Bibata-Modern-Ice"; # สีขาวขอบดำ (Ice) หรือจะเอาสีดำ (Classic) ก็ได้
      size = 24; # ขนาดมาตรฐานคือ 24, ถ้าอยากให้ใหญ่สะใจใส่ 32
    };
  };
  stylix.fonts = {
    serif = {
      package = pkgs.noto-fonts;
      name = "Noto Serif";
    };
    sansSerif = {
      package = pkgs.noto-fonts; # หรือ pkgs.google-fonts.kanit
      name = "Noto Sans"; # หรือ "Kanit"
    };
    monospace = {
      package = pkgs.nerd-fonts.jetbrains-mono;
      name = "JetBrainsMono Nerd Font";
    };
    sizes = {
      terminal = 14; # ปกติ 12
      applications = 12; # ปกติ 10-11
      desktop = 12;
      popups = 12;
    };
  };
}
