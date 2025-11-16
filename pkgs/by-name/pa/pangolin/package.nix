{
  stdenv,
  lib,
  fetchFromGitHub,
  cmake,
  python3,
  pkg-config,
  doxygen,
  libGL,
  glew,
  xorg,
  ffmpeg,
  libepoxy,
  libjpeg,
  libpng,
  libtiff,
  eigen,
}:

stdenv.mkDerivation (finalAttrs: {
  pname = "pangolin";
  version = "0.9.4";

  src = fetchFromGitHub {
    owner = "stevenlovegrove";
    repo = "Pangolin";
    rev = "v${finalAttrs.version}";
    hash = "sha256-bv0oBn/3r8vNN/DlXGtZzP2EVH0bjygsMRbsUx/dJAs=";
  };

  nativeBuildInputs = [
    cmake
    pkg-config
    doxygen
    python3
  ];

  buildInputs = [
    libGL
    glew
    xorg.libX11
    ffmpeg
    libepoxy
    libjpeg
    libpng
    libtiff.out
    eigen
  ];

  # The tests use cmake's findPackage to find the installed version of
  # pangolin, which isn't what we want (or available).
  doCheck = false;
  cmakeFlags = [ (lib.cmakeBool "BUILD_TESTS" false) ];

  meta = {
    description = "Lightweight portable rapid development library for managing OpenGL display / interaction and abstracting video input";
    longDescription = ''
      Pangolin is a lightweight portable rapid development library for managing
      OpenGL display / interaction and abstracting video input. At its heart is
      a simple OpenGl viewport manager which can help to modularise 3D
      visualisation without adding to its complexity, and offers an advanced
      but intuitive 3D navigation handler. Pangolin also provides a mechanism
      for manipulating program variables through config files and ui
      integration, and has a flexible real-time plotter for visualising
      graphical data.
    '';
    homepage = "https://github.com/stevenlovegrove/Pangolin";
    license = lib.licenses.mit;
    maintainers = [ ];
    platforms = lib.platforms.all;
  };
})
