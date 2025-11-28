{pkgs, ...}: let
  wifiMenu = pkgs.writeShellScriptBin "wifi-menu" ''
    # 1. สแกนหา Wifi และจัดรูปแบบ
    # (แสดง SSID, ความแรง, และ Security)
    LIST=$(nmcli --fields "SSID,SECURITY,BARS" device wifi list | sed 1d | sed 's/  */ /g')

    # 2. ส่งเข้า Rofi เพื่อให้เลือก
    # (ใช้ Theme เดียวกับที่นายเพิ่งทำไป)
    SELECTED=$(echo "$LIST" | rofi -dmenu -i -p "Wi-Fi" -theme ~/.config/rofi/wifi.rasi | cut -d " " -f1)

    # 3. ถ้ามีการเลือกชื่อ Wifi
    if [ -n "$SELECTED" ]; then
      # เช็คว่าเคยต่อแล้วหรือยัง (Saved Connection)
      if nmcli connection show "$SELECTED" > /dev/null 2>&1; then
        nmcli connection up "$SELECTED"
      else
        # ถ้าเป็น Wifi ใหม่ ให้ถามรหัสผ่าน
        PASS=$(rofi -dmenu -p "Password for $SELECTED" -password -theme ~/.config/rofi/wifi.rasi)
        if [ -n "$PASS" ]; then
          nmcli device wifi connect "$SELECTED" password "$PASS"
        fi
      fi
    fi
  '';
in {
  # 1. ต้องมี rofi-wayland
  home.packages = [
    pkgs.rofi
    wifiMenu
  ];

  # 2. สร้างไฟล์ Theme สำหรับ Wifi/Bluetooth โดยเฉพาะ
  xdg.configFile."rofi/wifi.rasi".text = ''
	/* Config พื้นฐาน */
    configuration {
        font: "JetBrainsMono Nerd Font Bold 12";
        show-icons: true;
        display-drun: "";
        drun-display-format: "{name}";
    }

    /* ตัวหน้าต่างหลัก */
    window {
        transparency: "real";
        background-color: #1e1e2e; /* สีพื้นหลังเข้ม (Catppuccin) */
        text-color: #cdd6f4;
        border: 8px;
        border-color: #89b4fa; /* ขอบสีฟ้า */
        border-radius: 12px;
        width: 350px; /* ความกว้างกำลังดี */
        
        /* 🔥 จัดตำแหน่งให้ลอยขวาบน (Top Right) 🔥 */
        location: northeast; 
        x-offset: -10px;      /* ขยับจากขอบขวานิดนึง */
        y-offset: 40px;       /* ขยับลงมาจาก Waybar */
    }

    /* กล่องค้นหา */
    inputbar {
        background-color: #313244;
        text-color: #cdd6f4;
        padding: 3px;
        border-radius: 2px;
        margin: 10px 10px 0px 10px;
        children: [ prompt, entry ];
    }

    prompt {
        text-color: #89b4fa;
        padding: 0px 10px 0px 0px;
    }

    entry {
        text-color: #cdd6f4;
        placeholder: "Search Network...";
        placeholder-color: #585b70;
    }

    /* รายการ Wifi */
    listview {
        background-color: transparent;
        margin: 10px;
        spacing: 5px;
        lines: 8; /* โชว์แค่ 8 ชื่อ เกินกว่านี้เลื่อนเอา */
        scrollbar: false;
    }

    /* แต่ละบรรทัด */
    element {
        background-color: transparent;
        text-color: #cdd6f4;
        padding: 2px;
        border-radius: 8px;
    }

    /* ตอนเอาเมาส์ชี้ หรือเลือกอยู่ */
    element selected {
        background-color: #89b4fa; /* สีฟ้าไฮไลท์ */
        text-color: #1e1e2e;       /* ตัวหนังสือกลับเป็นสีดำ */
    }

    /* ไอคอน */
    element-icon {
        size: 24px;
        margin-right: 10px;
    }
    
    /* ข้อความ */
    element-text {
        vertical-align: 0.5;
    }
  '';
}
