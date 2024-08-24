{ config, lib, pkgs, ... }:

let
  cfg = config.modules.git;
in
with lib;
{
  options.modules.git = {
    enable = mkEnableOption "git";
    name = mkOption {
      description = "the name of the user, i.e. full name";
      type = types.str;
    };
    email = mkOption {
      description = "the email of the user";
      type = types.str;
    };
    signingKey = mkOption {
      description = "the name of the signing key";
      default = "~/.ssh/id_ed25519.pub";
      type = types.str;
    };
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ gnupg ];

    programs.git = {
      enable = true;
      lfs.enable = true;
      userName = cfg.name;
      userEmail = cfg.email;
      delta.enable = true;
      delta.options = {
        navigate = true;
        light = false;
        line-numbers = true;
        side-by-side = true;
      };
      extraConfig = {
        init.defaultBranch = "main";
        pull.rebase = true;
        diff.colormoved = "zebra";
        diff.algorithm = "histogram";
        blame.pager = "delta";
        merge.conflictstyle = "diff3";
        checkout.workers = 0;
        pack.writeReverseIndex = true;
        gpg.format = "ssh";
        user.signingkey = cfg.signingKey;
        feature.manyFiles = true;
        lfs.locksverify = false;
        commit.gpgsign = true;
      };
    };
  };
}
