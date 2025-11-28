{pkgs, ...}: {
  home.pointerCursor = {
    name = "Bibata-Modern-Ice";
    package = pkgs.bibata-cursors;
    size = 24;

    # 2 บรรทัดนี้สำคัญมากสำหรับ GNOME!
    gtk.enable = true;
    x11.enable = true;
  };
}
