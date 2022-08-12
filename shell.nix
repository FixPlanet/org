{ pkgs ? import ./nixpkgs.nix {} }:

with pkgs;

mkShell {
  buildInputs = [ pandoc ];
  shellHook   = ''
    echo "~ Fix Planet Club ~"
  '';
}
