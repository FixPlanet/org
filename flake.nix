{
  description = "Fix Planet Club - Organisational Documents";

  inputs = {
    nixpkgs.url     = "github:nixos/nixpkgs/nixos-22.11";
    flake-utils.url = "github:numtide/flake-utils";
    flake-compat = {
      url = "github:edolstra/flake-compat";
      # don't look for a flake.nix file in this repository
      # this tells Nix to retrieve this input as just source code
      flake = false;
    };
  };

  outputs = inputs: with inputs;
  flake-utils.lib.eachDefaultSystem (system:
    let
        pkgs = import nixpkgs { inherit system; };
    in rec {
      devShell = pkgs.mkShell {
        buildInputs = [
          pkgs.fswatch
          pkgs.pandoc
          pkgs.pandoc-lua-filters
          pkgs.texlive.combined.scheme-small
        ];
        shellHook   = ''
          # Fix the location of the lua filters, so we can refer to it explicitly.
          export LUA_FILTERS_DIR=${pkgs.pandoc-lua-filters}/share/pandoc/filters

          echo "~ Fix Planet Club ~"
        '';
      };
    }
  );
}
