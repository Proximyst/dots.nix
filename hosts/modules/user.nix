{ lib, config, ... }:

let
  cfg = config.modules.user;
in
with lib;
{
  options.modules.user = {
    name = mkOption {
      description = "the user's username";
      example = "mariell";
      type = types.str;
    };
    home = mkOption {
      description = "the user's home directory";
      example = "/home/mariell";
      type = types.path;
    };
    extraGroups = mkOption {
      description = "any additional groups the user should be in";
      example = [ "wheel" ];
      type = types.listOf types.str;
    };
  };

  config = {
    users.users.${cfg.name} = {
      home = cfg.home;
      isNormalUser = true;
      extraGroups = cfg.extraGroups;
    };
  };
}
