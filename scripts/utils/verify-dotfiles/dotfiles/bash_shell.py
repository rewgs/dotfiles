from pathlib import Path
from pathlib import PurePath
from os import environ as env

from dots import Dot

bashrc = Dot(
    name="bashrc",
    src=Path(PurePath.joinpath(Path(env["DOTFILES"]), "bash", "bashrc")),
    dst=Path(PurePath.joinpath(Path.home(), ".bashrc"))
)

bash_profile = Dot(
    name="bash_profile",
    src=Path(PurePath.joinpath(Path(env["DOTFILES"]), "bash", "bash_profile")),
    dst=Path(PurePath.joinpath(Path.home(), ".bash_profile"))
)
