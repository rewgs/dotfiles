# New-Item -Path C:\LinkDir -ItemType SymbolicLink -Value F:\RealDir

$thisFile = $MyInvocation.MyCommand.Path
$thisDir = Split-Path -Parent $thisFile
$profileFile = "Microsoft.PowerShell_profile.ps1"
$src = Join-Path -Path $thisDir -ChildPath $profileFile

if ($IsWindows) {
    $dst = "~/Documents/PowerShell/$profileFile"
} 
else {
    $dstDir = "~/.config/powershell"
    if (-Not (Test-Path $dstDir)) {
        New-Item -Type Directory $dstDir
    }
    $dst = Join-Path -Path $dstDir -ChildPath $profileFile
}
New-Item -Path $dst -ItemType SymbolicLink -Value $src
