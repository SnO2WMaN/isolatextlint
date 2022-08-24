{pkgs, ...}:
pkgs.mkYarnPackage rec {
  name = "isolatextlint-rule-no-dropping-the-ra";
  version = (pkgs.lib.importJSON (src + "/package.json")).version;
  src = pkgs.fetchFromGitHub {
    owner = "textlint-ja";
    repo = "textlint-rule-no-dropping-the-ra";
    rev = "v3.0.0";
    sha256 = "sha256-ttHAeKFzczlVZrVU/C0RPVnAt4wVAU+/7+8pzrS+3+s=";
  };
  buildPhase = "yarn build";
}
