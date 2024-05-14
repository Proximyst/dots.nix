{ inputs }:

_:

let
  overlays = [
    inputs.neovim-nightly-overlay.overlay
    inputs.fenix.overlays.default
  ];
in
{
  nixpkgs.overlays = overlays;
}
