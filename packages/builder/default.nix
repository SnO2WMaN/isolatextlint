{pkgs, ...}: {
  cli ? pkgs.isolatextlint.cli,
  rules ? [],
}:
pkgs.callPackage ../cli {}
