final: prev: {
  isolatextlint = final.callPackage ./isolatextlint {};
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
