{
  description = "Claude Desktop for Linux";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
      };
      patchy-cnb = pkgs.callPackage ./pkgs/patchy-cnb.nix {};
    in rec {
      packages = {
        inherit patchy-cnb;
        default = pkgs.callPackage ./pkgs/claude-desktop.nix {
          inherit patchy-cnb;
        };
      };
    });
}
