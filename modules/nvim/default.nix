{ ... }:
{
  home = {
    file = {
      ".config/nvim/coc-settings.json".source = ./coc-settings.json;
      ".config/nvim/init.vim".source = ./vimrc;
      ".ideavimrc".source = ./ideavimrc;
      ".vimrc".source = ./vimrc;
    };
  };
}
