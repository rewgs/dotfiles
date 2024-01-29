from pathlib import Path, PurePath


PACKAGE_ROOT = Path(__file__).parent.resolve()
SRC_DIR = PACKAGE_ROOT.parent.resolve()
REPO_ROOT = SRC_DIR.parent.resolve()

DEFINITIONS_DIR = Path(PurePath.joinpath(PACKAGE_ROOT, "definitions")).resolve()
