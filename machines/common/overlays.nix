{ inputs }:

_:

let
  overlays = [
    inputs.fenix.overlays.default
  ];
in
{
  nixpkgs.overlays = overlays;
}
