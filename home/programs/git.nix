{ config, ... }:

{
  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "Mariell Hoversholm";
    userEmail = "mariell@mardroemmar.dev";
    delta.enable = true;
    delta.options = {
      navigate = true;
      light = false;
      line-numbers = true;
      side-by-side = true;
      syntax-theme = "gruvbox-dark";
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
      feature.manyFiles = true;
      lfs.locksverify = false;
    };
  };
}
