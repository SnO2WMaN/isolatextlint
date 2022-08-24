final: prev: {
  isolatextlint = {
    cli = final.callPackage ./cli {};
    builder = final.callPackage ./builder {};
  };
  isolatextlintPackages = {
    rules = with final.lib; (
      listToAttrs (
        map (name: {
          name = name;
          value =
            final.callPackage
            ../packages/rules/${name}
            {};
        }) [
          "max-comma"
          "max-ten"
          "no-double-negative-ja"
          # TODO: "no-doubled-conjunction"
          "no-dropping-the-ra"
          "no-mix-dearu-desumasu"
          "prh"
          # TODO: "spellcheck-tech-word"
        ]
      )
    );
  };
}
