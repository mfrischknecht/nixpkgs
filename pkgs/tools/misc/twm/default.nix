{ lib
, fetchFromGitHub
, fetchpatch
, stdenv
, rustPlatform
, openssl
, pkg-config
, Security
}:

rustPlatform.buildRustPackage rec {
  pname = "twm";
  version = "0.8.0";

  src = fetchFromGitHub {
    owner = "vinnymeller";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-icJQSPt3733H5pIdnpC/Vx+u6LgwokCdbvE3wvDkIlw=";
  };

  cargoHash = "sha256-DxT3Wsiy4zVlTSJwHqV/McSi/pc9pB0wyWY54fj1zVE=";

  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ openssl ] ++ lib.optionals stdenv.isDarwin [ Security ];

  patches = [
    # Fixes aarch64 build due to architecture dependent C string pointer types.
    # Can be removed as soon as this is merged: https://github.com/vinnymeller/twm/pull/13/commits
    (fetchpatch {
      name = "fix-aarch64-build.nix";
      url = "https://github.com/vinnymeller/twm/pull/13/commits/8fdcaca51baee3ee6a23a37c84d8a47adf6c20fe.patch";
      hash = "sha256-kDRzBGkU3AOGuJF8xPbM7c3QbiaX0odT3QvQ+CEzDY0=";
    })
  ];

  meta = with lib; {
    description = "A customizable workspace manager for tmux";
    homepage = "https://github.com/vinnymeller/twm";
    changelog = "https://github.com/vinnymeller/twm/releases/tag/v${version}";
    license = licenses.gpl2Only;
    maintainers = with maintainers; [ vinnymeller ];
    mainProgram = "twm";
  };
}
