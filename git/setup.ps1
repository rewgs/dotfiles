<#
On Windows, git looks for a global config file at ~/.gitconfig.
However, it also respects the XDG Base Directory Specification (even on Windows),
and thus will look in ~/.config/git for both config and ignore files.

This script symlinks the dots dir to ~/.config/git, and _also_ symlinks ~/.config/git/config
to ~/.gitconfig just to cover our bases.
#>

$_thisFile = $MyInvocation.MyCommand.Path
$_thisDir = Split-Path -Parent $_thisFile
$src = Join-Path -Path $_thisDir -ChildPath "dots"
$dst = Join-Path -Path $HOME -ChildPath ".config" -AdditionalChildPath "git"

# Links $linkPath -> $targetPath, replacing whatever is already at $linkPath.
# $fallbackType is used if New-Item -ItemType SymbolicLink fails for lack of
# admin/Developer Mode on Windows: "Junction" for directories, "HardLink" for files.
function Set-Link([string]$linkPath, [string]$targetPath, [string]$fallbackType) {
    $linkParent = Split-Path -Parent $linkPath
    if (-not (Test-Path $linkParent)) {
        New-Item -Path $linkParent -ItemType Directory -Force | Out-Null
    }

    # Get-Item -Force is needed to see existing symlinks/hidden items.
    $existing = Get-Item -Path $linkPath -Force -ErrorAction SilentlyContinue
    if ($null -ne $existing) {
        if ($null -ne $existing.LinkType) {
            # It's a symlink/junction/hardlink: remove the link itself, never -Recurse.
            Remove-Item -Path $linkPath -Force
        } else {
            Remove-Item -Path $linkPath -Recurse -Force
        }
    }

    try {
        New-Item -Path $linkPath -ItemType SymbolicLink -Value $targetPath -ErrorAction Stop | Out-Null
    } catch {
        if ($IsWindows) {
            Write-Warning "SymbolicLink failed ($_); falling back to a $fallbackType."
            New-Item -Path $linkPath -ItemType $fallbackType -Value $targetPath | Out-Null
        } else {
            throw
        }
    }
}

# ~/.config/git -> ./dots
Set-Link -linkPath $dst -targetPath $src -fallbackType "Junction"

# ~/.gitconfig -> ~/.config/git/config
$gitconfigDst = Join-Path -Path $HOME -ChildPath ".gitconfig"
$gitconfigSrc = Join-Path -Path $dst -ChildPath "config"
Set-Link -linkPath $gitconfigDst -targetPath $gitconfigSrc -fallbackType "HardLink"
