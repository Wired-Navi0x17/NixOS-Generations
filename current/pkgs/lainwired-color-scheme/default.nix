{ lib, stdenv }:

stdenv.mkDerivation {
  pname = "lainwired-color-scheme";
  version = "1.0.0";

  src = /home/l41n-pr0t0/.local/share/color-schemes;

  installPhase = ''
    mkdir -p $out/share/color-schemes
    cp LainWired.colors $out/share/color-schemes/
  '';

  meta = with lib; {
    description = "LainWired Midnight Purple Color Scheme for KDE Plasma";
  };
}
