{pkgs, ...}:
pkgs.mkYarnPackage rec {
  name = "isolatextlint-rule-max-ten";
  version = (pkgs.lib.importJSON (src + "/package.json")).version;
  src = pkgs.fetchFromGitHub {
    owner = "textlint-ja";
    repo = "textlint-rule-max-ten";
    rev = "v4.0.3";
    sha256 = "sha256-2hvg7h+7xSj7uoWf/jDw6Qu7bPrWDjlwom5XM4G65N8=";
  };
  buildPhase = "yarn build";
}
