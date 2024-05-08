{ pkgs, hosts, ... }:
{
  # hosts.nixosModule {
  #   networking.stevenBlackHosts = {
  #     enable = true;
  #     # blockFakenews = true;
  #     # blockGambling = true;
  #     # blockPorn = true;
  #     # blockSocial = true;
  #   };
  # };

  # systemd.services.update-hosts = {
  #   description = "Update /etc/hosts with StevenBlack's hosts";
  #   wantedBy = [ "multi-user.target" ];
  #   after = [ "network.target" ];
  #   serviceConfig.Type = "oneshot";
  #   serviceConfig.ExecStart = "${pkgs.curl}/bin/curl -o /etc/hosts https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts";
  #   path = [ pkgs.curl ];
  # };
  # system.activationScripts = {
  #   update-hosts = pkgs.lib.stringAfter [ "networking" ] ''
  #     systemctl start update-hosts.service
  #   '';
  # };
}
