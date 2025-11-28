{ pkgs, ... }: {

  # ลงโปรแกรมจัดการ Bluetooth แบบ GUI เพิ่ม (กดไอคอนแล้วเด้งหน้านี้)
  home.packages = [ pkgs.blueman ];

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
        modules-left = [ "hyprland/workspaces" "cpu" "memory" ];
        modules-center = [ "clock" ];
        modules-right = [ "pulseaudio" "backlight" "bluetooth" "network" "battery" "tray" "custom/power" ];

        # --- Modules เดิม (Workspaces, Cpu, Mem, Clock, Network, Pulse) ---
        # (ก๊อปของเดิมมาใส่ตรงนี้ได้เลย ผมละไว้เพื่อความสั้นนะครับ)
        "hyprland/workspaces" = {
             format = "{icon}";
             format-icons = {
               "1" = ""; "2" = ""; "3" = ""; "4" = ""; "5" = "";
               "urgent" = ""; "focused" = ""; "default" = "";
             };
        };
        "clock" = { format = " {:%H:%M}"; tooltip-format = "<tt><small>{calendar}</small></tt>"; };
        "pulseaudio" = { format = "{icon} {volume}%"; format-icons = { default = ["" ""]; }; on-click = "pavucontrol"; };
        "cpu" = { format = " {}%"; };
        "memory" = { format = " {}%"; };
        "network" = { format-wifi = "  {essid}"; format-ethernet = " Wired"; format-disconnected = " Off"; };
        "custom/power" = { format = "⏻"; on-click = "wlogout"; };


        # --- 🔥 ของใหม่ที่เพิ่มเข้ามา 🔥 ---

        "backlight" = {
          # ไอคอนหลอดไฟ เปลี่ยนตามระดับแสง
          format = "{icon} {percent}%";
          format-icons = ["" "" "" "" "" "" "" "" ""];
          tooltip = false;
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
        font-family: "JetBrainsMono Nerd Font", "Kanit", sans-serif;
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
    '';
  };
}
