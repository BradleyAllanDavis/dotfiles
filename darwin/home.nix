{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.users.bradley = { pkgs, ... }: {
    programs.home-manager.enable = true;

    home.stateVersion = "22.11";

    home.username = "bradley";
    # home.homeDirectory = "/Users/bradley";

    #xdg.enable = true;
    #xdg.configHome = "/home/bradley/.config";

    manual.manpages.enable = false;

    # Raw config files to link to $HOME
    home.file.".ackrc".source = ../../config/ackrc;

    home.packages = with pkgs; [
      git-crypt
      entr
      lsd
    ];

    # programs.tmux = { # my tmux configuration, for example
    #   enable = true;
    #   keyMode = "vi";
    #   clock24 = true;
    #   historyLimit = 10000;
    #   plugins = with pkgs.tmuxPlugins; [
    #     vim-tmux-navigator
    #     gruvbox
    #   ];
    #   extraConfig = ''
    #     new-session -s main
    #     bind-key -n C-a send-prefix
    #   '';
    # };
  };

}
