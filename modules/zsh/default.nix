{ ... }:
{
  home = {
    file = {
      ".config/zsh/zlogin".source = ./zlogin;
      ".config/zsh/zlogout".source = ./zlogout;
      ".config/zsh/zprofile".source = ./zprofile;
      ".config/zsh/zshenv".source = ./zshenv;
      ".zshrc".source = ./zshrc;
    };
  };
}
