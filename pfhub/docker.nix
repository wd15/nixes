let
inherit (import <nixpkgs> {}) fetchFromGitHub;
nixes = fetchFromGitHub {
  owner = "wd15";
  repo = "nixes";
  rev = "7861bfb99a327cd4027207f10939387844fc8f87";
  sha256 = "0kaq0p30drqfs50xb9dwwd4pkdscm9kb4yb74w3l3wh5grzrnci6";
  };
in import "${nixes}/pfhub/default.nix"
