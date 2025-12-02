{ config, pkgs, ... }:

{
  swapDevices = [ {
    device = "/var/lib/swapfile";
    size = 16384;
  } ];
}
