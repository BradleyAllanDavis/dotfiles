{ username, ... }:

{
  services.bitcoind.${username} = {
    enable = true;
    configFile = ./bitcoin.conf;
    # port = 8332;
  };

}
