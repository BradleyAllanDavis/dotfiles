{ pkgs, ... }:
{
  home = {
    file = {
      ".tmux.conf".source = ./tmux.conf;
      # ".tmux/linux.conf".source = ./linux.conf;
      # ".tmux/mac.conf".source = ./mac.conf;
      # ".tmux/remote.conf".source = ./remote.conf;
      # ".tmux/snapshot.conf".source = ./snapshot.conf;
      # ".tmux/tpm.conf".source = ./tpm.conf;
    };
  };
  programs.tmux = {
    enable = true;
    # shell = "${pkgs.bash}/bin/bash";
    # terminal = "tmux-256color";
    terminal = "xterm-256color";
    historyLimit = 100000;
    plugins = with pkgs; [
      # tmuxPlugins.tmux-nvim
      # tmuxPlugins.tmux-thumbs

      tmuxPlugins.tmux-colors-solarized
      tmuxPlugins.vim-tmux-navigator
      tmuxPlugins.vim-tmux-focus-events

      # # TODO: why do I have to manually set this
      # {
      #   plugin = t-smart-manager;
      #   extraConfig = ''
      #     set -g @t-fzf-prompt '  '
      #     set -g @t-bind "T"
      #   '';
      # }
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

      tmuxPlugins.sensible
      tmuxPlugins.prefix-highlight
      # {
      #   plugin = tmuxPlugins.prefix-highlight;
      #   extraConfig = ''
      #     set -g status-left '#{prefix_highlight}'
      #   '';
      # }
      {
        plugin = tmuxPlugins.resurrect;
        extraConfig = ''
          # set -g @plugin 'tmux-plugins/tmux-resurrect'
          set -g @resurrect-strategy-vim 'session'
          set -g @resurrect-strategy-nvim 'session'
          set -g @resurrect-save-bash-history 'on'
          set -g @resurrect-capture-pane-contents 'on'
          # set -g @resurrect-save 'S'
          # set -g @resurrect-restore 'R'
        '';
      }
      {
        plugin = tmuxPlugins.continuum;
        extraConfig = ''
          set -g @continuum-restore 'on'
          set -g @continuum-kill-default 'on'
          set -g @continuum-save-interval '5'
          set -g @continuum-boot 'on'
          set -g @continuum-boot-options 'iterm'
        '';
      }
      tmuxPlugins.better-mouse-mode
      # tmuxPlugins.yank
      # tmuxPlugins.open
      # tmuxPlugins.logging
      # tmuxPlugins.battery
    ];
    # extraConfig = ''
    # '';
  };
}
