{ username, ... }:

{
  services.bitcoind = {
    enable = true;
    # configFile = ./bitcoin.conf;
    # port = 8332;
  };

  services.clightning.enable = true;

}
