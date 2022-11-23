{ lib
, buildGoModule
, fetchFromGitHub
}:

buildGoModule rec {
  pname = "ferretdb";
  version = "0.8.0";

  src = fetchFromGitHub {
    owner = "FerretDB";
    repo = "FerretDB";
    rev = "v${version}";
    sha256 = "sha256-g4UJOgT/87RDRqNU5Zp7/47oPLtRNjYJT687PGd3KwE=";
  };

  postPatch = ''
    echo v${version} > build/version/version.txt
    echo nixpkgs     > build/version/package.txt
  '';

  vendorSha256 = "sha256-VWDRwf3pnD+Q516d05kfm0iPUuSHs00QKGYN4rqNfw4=";

  CGO_ENABLED = 0;

  subPackages = [ "cmd/ferretdb" ];

  tags = [ "ferretdb_tigris" ];

  meta = with lib; {
    description = "A truly Open Source MongoDB alternative";
    homepage = "https://www.ferretdb.io/";
    license = licenses.asl20;
    maintainers = with maintainers; [ dit7ya ];
  };
}
