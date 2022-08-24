{pkgs, ...}:
pkgs.npmlock2nix.build rec {
  name = "isolatextlint-rule-no-doubled-conjunction";
  version = (pkgs.lib.importJSON (src + "/package.json")).version;
  src = pkgs.fetchFromGitHub {
    owner = "textlint-ja";
    repo = "textlint-rule-no-doubled-conjunction";
    rev = "v2.0.4";
    sha256 = "sha256-UQCjv7ePJY11zKZ3NGb/nF65lVmM0MM/ALcPDHJ5kf4=";
  };
  installPhase = "cp -r dist $out";
  buildCommands = ["npm run build"];
}
