{ lib
, python3Packages
, fetchFromGitHub
, gtk4
, libadwaita
, gobject-introspection
, wrapGAppsHook4
, pipewire
, wireplumber
}:

python3Packages.buildPythonApplication {
  pname = "pipewire-control-center";
  version = "0.6.0";
  format = "pyproject";

  src = fetchFromGitHub {
    owner = "knightinfected";
    repo = "PipeWireController";
    rev = "d14e05e902f7f5b69be7e7e0131a00373aedaebe";
    hash = "sha256-sHRrzbDsDap/yQmOGegNPCXyuzFOT/MMdiaThNq/2mo=";
  };

  nativeBuildInputs = [
    python3Packages.hatchling
    gobject-introspection
    wrapGAppsHook4
  ];

  buildInputs = [
    gtk4
    libadwaita
    pipewire
    wireplumber
  ];

  propagatedBuildInputs = with python3Packages; [
    pygobject3
    pycairo
    numpy
    soundfile
  ];

  postInstall = ''
    install -Dm644 io.github.knightinfected.PipeWireControlCenter.desktop $out/share/applications/io.github.knightinfected.PipeWireControlCenter.desktop
  '';

  meta = with lib; {
    description = "PipeWire Controller & Control Center GUI";
    homepage = "https://github.com/knightinfected/PipeWireController";
    license = licenses.gpl3Plus;
    mainProgram = "pipewire-control-center";
  };
}
