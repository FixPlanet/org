{
  description = "Fix Planet Club - Organisational Documents";

  inputs = {
    nixpkgs.url     = "github:nixos/nixpkgs/nixos-22.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = inputs: with inputs;
  flake-utils.lib.eachDefaultSystem (system:
    let
        pkgs = import nixpkgs { inherit system; };
    in rec {
      devShell = pkgs.mkShell {
        buildInputs = [ pkgs.pandoc pkgs.pandoc-lua-filters ];
        shellHook   = ''
          # Fix the location of the lua filters, so we can refer to it explicitly.
          export LUA_FILTERS_DIR=${pkgs.pandoc-lua-filters}/share/pandoc/filters

          echo "~ Fix Planet Club ~"
        '';
      };
    }
  );
}
