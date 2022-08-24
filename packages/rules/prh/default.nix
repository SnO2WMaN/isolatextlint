{pkgs, ...}:
pkgs.mkYarnPackage rec {
  name = "isolatextlint-rule-prh";
  version = (pkgs.lib.importJSON (src + "/package.json")).version;
  src = pkgs.fetchFromGitHub {
    owner = "textlint-rule";
    repo = "textlint-rule-prh";
    rev = "5.3.0";
    sha256 = "sha256-5qL4gLoJnI6ZWgsVnLzvMkDLeR5UZ+TEFbsVI7wg4Mg=";
  };
  buildPhase = "yarn build";
}
