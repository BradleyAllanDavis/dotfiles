{ ... }:
{
  home = {
    file = {
      ".tmux.conf".source = ./tmux.conf;
      ".tmux/linux.conf".source = ./linux.conf;
      ".tmux/mac.conf".source = ./mac.conf;
      ".tmux/remote.conf".source = ./remote.conf;
      ".tmux/snapshot.conf".source = ./snapshot.conf;
      ".tmux/tpm.conf".source = ./tpm.conf;
    };
  };
}
