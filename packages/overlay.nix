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
        ]
      )
    );
  };
}
