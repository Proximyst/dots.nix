{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    policies = {
      DefaultDownloadDirectory = "\${home}/downloads";
      layout.spellcheckDefault = 0;
    };
    profiles.mariell = {
      id = 0;
      isDefault = true;
      name = "mariell";
      search.default = "Google";
      search.engines = {
        Google.metaData = { };
        Bing.metaData.hidden = true;

        "Nix Packages" = {
          icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
          definedAliases = [ "@np" ];
          urls = [{
            template = "https://search.nixos.org/packages";
            params = [
              { name = "type"; value = "packages"; }
              { name = "query"; value = "{searchTerms}"; }
            ];
          }];
        };
        "NixOS Wiki" = {
          iconUpdateURL = "https://nixos.wiki/favicon.png";
          updateInterval = 24 * 60 * 60 * 1000; # every day
          definedAliases = [ "@nw" ];
          urls = [{
            template = "https://nixos.wiki/index.php?search={searchTerms}";
          }];
        };
        # TODO: NixOS options
        # TODO: Home Manager options
      };
      search.force = true;
    };
  };
}
