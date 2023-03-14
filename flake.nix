{
  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };
    flake-utils = {
      url = "github:numtide/flake-utils";
    };
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
    ...
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {inherit system;};
      packages = [
        pkgs.cmake
        pkgs.pkg-config
        pkgs.fontconfig
        pkgs.xorg.libX11
        pkgs.xorg.libXcursor
        pkgs.xorg.libXrandr
        pkgs.xorg.libXi
        pkgs.vulkan-tools
        pkgs.vulkan-headers
        pkgs.vulkan-validation-layers
        pkgs.vulkan-loader
      ];
    in {
      devShell = pkgs.mkShell {
        buildInputs = packages;
        shellHook = ''export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${pkgs.lib.makeLibraryPath packages}"'';
      };
    });
}
