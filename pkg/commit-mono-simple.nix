{
  lib,
  stdenvNoCC,
    requireFile,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "commit-mono-simple";
  version = "1.143";

  src = requireFile {
    url="https://commitmono.com/";
    name = "CommitMonoSimpleV143.tar";
    hash = "sha256-JF4CnJfWTuvjbGpgAEqR+Ygag/Q2VUuSBAn8ty7h9i0=";
  };

  dontConfigure = true;
  dontPatch = true;
  dontBuild = true;
  dontFixup = true;
  doCheck = false;

  installPhase = ''
    runHook preInstall
    install -Dm644 *.otf -t $out/share/fonts/opentype
    runHook postInstall
  '';

  meta = {
    description = "Anonymous and neutral programming typeface focused on creating a better reading experience";
    homepage = "https://commitmono.com/";
    license = lib.licenses.ofl;
    platforms = lib.platforms.all;
  };
})