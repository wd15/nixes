let
  inherit (import <nixpkgs> {}) fetchFromGitHub;
  nixes = fetchFromGitHub {
    owner = "wd15";
    repo = "nixes";
    rev = "74a1109354171c7697eda75e1ec840049ade9ee6";
    sha256 = "1g15pr47hs6f002v2xa2pcx5bhfcf52f5vrv538c115w6hc5yzxl";
  };
in
  import "${nixes}/pfhub/build.nix"
