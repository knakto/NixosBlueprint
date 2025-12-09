{
  inputs,
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    # inputs.caelestia-shell.packages.x86_64-linux.default
    # swaylock-effects
    # swayidle
    swww
    fuzzel
    slurp
    grim
    wl-clipboard
    # hyprcursor
    # bibata-cursors
  ];
}
