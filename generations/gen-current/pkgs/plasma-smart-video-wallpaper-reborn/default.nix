{ lib, stdenv, fetchFromGitHub }:

stdenv.mkDerivation {
  pname = "plasma-smart-video-wallpaper-reborn";
  version = "2026-08-21";

  src = fetchFromGitHub {
    owner = "luisbocanegra";
    repo = "plasma-smart-video-wallpaper-reborn";
    rev = "e4cc9cd6e36c119dcbd278d3942ba90bea65a736";
    hash = "sha256-rO66l7ODioqbPPWmGYrK5R0FXxS4zDZnbx77IAPvtj8=";
  };

  installPhase = ''
    mkdir -p $out/share/plasma/wallpapers/io.github.luisbocanegra.smartvideowallpaper
    cp -r package/* $out/share/plasma/wallpapers/io.github.luisbocanegra.smartvideowallpaper/
  '';

  meta = with lib; {
    description = "Smart Video Wallpaper Reborn for KDE Plasma 6";
    homepage = "https://github.com/luisbocanegra/plasma-smart-video-wallpaper-reborn";
    license = licenses.gpl2Plus;
  };
}
