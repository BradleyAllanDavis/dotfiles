{ ... }:
{
  home = {
    file = {
      ".config/polybar/config".source = ./config;
      ".config/polybar/launch.sh".source = ./launch.sh;
      ".config/polybar/weather.py".source = ./weather.py;
    };
  };
}
