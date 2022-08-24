{pkgs, ...}: let
  monorepo = pkgs.fetchFromGitHub {
    # owner = "textlint";
    # repo = "textlint";
    # rev = "v12.2.1";
    # sha256 = "sha256-VVVPVomvWYQJrXM9kDd70wEgjtDDOzQETVz/CyVUmGw=";
    owner = "SnO2WMaN";
    repo = "textlint";
    rev = "add-types-debug-to-ast-tester";
    sha256 = "sha256-h8SGryhtkLoYII6/cRrF/mIuZ/AE5G/0bsXEZJKW7H0=";
  };

  mkInternalYarnPkg = dirname: deps:
    pkgs.mkYarnPackage rec {
      name = "at_textlint-${dirname}";
      version = (pkgs.lib.importJSON (src + "/package.json")).version;

      src = monorepo + "/packages/@textlint/${dirname}";
      preConfigure = ''
        substituteInPlace \
          tsconfig.json \
          --replace "../../../tsconfig.base.json" "${monorepo}/tsconfig.base.json"
          # --replace "../ast-node-types" "${monorepo}/packages/@textlint/ast-node-types"
      '';
      yarnLock = monorepo + "/yarn.lock";
      buildPhase = "yarn build";
      workspaceDependencies = deps;
    };

  ast-node-types = mkInternalYarnPkg "ast-node-types" [];
  ast-tester = mkInternalYarnPkg "ast-tester" [ast-node-types];
  ast-traverse = mkInternalYarnPkg "ast-traverse" [ast-node-types markdown-to-ast]; # TODO:
  feature-flag = mkInternalYarnPkg "feature-flag" [];
  fixer-formatter = mkInternalYarnPkg "fixer-formatter" [module-interop types]; # TODO:
  kernel = mkInternalYarnPkg "kernel" [ast-node-types ast-tester ast-traverse feature-flag source-code-fixer types utils]; # TODO:
  linter-formatter = mkInternalYarnPkg "linter-formatter" [module-interop types]; # TODO:
  markdown-to-ast = mkInternalYarnPkg "markdown-to-ast" [ast-tester];
  module-interop = mkInternalYarnPkg "module-interop" [types];
  source-code-fixer = mkInternalYarnPkg "source-code-fixer" [types];
  text-to-ast = mkInternalYarnPkg "text-to-ast" [ast-node-types ast-tester]; # TODO:
  textlint-plugin-markdown = mkInternalYarnPkg "textlint-plugin-markdown" [markdown-to-ast kernel];
  textlint-plugin-text = mkInternalYarnPkg "textlint-plugin-text" [kernel text-to-ast];
  types = mkInternalYarnPkg "types" [ast-node-types markdown-to-ast];
  utils = mkInternalYarnPkg "utils" [];
in
  pkgs.mkYarnPackage rec {
    name = "isolatextlint";
    version = (pkgs.lib.importJSON (src + "/package.json")).version;

    src = monorepo + "/packages/textlint";

    yarnLock = monorepo + "/yarn.lock";
    buildPhase = "yarn build";

    preConfigure = ''
      substituteInPlace \
        tsconfig.json \
        --replace "../../tsconfig.base.json" "${monorepo}/tsconfig.base.json"
    '';

    workspaceDependencies = [
      ast-node-types
      ast-traverse
      feature-flag
      fixer-formatter
      kernel
      linter-formatter
      module-interop
      textlint-plugin-markdown
      textlint-plugin-text
      types
      utils
    ];
  }
