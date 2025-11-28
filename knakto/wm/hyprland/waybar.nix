{pkgs, ...}: {
  # ลงโปรแกรมจัดการ Bluetooth แบบ GUI เพิ่ม (กดไอคอนแล้วเด้งหน้านี้)
  home.packages = with pkgs; [
    blueman
    wlogout
  ];

	imports = [./rofi.nix];

  programs.waybar = {
    enable = true;

    settings = {
      mainBar = {
        # ... (Config พื้นฐานเดิม: position, height, spacing คงไว้เหมือนเดิม) ...
        layer = "top";
        position = "top";
        height = 36;
        margin-top = 6;
        margin-left = 10;
        margin-right = 10;
        spacing = 4;

        # จัดลำดับใหม่: เอาแสงกับ BT มาแทรก
        modules-left = ["hyprland/workspaces" "cpu" "memory"];
        modules-center = ["clock"];
        modules-right = ["group/audio" "group/light" "bluetooth" "network" "battery" "tray" "custom/power"];

        # --- Modules เดิม (Workspaces, Cpu, Mem, Clock, Network, Pulse) ---
        # (ก๊อปของเดิมมาใส่ตรงนี้ได้เลย ผมละไว้เพื่อความสั้นนะครับ)
        "hyprland/workspaces" = {
          format = "{icon}";
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "";
            "urgent" = "";
            "focused" = "";
            "default" = "";
          };
        };
        "clock" = {
          format = " {:%H:%M}";
          tooltip-format = "<tt><small>{calendar}</small></tt>";
        };
        "pulseaudio" = {
          format = "{icon} {volume}%";
          format-icons = {default = ["" ""];};
          on-click = "pavucontrol";
        };
        "group/audio" = {
          orientation = "horizontal";
          drawer = {
            transition-duration = 500; # ความเร็ว Animation (ms)
            children-class = "audio-slider"; # ชื่อ class ไว้แต่ง CSS
            transition-left-to-right = false; # false = เด้งไปทางซ้าย
          };
          modules = [ "pulseaudio" "pulseaudio/slider" ];
        };
        "pulseaudio/slider" = {
          min = 0;
          max = 100;
          orientation = "horizontal";
        };
        "cpu" = {format = " {}%";};
        "memory" = {format = " {}%";};
        "network" = {
          format-wifi = "  {essid}";
          format-ethernet = " Wired";
          format-disconnected = " Off";
          tooltip-format = "{ifname} via {gwaddr}";
          on-click = "wifi-menu";
        };
        "custom/power" = {
          format = "⏻";
          on-click = "wlogout";
        };

        "backlight" = {
          # ไอคอนหลอดไฟ เปลี่ยนตามระดับแสง
          format = "{icon} {percent}%";
          format-icons = ["" "" "" "" "" "" "" "" ""];
          tooltip = false;
        };
        "group/light" = {
          orientation = "horizontal";
          drawer = {
            transition-duration = 500;
            children-class = "light-slider";
            transition-left-to-right = false;
          };
          modules = [ "backlight" "backlight/slider" ];
        };
        # ตัว Slider แสง
        "backlight/slider" = {
          min = 0;
          max = 100;
          orientation = "horizontal";
        };

        "bluetooth" = {
          format = " On";
          format-disabled = " Off";
          format-connected = " {device_alias}"; # โชว์ชื่อหูฟังที่ต่ออยู่
          format-connected-battery = " {device_alias} {device_battery_percentage}%"; # โชว์แบตหูฟัง

          # คลิกขวาเพื่อเปิดตัวจัดการ Bluetooth
          on-click = "blueman-manager";
          tooltip-format = "{controller_alias}\t{controller_address}\n\n{num_connections} connected\n\n{device_enumerate}";
        };

        "battery" = {
          # Config นี้เผื่อไว้สำหรับเครื่องไม่มีแบต
          states = {
            warning = 30;
            critical = 15;
          };
          format = "{icon} {capacity}%";

          # ถ้าแบตเต็ม/ชาร์จอยู่ ก็โชว์ปกติ
          format-charging = " {capacity}%";
          format-plugged = " {capacity}%";

          # 🔥 ถ้าแบตหมด/ถอดแบต (Unknown/Empty) ให้โชว์หัวกะโหลกตามขอ 💀
          format-icons = ["💀" "" "" "" "" ""];
        };
      };
    };

    # --- CSS Styling (เพิ่ม backlight กับ bluetooth เข้าไปในกลุ่ม) ---
    style = ''
         * {
      font-family: "JetBrainsMono Nerd Font", "Noto Color Emoji", "Garuda", sans-serif;
           font-weight: bold;
           min-height: 0;
         }

         window#waybar { background: transparent; }

         /* เพิ่ม #backlight กับ #bluetooth เข้าไปใน List นี้ */
         #workspaces, #cpu, #memory, #clock, #network, #pulseaudio, #battery, #tray, #custom-power, #backlight, #bluetooth {
           background-color: #1e1e2e;
           color: #cdd6f4;
           padding: 0 15px;
           border-radius: 15px;
           margin: 0 4px;
           border: 2px solid #313244;
         }

         /* สีเฉพาะของ module ใหม่ (ถ้าอยากแยกสี) */
         #bluetooth.connected {
           color: #89b4fa; /* สีฟ้าเมื่อต่อหูฟัง */
           border-color: #89b4fa;
         }

         #backlight {
           color: #f9e2af; /* สีเหลืองนวลๆ เหมือนแสงไฟ */
         }

         /* แบตเตอรี่สไตล์ Dead Battery */
         #battery.critical:not(.charging) {
           background-color: #f38ba8;
           color: #11111b;
           animation-name: blink;
           animation-duration: 0.5s;
           animation-iteration-count: infinite;
         }

         @keyframes blink { to { background-color: #f38ba8; color: #181825; } }

         /* แต่งตัวกล่องลิ้นชัก (Drawer) */
      #group-audio, #group-light {
        /* ให้สีเหมือนก้อนอื่นๆ แต่เวลา Hover อาจจะเปลี่ยนสีได้ */
        background-color: #1e1e2e;
        color: #cdd6f4;
        border: 2px solid #313244;
        border-radius: 15px;
        padding: 0 5px; /* ลด padding ลงหน่อยเพราะสไลเดอร์กินที่ */
        margin: 0 4px;
      }
      
      /* ลบขอบของ module ข้างใน (เพราะเรามีขอบที่ group แล้ว) */
      #pulseaudio, #backlight {
        background-color: transparent;
        border: none;
        padding: 0 10px;
        margin: 0;
      }

      /* --- 🎨 แต่งตัว Slider (สำคัญมาก) --- */
      
      /* ตัวราง (Trough) */
      #pulseaudio-slider trough, #backlight-slider trough {
        min-height: 10px;    /* ความหนาของราง */
        min-width: 80px;     /* ความยาวของราง */
        border-radius: 5px;
        background-color: #313244; /* สีรางพื้นหลัง */
        margin-right: 10px;
      }
      
      /* ตัวไฮไลท์ (Highlight) - ส่วนที่เลื่อนไปแล้ว */
      #pulseaudio-slider highlight {
        border-radius: 5px;
        background-color: #89b4fa; /* สีฟ้าสำหรับเสียง */
      }
      
      #backlight-slider highlight {
        border-radius: 5px;
        background-color: #f9e2af; /* สีเหลืองสำหรับแสง */
      }
      
      /* ตัวก้อนกลมๆ ที่ใช้ลาก (Slider Handle) */
      #pulseaudio-slider slider, #backlight-slider slider {
        min-height: 0px;
        min-width: 0px;
        border-radius: 50%;
        background-color: #ffffff; /* สีขาว */
        box-shadow: none;
        margin: 0;
      }
    '';
  };
}
