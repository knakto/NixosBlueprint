{pkgs, ...}: {
  home.packages = with pkgs; [
    lazygit
    tig
  ];
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "knakto";
        email = "kasichonooo@gmail.com";
      };
    };
  };
}
