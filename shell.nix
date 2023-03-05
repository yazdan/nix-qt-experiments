{ nixpkgs ? fetchTarball "https://github.com/NixOS/nixpkgs/archive/4146109e5b7d8191b6f622d6b4edfb43651a6a06.tar.gz"
, pkgs ? (import nixpkgs {}).pkgsCross.aarch64-multiplatform
}:
# bba3474a5798b5a3a87e10102d1a55f19ec3fca5 too old
# 4d2b37a84fad1091b9de401eb450aae66f1a741e latest release
# 770d677e5f8c8d656c12aabda516206302605043 latest
# 4146109e5b7d8191b6f622d6b4edfb43651a6a06 latest 22.11

# callPackage is needed due to https://github.com/NixOS/nixpkgs/pull/126844
pkgs.pkgsStatic.callPackage ({ mkShell, zlib, pkg-config, file, cmake, git, which, ninja, qt5, libxslt }: mkShell {
  # these tools run on the build platform, but are configured to target the host platform
  nativeBuildInputs = [ pkg-config file cmake git which ninja libxslt];
  # libraries needed for the host platform
  buildInputs = [  zlib pkgs.qt5.qtbase ];
}) {}
