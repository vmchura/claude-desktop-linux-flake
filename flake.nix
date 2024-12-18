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
      patchy-cnb = pkgs.callPackage ./patchy-cnb.nix {};
    in rec {
      packages = {
        inherit patchy-cnb;
        # patchy-cnb = pkgs.callPackage ./patchy-cnb.nix {};
        default = pkgs.callPackage ./claude-desktop.nix {
          inherit patchy-cnb;
        };
      };
    });
}
