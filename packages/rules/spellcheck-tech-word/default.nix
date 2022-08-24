{pkgs, ...}:
pkgs.mkYarnPackage rec {
  name = "isolatextlint-rule-spellcheck-tech-word";
  version = (pkgs.lib.importJSON (src + "/package.json")).version;
  src = pkgs.fetchFromGitHub {
    owner = "azu";
    repo = "textlint-rule-spellcheck-tech-word";
    rev = "5.0.0";
    # sha256 = "sha256-5qL4gLoJnI6ZWgsVnLzvMkDLeR5UZ+TEFbsVI7wg4Mg=";
  };
  buildPhase = "yarn build";
}
