# Sets up PowerShell Core on Linux, macOS, or Windows.
#
# Symlinks the `dots` dir to the PowerShell config location:
#   Windows: ~/Documents/PowerShell
#   Unix:    ~/.config/powershell

$_thisFile = $MyInvocation.MyCommand.Path
$_thisDir = Split-Path -Parent $_thisFile
$src = Join-Path -Path $_thisDir -ChildPath "dots"

# $HOME is set on every platform in PowerShell Core; $env:HOMEPATH lacks the drive
# letter and $env:USERPROFILE is Windows-only.
if ($IsWindows) {
    $dst = Join-Path -Path $HOME -ChildPath "Documents" -AdditionalChildPath "PowerShell"
} else {
    $dst = Join-Path -Path $HOME -ChildPath ".config" -AdditionalChildPath "powershell"
}

# Ensure the parent dir exists, otherwise New-Item -SymbolicLink fails.
$dstParent = Split-Path -Parent $dst
if (-not (Test-Path $dstParent)) {
    New-Item -Path $dstParent -ItemType Directory -Force | Out-Null
}

# Remove anything already at $dst. Use -Force so a symlink is removed as a link
# (without -Recurse following it into the target and deleting the real dots).
# Get-Item with -Force is needed to see existing symlinks/hidden items.
$existing = Get-Item -Path $dst -Force -ErrorAction SilentlyContinue
if ($null -ne $existing) {
    if ($null -ne $existing.LinkType) {
        # It's a symlink/junction: remove the link itself, never -Recurse.
        Remove-Item -Path $dst -Force
    } else {
        Remove-Item -Path $dst -Recurse -Force
    }
}

# NOTE: on Windows, New-Item -SymbolicLink requires admin or Developer Mode.
# Fall back to a directory junction, which needs no elevation for local paths.
try {
    New-Item -Path $dst -ItemType SymbolicLink -Value $src -ErrorAction Stop | Out-Null
} catch {
    if ($IsWindows) {
        Write-Warning "SymbolicLink failed ($_); falling back to a directory junction."
        New-Item -Path $dst -ItemType Junction -Value $src | Out-Null
    } else {
        throw
    }
}
