{
  pkgs,
  nix-filter,
  npmlock2nix,
  ...
}:
npmlock2nix.shell {
  src = nix-filter {
    root = ./.;
    include = [
      ./package.json
      ./package-lock.json
    ];
  };
}
