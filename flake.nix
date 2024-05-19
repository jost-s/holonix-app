{
  description = "A hApp development flake";

  inputs = {
    holonix.url = "github:jost-s/holonix-holochain/main-0.3";
    # override lair or other holonix components like this
    # holonix.inputs.lair.url = "github:jost-s/holonix-lair/main-0.2";
    nixpkgs.follows = "holonix/nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, holonix, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let pkgs = nixpkgs.legacyPackages.${system}; in
      {
        devShells.default = pkgs.mkShell {
          packages = with holonix.packages.${system}; [
            holochain
            lair-keystore
            rust
            # add other packages like pkgs.nodejs
          ];
        };
      }
    );
}
