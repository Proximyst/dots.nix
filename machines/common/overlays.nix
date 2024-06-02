{ inputs }:

_:

let
  overlays = [
    inputs.neovim-nightly-overlay.overlays.default
    inputs.fenix.overlays.default
  ];
in
{
  nixpkgs.overlays = overlays;
}
