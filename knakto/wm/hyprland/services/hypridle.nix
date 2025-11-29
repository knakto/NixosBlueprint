{pkgs, ...}: {
  imports = [
    ./services/hypridle.nix
  ];

  services.hypridle = {
    enable = true;

    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock"; # คำสั่งล็อค
        before_sleep_cmd = "loginctl lock-session"; # ล็อคก่อนเข้า Sleep เสมอ
        after_sleep_cmd = "hyprctl dispatch dpms on"; # ตื่นแล้วเปิดจอทันที
      };

      listener = [
        # 1. เตือนด้วยการหรี่แสง (2.5 นาที)
        {
          timeout = 150;
          on-timeout = "brightnessctl -s set 10"; # จำค่าเดิมไว้ (-s) แล้วลดเหลือ 10
          on-resume = "brightnessctl -r"; # คืนค่าเดิม (-r)
        }

        # 2. ล็อคหน้าจอ (5 นาที)
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }

        # 3. ปิดจอ (5.5 นาที)
        {
          timeout = 330;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }

        # 4. Suspend เครื่อง (10 นาที) - เฉพาะตอนถอดสายชาร์จจะดีมาก แต่อันนี้ตั้งรวมไปก่อน
        {
          timeout = 600;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };
}
