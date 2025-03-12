# Sets up PowerShell Core on Linux, macOS, or Windows.

$_thisFile = $MyInvocation.MyCommand.Path
$_thisDir = Split-Path -Parent $_thisFile
$src = Join-Path -Path $_thisDir -ChildPath "dots"

if ($IsWindows) {
    $dst = Join-Path -Path $env:HOME -ChildPath "Documents" -AdditionalChildPath "PowerShell"
} else {
    $dst = "$HOME/.config/powershell"
}

if (Test-Path $dst) {
    Remove-Item -Path $dst
}

if (-not (Test-Path $dst)) {
    New-Item -Path $dst -ItemType SymbolicLink -Value $src
}

# $thisDir = Split-Path -Parent $MyInvocation.MyCommand.Path
# $profileFile = "Microsoft.PowerShell_profile.ps1"
# $src = Join-Path -Path $thisDir -ChildPath $profileFile
#
# if ($IsWindows) {
#     $dstDir = "~/Documents/PowerShell"
# } 
# else {
#     $dstDir = "~/.config/powershell"
# }
#
# if (-Not (Test-Path $dstDir)) {
#     New-Item -Type Directory $dstDir
# }
#
# $dst = Join-Path -Path $dstDir -ChildPath $profileFile
# if (Test-Path $dst) {
#     Remove-Item -Path $dst
# }
#
# New-Item -Path $dst -ItemType SymbolicLink -Value $src
