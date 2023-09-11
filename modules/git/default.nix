{ ... }:
{
  home = {
    file = {
      ".config/git/config".source = ./config;
      ".config/git/gitconfig-okcoin".source = ./gitconfig-okcoin;
      ".config/git/gitconfig-personal".source = ./gitconfig-personal;
      ".config/git/ignore".source = ./ignore;
    };
  };
}
