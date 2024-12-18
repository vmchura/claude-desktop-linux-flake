{
  description = "Claude Desktop for Linux";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }:
  let
    system = "x86_64-linux";
    pkgs = import nixpkgs { inherit system; };
  in
  {
    packages.x86_64-linux = rec {
      patchy-cnb = pkgs.callPackage ./pkgs/patchy-cnb.nix {};
      claude-desktop = pkgs.callPackage ./pkgs/claude-desktop.nix {
        inherit patchy-cnb;
      };
      default = claude-desktop;
    };
  };
}
