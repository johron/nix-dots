{ lib, stdenv, fetchFromGitHub, cmake, pkg-config, openssl, onnxruntime, glib, gtk3 }:

stdenv.mkDerivation rec {
  pname = "biopass";
  version = "1.4.1";

  src = fetchFromGitHub {
    owner = "ticklabvn";
    repo = "biopass";
    rev = "${version}";
    hash = "sha256-JNX2L4IDU5XxfgjhbuivhiYKp7GdLWLogrBgdFgODsg=";
  };

  nativeBuildInputs = [ cmake pkg-config ];
  buildInputs = [ openssl onnxruntime glib gtk3 ];

  meta = with lib; {
    description = "An alternative to Windows Hello/Howdy";
    homepage = "https://github.com/TickLabVN/biopass";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
