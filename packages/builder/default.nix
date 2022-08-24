{pkgs, ...}: {
  cli ? pkgs.isolatextlint.cli,
  config,
  misc ? [],
  rules ? [],
}:
pkgs.callPackage ../cli {}
