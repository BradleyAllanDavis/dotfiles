{ ... }:
{
  home = {
    file = {
      ".ssh/config".source = ./config;
      ".ssh/generate_ssh_key_okcoin.sh".source = ./generate_ssh_key_okcoin.sh;
      ".ssh/generate_ssh_key_personal.sh".source = ./generate_ssh_key_personal.sh;
    };
  };
}
