function Clone-Repo {
    $repo = "https://github.com/pyenv-win/pyenv-win"
    $src = Join-Path $env:USERPROFILE "src"
    $dst = Join-Path $src "pyenv-win"

    if (! (Test-Path $src)) {
        New-Item -ItemType Directory -Force -Path $src
    }

    if (! (Test-Path $dst)) {
        git clone $repo $dst
    }

}

function Symlink-Repo {
    $src = Join-Path $env:USERPROFILE "src" "pyenv-win"
    $dst = Join-Path $env:USERPROFILE ".pyenv"

    if (! (Test-Path "$dst")) {
        New-Item -Path $dst -ItemType SymbolicLink -Value $src
    }
}

function Set-EnvironmentVariables {
    [System.Environment]::SetEnvironmentVariable('PYENV', $env:USERPROFILE + "\.pyenv\pyenv-win\", "User")
    [System.Environment]::SetEnvironmentVariable('PYENV_ROOT', $env:USERPROFILE + "\.pyenv\pyenv-win\", "User")
    [System.Environment]::SetEnvironmentVariable('PYENV_HOME', $env:USERPROFILE + "\.pyenv\pyenv-win\", "User")

    [System.Environment]::SetEnvironmentVariable('path', $env:USERPROFILE + "\.pyenv\pyenv-win\bin;" + $env:USERPROFILE + "\.pyenv\pyenv-win\shims;" + [System.Environment]::GetEnvironmentVariable('path', "User"),"User")
}

function Main {
    Clone-Repo
    Symlink-Repo
    Set-EnvironmentVariables
}
Main
