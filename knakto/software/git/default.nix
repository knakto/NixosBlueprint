{pkgs, ...}: {
  home.packages = with pkgs; [
    lazygit
    tig
  ];
  programs.git = {
    enable = true;
    settings = {
      push.autoSetupRemote = true;
      user = {
        name = "knakto";
        email = "kasichonooo@gmail.com";
      };
    };
  };
}
