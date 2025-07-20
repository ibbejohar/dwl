{
  description = "dwl Wayland compositor flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, ... }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in {
      packages.${system}.dwl = pkgs.stdenv.mkDerivation {
        pname = "dwl";
        version = "unstable";

        src = ./.;

        nativeBuildInputs = with pkgs; [
          pkg-config
          meson
          ninja
          wayland
          wlroots
          glib
          fontconfig
          git
          cairo
          pango
          libxkbcommon
          pixman
          libdrm
          libinput
          udev
        ];

        buildPhase = ''
          meson setup build
          meson compile -C build
        '';

        installPhase = ''
          meson install -C build
        '';

        meta = with pkgs.lib; {
          description = "Dynamic Wayland compositor based on dwm";
          license = licenses.mit;
          platforms = platforms.linux;
          maintainers = with maintainers; [ ];
        };
      };
    };
}
