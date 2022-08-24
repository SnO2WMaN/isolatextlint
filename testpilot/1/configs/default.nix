{
  pkgs,
  nix-filter,
  isolatextlint,
  isolatextlintPackages,
}:
isolatextlint.builder {
  config = ./config.json;
  misc = nix-filter {
    root = ./.;
    include = [
      ./prh-japanese.yml
    ];
  };
  rules = with isolatextlintPackages.rules; [
    max-ten
    no-double-negative-ja
    no-dropping-the-ra
    no-mix-dearu-desumasu
    prh
  ];
}
