{ pkgs ? import ./nixpkgs.nix {} }:

with pkgs;

mkShell {
  buildInputs = [ pandoc pandoc-lua-filters ];
  shellHook   = ''
    # Fix the location of the lua filters, so we can refer to it explicitly.
    export LUA_FILTERS_DIR=${pandoc-lua-filters}/share/pandoc/filters

    echo "~ Fix Planet Club ~"
  '';
}
