{
  pkgs,
  inputs,
  ...
}: let
  inherit (inputs) stylix;
in {
  stylix = {
    image = ../images/1138398.jpg; # <-- ชี้ไปที่ไฟล์รูปในเครื่องนาย
    polarity = "dark"; # หรือ "light"
    cursor = {
      package = pkgs.bibata-cursors; # แนะนำตัวนี้! ยอดฮิต เห็นชัด
      name = "Bibata-Modern-Ice"; # สีขาวขอบดำ (Ice) หรือจะเอาสีดำ (Classic) ก็ได้
      size = 24; # ขนาดมาตรฐานคือ 24, ถ้าอยากให้ใหญ่สะใจใส่ 32
    };
  };
}
