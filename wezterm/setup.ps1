function Symlink-Dotfiles([string]$thisFile) {
    $private:thisDir = Split-Path -Parent $thisFile
    $private:src = Join-Path -Path $thisDir -ChildPath "dots"
    $private:dst = Join-Path -Path $env:HOMEPATH -ChildPath ".config" -AdditionalChildPath "wezterm"

    Write-Output "This file: $thisFile"
    Write-Output "This dir: $thisDir"
    Write-Output "src: $src"
    Write-Output "dst: $dst"

    if (Test-Path $dst) {
        Write-Output "$dst exists!"
        Write-Output "Removing $dst.."
        Remove-Item -Path $dst
    }

    if (-Not (Test-Path $dst)) {
        Write-Output "$dst does not exist!"
        Write-Output "Symlinking:"
        Write-Output "$src"
        Write-Output "...to..."
        Write-Output "$dst"
        New-Item -Path $dst -ItemType SymbolicLink -Value $src
    }
}


function Main([string]$thisFile) {
    Symlink-Dotfiles $thisFile
}


$private:thisFile = $MyInvocation.MyCommand.Path
Main $thisFile
