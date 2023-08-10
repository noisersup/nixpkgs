{ lib
, stdenv
, fetchFromGitHub
, cmake
, pkg-config
, mesa
, dbus
, boost
, git
, libGL
, freetype
, libGLU, cairo, gtk3, libsoup,  openvdb, wayland, wayland-protocols, libxkbcommon
, tbb, openssl, curl, glew, glfw, cereal, nlopt, ilmbase, cgal, opencascade-occt
, wxGTK32
, libpng, libtiff
}:
let
  pname = "BambuStudio";
  version = "01.07.01.62";

  src = fetchFromGitHub {
    owner = "bambulab";
    repo = pname;
    rev = "v${version}";
    sha256 = "lkB4OzK4UyQwyKHX76xfGmN83Riu/YQRQlXzJPLdOUU=";
  };

  bambuSrc = src;

  #wxGTK-patched = wxGTK31.overrideAttrs (old: rec {
  #  patches = old.patches ++ [
  #    ("${bambuSrc}/deps/wxWidgets/0001-wxWidget-fix.patch")
  #  ];

  #  src = fetchFromGitHub {
  #    owner = "wxWidgets";
  #    repo = "wxWidgets";
  #    rev = "v3.1.5";
  #    hash = "sha256-2zMvcva0GUDmSYK0Wk3/2Y6R3F7MgdqGBrOhmWgVA6g=";
  #    fetchSubmodules = true;
  #  };
  #});
in stdenv.mkDerivation {
  inherit pname version src;

  patches = [
    ./diff.patch
  ];


  cmakeFlags = [
    #"-DCMAKE_BUILD_TYPE=Release"
    "-DDEP_WX_GTK3=1"
    "-DwxWidgets_INCLUDE_DIRS=${wxGTK32}"
    "-DwxWidgets_LIBRARIES=${wxGTK32}/lib"
    "-DwxWidgets_ROOT_DIR:PATH=${wxGTK32}"
  ];



  # nativeBuildInputs = [ cmake pkg-config gcc mesa dbus boost git libGL freetype
  # libGLU cairo gtk3 libsoup openvdb wayland wayland-protocols libxkbcommon
  # tbb openssl curl glew glfw cereal nlopt ilmbase cgal opencascade-occt
  # ];

  nativeBuildInputs = [
    cmake
    pkg-config
  ];

  buildInputs = [
  mesa dbus boost git libGL freetype
  libGLU cairo gtk3 libsoup openvdb wayland wayland-protocols libxkbcommon
  tbb openssl curl glew glfw cereal nlopt ilmbase cgal opencascade-occt
  #wxGTK-patched
  wxGTK32
  libpng
  libtiff
  ];
  #buildInputs = [
  #  wxGTK-patched
  #];
}
