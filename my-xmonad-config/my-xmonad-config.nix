{ mkDerivation, base, containers, stdenv, xmonad, xmonad-contrib
, xmonad-extras
}:
mkDerivation {
  pname = "my-xmonad-config";
  version = "0.1.0.0";
  src = ./.;
  isLibrary = true;
  isExecutable = true;
  libraryHaskellDepends = [
    base containers xmonad xmonad-contrib xmonad-extras
  ];
  executableHaskellDepends = [
    base xmonad xmonad-contrib xmonad-extras
  ];
  license = "unknown";
  hydraPlatforms = stdenv.lib.platforms.none;
}
