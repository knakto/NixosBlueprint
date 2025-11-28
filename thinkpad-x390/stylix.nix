{
  pkgs,
  inputs,
  ...
}: let
  inherit (inputs) stylix;
in {
	# 1. ติดตั้ง Font: เอาเฉพาะตัวหลักที่ "ต้องมี" และ "มีแน่ๆ"
  fonts.packages = with pkgs; [
    noto-fonts            # รองรับภาษาไทย + อังกฤษ + ทั่วโลก
    noto-fonts-cjk-sans   # จีน ญี่ปุ่น เกาหลี
    noto-fonts-color-emoji # ตัวแก้ Emoji สี่เหลี่ยม 💩
    nerd-fonts.jetbrains-mono # ไอคอน Dev
  ];

  # 2. Config ให้ระบบเลือกใช้ Noto เป็นหลัก
  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [ "Noto Serif" "Noto Serif Thai" ];
      sansSerif = [ "Noto Sans" "Noto Sans Thai" ]; 
      monospace = [ "JetBrainsMono Nerd Font" "Noto Sans Mono" ];
    };
    allowBitmaps = false;
    antialias = true;
  };

  # 3. Config Stylix (ชี้ไปที่ Noto ทั้งหมด)
  stylix = {
    image = ../images/1138398.jpg; 
    polarity = "dark";
    
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 24;
    };
    
    fonts = {
      # ใช้ Noto ทั้งหมด (มันมีภาษาไทยในตัว)
      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif"; 
      };
      
      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };
      
      monospace = {
        package = pkgs.nerd-fonts.jetbrains-mono;
        name = "JetBrainsMono Nerd Font";
      };
      
      sizes = {
        terminal = 14;
        applications = 12;
        desktop = 12;
        popups = 12;
      };
    };
  };
}
