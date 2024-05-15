# Sets up PowerShell Core on Linux, macOS, or Windows.


function Symlink-Profile {
    $thisFile = $MyInvocation.MyCommand.Path
    $thisDir = Split-Path -Parent $thisFile
    $profileFile = "Microsoft.PowerShell_profile.ps1"
    $src = Join-Path -Path $thisDir -ChildPath $profileFile
    
    if ($IsWindows) {
        $dstDir = "~/Documents/PowerShell"
    } 
    else {
        $dstDir = "~/.config/powershell"
    }
    
    # Creates $dstDir if it or a part of it doesn't exist (a la `mkdir -p`)
    if (-Not (Test-Path $dstDir)) {
        New-Item -Type Directory $dstDir
    }
    
    $dst = Join-Path -Path $dstDir -ChildPath $profileFile
    if (Test-Path $dst) {
        Remove-Item -Path $dst
    }

    New-Item -Path $dst -ItemType SymbolicLink -Value $src
}


# function Main {
#     Symlink-Profile
# }
# Main
