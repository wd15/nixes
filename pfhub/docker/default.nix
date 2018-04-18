let
  inherit (import <nixpkgs> {}) fetchFromGitHub;
  nixes = fetchFromGitHub {
    owner = "wd15";
    repo = "nixes";
    rev = "59ce3ead4c1fc53e25c5af7bf3d4485135cd92a5";
    sha256 = "1shsqi4ik8vyvgnzmglaqzmcpcpmzlc8lmynly7krhpnrll0qrq2";
  };
in import "${nixes}/pfhub/default.nix"
