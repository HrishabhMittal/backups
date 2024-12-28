{ pkgs }:

pkgs.stdenv.mkDerivation {
	name = "gruvbox-plus";

	src = pkgs.fetchurl {
	  url = "https://github.com/SylEleuth/gruvbox-plus-icon-pack/releases/download/v6.0.2/gruvbox-plus-icon-pack-6.0.2.zip";
	  sha256 = "sha256-2iAoKNHwo+DowuIk2qtxfDW3u1JolVjCrFri5qz1IZ0=";
	};

	dontUnpack = true;

	installPhase = ''
	  mkdir -p $out
      echo ${pkgs.unzip}/bin/unzip
	  ${pkgs.unzip}/bin/unzip $src -d $out/
	  '';
}
