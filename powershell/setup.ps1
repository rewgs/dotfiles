# Sets up PowerShell Core on Linux, macOS, or Windows.


$private:_thisFile = $MyInvocation.MyCommand.Path
# Write-Output $_thisFile
# Write-Output $_thisFile.GetType() # string


function Install-Oh-My-Posh {
#     # if ($IsLinux) {
#     # }
#     # TODO: make these `else if` once $IsLinux branch is written; `else` branch
    if ($IsMacOS) {
        brew update
        brew install jandedobbeleer/oh-my-posh/oh-my-posh
    }
#     if ($IsWindows) {
#         Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://ohmyposh.dev/install.ps1'))
#     }
    else {
        Write-Output "Invalid operating system! Exiting now."
        exit
    }
}


function Symlink-Profile([string]$thisFile) {
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


function Main([string]$thisFile) {
    # Install-Oh-My-Posh
    Symlink-Profile $thisFile
}
Main $_thisFile
