{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation {
  pname = "sddm-theme-nier-automata";
  version = "1.0.0";
  src = /home/l41n-pr0t0/Documents/SDDM_Themes/nier-automata;

  installPhase = ''
    mkdir -p $out/share/sddm/themes/nier-automata
    cp -r * $out/share/sddm/themes/nier-automata/
  '';
}
