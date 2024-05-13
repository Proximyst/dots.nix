{ inputs }:

_:

let
  overlays = [
    inputs.neovim-nightly-overlay.overlay
  ];
in
{
  nixpkgs.overlays = overlays;
}
