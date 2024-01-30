{ lib
, buildPythonPackage
, cython
, fetchFromGitHub
, fetchpatch
, jq
, pytestCheckHook
, pythonOlder
}:

buildPythonPackage rec {
  pname = "jq";
  version = "1.6.0";
  format = "setuptools";

  disabled = pythonOlder "3.7";

  src = fetchFromGitHub {
    owner = "mwilliamson";
    repo = "jq.py";
    rev = "refs/tags/${version}";
    hash = "sha256-c6tJI/mPlBGIYTk5ObIQ1CUTq73HouQ2quMZVWG8FFg=";
  };

  patches = [
    # Removes vendoring
    ./jq-py-setup.patch
  ];

  nativeBuildInputs = [
    cython
  ];

  buildInputs = [
    jq
  ];

  preBuild = ''
    cython jq.pyx
  '';

  nativeCheckInputs = [
    pytestCheckHook
  ];

  pythonImportsCheck = [
    "jq"
  ];

  meta = with lib; {
    description = "Python bindings for jq, the flexible JSON processor";
    homepage = "https://github.com/mwilliamson/jq.py";
    changelog = "https://github.com/mwilliamson/jq.py/blob/${version}/CHANGELOG.rst";
    license = licenses.bsd2;
    maintainers = with maintainers; [ benley ];
  };
}
