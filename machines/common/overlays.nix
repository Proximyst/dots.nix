{ inputs }:

_:

let
  overlays = [
    inputs.fenix.overlays.default
    inputs.neovim-conf.overlays.default
  ];
in
{
  nixpkgs.overlays = overlays;
}
