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
          git
          wayland-scanner
        ];

        buildInputs = with pkgs; [
          libinput
          wayland
          wlroots
          libxkbcommon
          wayland-protocols
          xorg.libX11
          xorg.libxcb
          xorg.xcbutilwm
          xwayland
          pixman
          cairo
          pango
          glib
          fontconfig
          libdrm
          udev
        ];

        buildPhase = ''
          make
        '';

        installPhase = ''
          make PREFIX=$out install
        '';

        meta = with pkgs.lib; {
          description = "Dynamic Wayland compositor based on dwm";
          license = licenses.mit;
          platforms = platforms.linux;
          maintainers = with maintainers; [ ];
          mainProgram = "dwl";
        };
      };
    };
}
