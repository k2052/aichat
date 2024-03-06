{ pkgs ? import <nixpkgs> { overlays = [ (import (builtins.fetchTarball "https://github.com/oxalica/rust-overlay/archive/master.tar.gz")) ]; } }:

let
  rust-overlay-source = builtins.fetchGit {
    url = "https://github.com/oxalica/rust-overlay";
  };

  # Import it so we can use it in Nix
  rust-overlay = import rust-overlay-source;
in

pkgs.mkShell {
  name = "aichat-dev-env";

  buildInputs = with pkgs; [
    (pkgs.rust-bin.selectLatestNightlyWith (toolchain: toolchain.rustfmt))
    pkgs.rust-bin.stable.latest.default
    rust-analyzer
    rustfmt
    clippy
  ];
}
