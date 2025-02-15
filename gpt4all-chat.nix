{ src 
, lib
, stdenv
, cmake
, qmake
, qtwayland
, qtquicktimeline
, qtsvg
, qthttpserver
, qtwebengine
, qt5compat
, wrapQtAppsHook
, withAvx2 ? true
}:

stdenv.mkDerivation {
  pname = "gpt4all-chat";
  version = "nightly";

  inherit src;

  postPatch = ''
    substituteInPlace CMakeLists.txt \
      --replace 'set(CMAKE_INSTALL_PREFIX ''${CMAKE_BINARY_DIR}/install)' ""
  '';

  nativeBuildInputs = [
    wrapQtAppsHook
    cmake
  ];

  buildInputs = [
    qtwayland
    qtquicktimeline
    qtsvg
    qthttpserver
    qtwebengine
    qt5compat
  ];

  cmakeFlags = if withAvx2 then [] else [ "-DGPT4ALL_AVX_ONLY=ON" ];

  setSourceRoot = "sourceRoot=`pwd`/source/gpt4all-chat";

  meta = with lib; {
    description = "Gpt4all-j chat";
    homepage = "https://github.com/nomic-ai/gpt4all-chat";
    license = licenses.mit;
    maintainers = with maintainers; [ ];
  };
}
