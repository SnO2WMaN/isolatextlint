{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    npmlock2nix = {
      url = "github:nix-community/npmlock2nix";
      flake = false;
    };
    nix-filter.url = "github:numtide/nix-filter";

    # dev
    devshell.url = "github:numtide/devshell";
    yamlfmt.url = "github:SnO2WMaN/yamlfmt/nix-intgl";
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    devshell,
    nix-filter,
    ...
  } @ inputs:
    {
      overlays.default = import ./packages/overlay.nix;
    }
    // flake-utils.lib.eachSystem [
      "x86_64-linux"
    ] (
      system: let
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            self.overlays.default
            devshell.overlay
            nix-filter.overlays.default
            (final: prev:
              with inputs; {
                yamlfmt = yamlfmt.packages.${system}.yamlfmt;
                npmlock2nix = final.callPackage npmlock2nix {};
              })
          ];
        };
      in {
        packages = flake-utils.lib.flattenTree ({
            cli = pkgs.isolatextlint.cli;
            # testpilot-1 = pkgs.callPackage ./testpilot/1/configs {};
          }
          // (with pkgs.lib.attrsets;
            mapAttrs' (key: value: (nameValuePair ("isolatextlint-rule-" + key) value))
            pkgs.isolatextlintPackages.rules));

        devShells.default = pkgs.devshell.mkShell {
          commands = with pkgs; [
            {
              package = "treefmt";
              category = "formatter";
            }
          ];
          packages = (
            with pkgs; [
              alejandra
              dprint
              yamlfmt
            ]
          );
        };
        devShells.temp = pkgs.callPackage ./temporary {};

        checks =
          self.packages.${system}
          // {};
      }
    );
}
