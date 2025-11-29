{pkgs, ...}: {
  home.packages = with pkgs; [
    kdePackages.dolphin
    kdePackages.kio-extras # รองรับ SMB, SFTP, MTP (Android)
    kdePackages.kio-admin # เพิ่มเมนู "Open as Administrator"
    kdePackages.ffmpegthumbs # ให้โชว์ภาพตัวอย่างไฟล์วิดีโอ
    kdePackages.kdegraphics-thumbnailers # โชว์ภาพ PDF/PS
    kdePackages.qtwayland
    kdePackages.qtsvg # แก้ปัญหาไอคอนบางตัวไม่ขึ้น
    imv
  ];
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = ["org.kde.dolphin.desktop"];
    };
  };
}
