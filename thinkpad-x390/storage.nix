{ config, pkgs, ... }:

{
  swapDevices = [ {
    device = "/var/lib/swapfile";
    size = 8192; # ขนาดหน่วยเป็น MB (ใส่ไป 8GB เลยครับ กันเหนียวตอน compile)
  } ];
}
