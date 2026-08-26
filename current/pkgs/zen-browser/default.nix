{ lib
, stdenv
, fetchurl
, autoPatchelfHook
, wrapGAppsHook3
, makeDesktopItem
, copyDesktopItems
, alsa-lib
, atk
, cairo
, cups
, dbus
, expat
, ffmpeg
, fontconfig
, freetype
, gdk-pixbuf
, glib
, gtk3
, libGL
, libX11
, libXScrnSaver
, libXcomposite
, libXcursor
, libXdamage
, libXext
, libXfixes
, libXi
, libXrandr
, libXrender
, libXtst
, libdrm
, libglvnd
, libnotify
, libpulseaudio
, libva
, libxcb
, libxkbcommon
, libxshmfence
, mesa
, nspr
, nss
, pango
, pipewire
, udev
, wayland
}:

stdenv.mkDerivation rec {
  pname = "zen-browser";
  version = "1.21.15b";

  src = fetchurl {
    url = "https://github.com/zen-browser/desktop/releases/download/${version}/zen.linux-x86_64.tar.xz";
    sha256 = "sha256-Lq6mZLhABnygrOYjvU9FSPrpj0apji3b39y5JTtnS78=";
  };

  nativeBuildInputs = [
    autoPatchelfHook
    wrapGAppsHook3
    copyDesktopItems
  ];

  buildInputs = [
    alsa-lib
    atk
    cairo
    cups
    dbus
    expat
    ffmpeg
    fontconfig
    freetype
    gdk-pixbuf
    glib
    gtk3
    libGL
    libX11
    libXScrnSaver
    libXcomposite
    libXcursor
    libXdamage
    libXext
    libXfixes
    libXi
    libXrandr
    libXrender
    libXtst
    libdrm
    libglvnd
    libnotify
    libpulseaudio
    libva
    libxcb
    libxkbcommon
    libxshmfence
    mesa
    nspr
    nss
    pango
    pipewire
    udev
    wayland
  ];

  runtimeDependencies = [
    udev
    libGL
    libglvnd
    libnotify
    pipewire
    wayland
  ];

  appendRunpaths = [
    "${lib.makeLibraryPath runtimeDependencies}"
  ];

  desktopItems = [
    (makeDesktopItem {
      name = "zen";
      exec = "zen %u";
      icon = "zen";
      desktopName = "Zen Browser";
      genericName = "Web Browser";
      categories = [ "Network" "WebBrowser" ];
      mimeTypes = [
        "text/html"
        "text/xml"
        "application/xhtml+xml"
        "application/vnd.mozilla.xul+xml"
        "x-scheme-handler/http"
        "x-scheme-handler/https"
      ];
    })
  ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/opt/zen $out/bin
    cp -r * $out/opt/zen/

    # Link binary
    ln -s $out/opt/zen/zen $out/bin/zen

    # Install icon
    mkdir -p $out/share/icons/hicolor/128x128/apps
    if [ -f $out/opt/zen/browser/chrome/icons/default/default128.png ]; then
      cp $out/opt/zen/browser/chrome/icons/default/default128.png $out/share/icons/hicolor/128x128/apps/zen.png
    fi

    runHook postInstall
  '';

  meta = with lib; {
    description = "Experience tranquillity while browsing the web without people tracking you";
    homepage = "https://zen-browser.app";
    license = licenses.mpl20;
    platforms = [ "x86_64-linux" ];
    mainProgram = "zen";
  };
}
