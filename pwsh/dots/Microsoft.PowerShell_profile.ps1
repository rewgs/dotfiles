# Personal PowerShell profile.
#
# Split into a shared base plus per-platform files in this same directory (this dir is
# symlinked to the PowerShell config location by setup.ps1 / setup.sh):
#   common.ps1  - cross-platform functions, aliases, prompt
#   windows.ps1 - Windows-only
#   unix.ps1    - macOS/Linux-only
# The platform file loads first, then common.ps1.

# $IsWindows exists in PowerShell Core; Windows PowerShell 5.1 (Windows-only) lacks it.
$onWindows = if ($null -ne $IsWindows) { $IsWindows } else { $true }

if ($onWindows) { . "$PSScriptRoot/windows.ps1" } else { . "$PSScriptRoot/unix.ps1" }
. "$PSScriptRoot/common.ps1"

# sns shell environment: provides `sns`/`snsd` (and the rclone wrapper). Loaded last so
# its functions win. Mirrors the one-line import used by the zsh/bash configs.
$snsProfile = Join-Path $HOME ".sns/env/pwsh/main.ps1"
if (Test-Path $snsProfile) { . $snsProfile }

Remove-Variable onWindows, snsProfile -ErrorAction SilentlyContinue
