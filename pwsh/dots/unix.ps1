# Personal PowerShell profile: Unix-only (macOS/Linux) pieces.
# Loaded by Microsoft.PowerShell_profile.ps1 before common.ps1.

# venv activation script lives under .venv/bin on Unix.
function Activate-Venv {
    $activate_script = Join-Path $pwd ".venv" "bin" "activate"
    .\$activate_script
}

# Unix equivalent of the Windows Am-Admin: are we running as root?
function Am-Admin {
    [OutputType([bool])]
    param()
    return ((id -u) -eq 0)
}
