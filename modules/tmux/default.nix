{ pkgs, ... }:
{
  home = {
    file = {
      ".tmux.conf".source = ./tmux.conf;
    };
  };
  programs.tmux = {
    enable = true;
    # shell = "${pkgs.bash}/bin/bash";
    # terminal = "tmux-256color";
    terminal = "xterm-256color";
    historyLimit = 100000;
    plugins = with pkgs; [
      # tmuxPlugins.1password
      tmuxPlugins.better-mouse-mode
      tmuxPlugins.copycat
      tmuxPlugins.fpp
      tmuxPlugins.logging
      tmuxPlugins.open
      tmuxPlugins.sensible
      tmuxPlugins.sidebar
      tmuxPlugins.tmux-colors-solarized
      tmuxPlugins.urlview
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.vim-tmux-focus-events
      tmuxPlugins.yank
      # tmuxPlugins.open
      # tmuxPlugins.logging
      # tmuxPlugins.battery
      # tmuxPlugins.tmux-nvim
      # tmuxPlugins.tmux-thumbs
      # {
      #   plugin = tmux-super-fingers;
      #   extraConfig = "set -g @super-fingers-key f";
      # }
      # {
      #   plugin = tmux-browser;
      #   extraConfig = ''
      #     set -g @browser_close_on_deattach '1'
      #   '';
      # }
      # tmuxPlugins.prefix-highlight
      {
        plugin = tmuxPlugins.prefix-highlight;
        extraConfig = ''
          set -g status-left '#{prefix_highlight}'
        '';
      }
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = ''
          # set -g @resurrect-strategy-vim 'session'
          # set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-save-bash-history 'on'
          set -g @resurrect-capture-pane-contents 'on'
          set -g @resurrect-save 'C-s'
          set -g @resurrect-restore 'C-r'
          # set -g @resurrect-save 'S'
          # set -g @resurrect-restore 'R'
        '';
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-kill-default 'on'
          set -g @continuum-save-interval '1'
          set -g @continuum-boot 'on'
          set -g @continuum-boot-options 'iterm'
        '';
      }
    ];
    # extraConfig = ''
    # '';
  };
}
