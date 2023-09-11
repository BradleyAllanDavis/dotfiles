{ ... }:
{
  home = {
    file = {
      ".bash_logout".source = ./bash_logout;
      ".bash_profile".source = ./bash_profile;
      ".bashrc".source = ./bashrc;
      ".bash/aliases".source = ./aliases;
      ".bash/environment".source = ./environment;
      ".bash/functions".source = ./functions;
      ".bash/fzf".source = ./fzf;
      ".bash/linux".source = ./linux;
      ".bash/macOS".source = ./macOS;
      ".bash/okcoin".source = ./okcoin;
      ".bash/old_prompt".source = ./old_prompt;
      ".bash/solarized".source = ./solarized;
      ".bash/ssh".source = ./ssh;
    };
  };
}
