{pkgs, ...}:
pkgs.mkYarnPackage rec {
  name = "isolatextlint-rule-no-double-negative-ja";
  version = (pkgs.lib.importJSON (src + "/package.json")).version;
  src = pkgs.fetchFromGitHub {
    owner = "textlint-ja";
    repo = "textlint-rule-no-double-negative-ja";
    rev = "v2.0.1";
    sha256 = "sha256-+3k3PIw9VwYRKL1jNP4I+BM26PXcL43U9/IkSHg0WJ4=";
  };
  buildPhase = "yarn build";
}
