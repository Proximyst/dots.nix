{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { nixpkgs, flake-utils, fenix, ... }:
    let
      sysPkgs = system: import nixpkgs {
        inherit system;
        overlays = [
          fenix.overlays.default
        ];
      };
    in
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = sysPkgs system;
        mkDevShell = packages: pkgs.mkShell {
          buildInputs = packages;
          shellHook = ''
            exec $SHELL
          '';
        };
        mkDefaultDevShell = packages: mkDevShell (packages ++ (with pkgs; [
          gnumake
          just
          protobuf
          buf
          protoc-gen-doc
        ]));

        mkCxx = compiler: mkDefaultDevShell (with pkgs; [
          compiler
          meson
          ninja
          bazel
          bazelisk
          bazel-gazelle
        ]);
        mkJava = jdk: mkDefaultDevShell (with pkgs; [ jdk gradle maven ]);
        mkRust = toolchain: mkDefaultDevShell (with pkgs; [
          (pkgs.fenix.${toolchain}.withComponents [
            "cargo"
            "clippy"
            "rust-src"
            "rustc"
            "rustfmt"
            "rust-analyzer"
          ])
          protoc-gen-rust
          protoc-gen-tonic
          protoc-gen-prost
          protoc-gen-prost-serde
        ]);
      in
      {
        devShells = {
          go = mkDefaultDevShell (with pkgs; [
            go
            golangci-lint
            protoc-gen-go
            protoc-gen-go-grpc
          ]);
          grafana = mkDefaultDevShell (with pkgs; [ go gcc nodejs corepack ]);
          gcc = mkCxx pkgs.gcc;
          clang = mkCxx pkgs.clang;
          java17 = mkJava pkgs.corretto17;
          java21 = mkJava pkgs.corretto21;
          rust-nightly = mkRust "complete";
          rust-stable = mkRust "stable";
          rust-beta = mkRust "beta";
          haskell = mkDefaultDevShell (with pkgs; [
            ghc
            haskellPackages.cabal-install
            haskellPackages.hpack
            haskellPackages.cabal2nix
            zlib
          ]);
        };

        formatter = pkgs.nixpkgs-fmt;
      });
}
