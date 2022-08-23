{pkgs, ...}:
pkgs.mkYarnPackage rec {
  name = "textlint-rule-max-comma";
  version = (pkgs.lib.importJSON (src + "/package.json")).version;
  src = pkgs.fetchFromGitHub {
    owner = "textlint-rule";
    repo = "textlint-rule-max-comma";
    rev = "v2.0.2";
    sha256 = "sha256-5qL4gLoJnI6ZWgsVnLzvMkDLeR5UZ+TEFbsVI7wg4Mg=";
  };
  buildPhase = "yarn build";
}
