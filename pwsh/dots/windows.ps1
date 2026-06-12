# Personal PowerShell profile: Windows-only pieces.
# Loaded by Microsoft.PowerShell_profile.ps1 before common.ps1.

# TODO: Check if pyenv-win is installed; if not, install pyenv-win (see script in $DOTFILES/utils/installs/windows)
function Install-PythonVersion {
    Param (
        [Parameter(Mandatory=$True)]
        [String[]]$versions
    )
    $installed = $(pyenv versions)
    foreach ($version in $versions) {
        if (-Not ($version -in $installed)) {
            # write-output "$version is not installed!"
            pyenv install $version

            $_python = Join-Path $env:PYENV_ROOT "versions" $version
            $python_exe = Join-Path $_python "python3.exe"

            # FIXME: -m is throwing an "unexpected token error"
            # Upgrade pip
            # $python_exe -m pip install --upgrade pip

            # FIXME: -m is throwing an "unexpected token error"
            # Install virtualenv
            # $python_exe -m pip install --user virtualenv
        }
    }
}

# venv activation script lives under .venv\Scripts on Windows.
function Activate-Venv {
    $activate_script = Join-Path $pwd ".venv" "Scripts" "activate"
    .\$activate_script
}

function Am-Admin {
    [OutputType([bool])]

    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    $CheckforAdmin = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    if ($CheckforAdmin) {
        # Write-Host "PowerShell is running as administrator."
        return $true
    }
    # Write-Host "PowerShell is not running as administrator."
    return $false
}
