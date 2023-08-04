{ stdenv
, fetchFromGitHub
, cmake
, pkg-config
}:
stdenv.mkDerivation rec {
  pname = "BambuStudio";
  version = "01.07.01.62";

  src = fetchFromGitHub {
    owner = "bambulab";
    repo = pname;
    rev = "v${version}";
    sha256 = "lkB4OzK4UyQwyKHX76xfGmN83Riu/YQRQlXzJPLdOUU=";
  };

  nativeBuildInputs = [ cmake pkg-config ];
}
