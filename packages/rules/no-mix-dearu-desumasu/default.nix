{pkgs, ...}:
pkgs.mkYarnPackage rec {
  name = "isolatextlint-rule-no-mix-dearu-desumasu";
  version = (pkgs.lib.importJSON (src + "/package.json")).version;
  src = pkgs.fetchFromGitHub {
    owner = "textlint-ja";
    repo = "textlint-rule-no-mix-dearu-desumasu";
    rev = "v5.0.0";
    sha256 = "sha256-SJ5Pm9d9jkHBRBfgcNWvHSt/2IPk92j+UQL0XeTRH5g=";
  };
  buildPhase = "yarn build";
}
