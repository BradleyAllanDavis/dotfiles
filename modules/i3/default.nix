{ ... }:
{
  home = {
    file = {
      ".config/i3/config".source = ./config;
      ".config/i3/exit_menu.sh".source = ./exit_menu.sh;
      ".config/i3/fromhere.sh".source = ./fromhere.sh;
      ".config/i3/lock.sh".source = ./lock.sh;
      ".config/i3/lock2.sh".source = ./lock2.sh;
      ".config/i3/pad.png".source = ./pad.png;
    };
  };
}
