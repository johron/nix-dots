{ lib
, stdenv
, fetchFromGitHub
, cmake
, pkg-config
, openssl
, onnxruntime
, glib
, gtk3
, libcamera
, libpam
, cli11
, libjpeg
, rustPlatform
, bun
, cargo
, rustc
, webkitgtk_4_1
, libxdo
, libayatana-appindicator
, librsvg
, wrapGAppsHook4
}:

stdenv.mkDerivation rec {
  pname = "biopass";
  version = "1.4.1";

  src = fetchFromGitHub {
    owner = "TickLabVN";
    repo = "biopass";
    rev = "v${version}";
    hash = "sha256-JNX2L4IDU5XxfgjhbuivhiYKp7GdLWLogrBgdFgODsg=";
  };

  cmakeFlags = [
    "-S../auth" 
    "-B."
  ];

  nativeBuildInputs = [
    cmake
    pkg-config
    rustPlatform.cargoSetupHook
    cargo
    rustc
    bun
    wrapGAppsHook4
  ];

  buildInputs = [
    openssl
    onnxruntime
    glib
    gtk3
    libpam
    cli11
    libjpeg
    libcamera

    webkitgtk_4_1
    libxdo
    libayatana-appindicator
    librsvg
  ];

  buildPhase = ''
    runHook preBuild
    
    cmake --build . --config Release
    
    export HOME=$(mktemp -d)
    cd ../app
    bun install --no-progress --frozen-lockfile
    # Invoke tauri build logic (Requires cargo dependencies vendored if strictly sandboxed)
    bun run tauri build --no-bundle
    
    cd ../build
    runHook postBuild
  '';

  meta = with lib; {
    description = "Modern Multi-Modal Biometric Login for Linux";
    homepage = "https://github.com/TickLabVN/biopass";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
