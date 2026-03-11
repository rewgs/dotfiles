# Symlinks the dots dir to $env:LOCALAPPDATA\nvim.
# Run with -DryRun flag to show what will happen and not actually execute.

param(
    [switch]$DryRun
)

function Run {
    param([string]$Description, [scriptblock]$Action)
    if ($DryRun) {
        Write-Host "[dry-run] $Description"
    } else {
        & $Action
    }
}

function Main {
    $src = Join-Path $PSScriptRoot "dots"
    $dst = Join-Path $env:LOCALAPPDATA "nvim"

    $parent = Split-Path -Parent $dst
    if (-not (Test-Path $parent)) {
        Run "New-Item -ItemType Directory -Path '$parent'" { New-Item -ItemType Directory -Path $parent | Out-Null }
    }

    if (Test-Path $dst -PathType Any) {
        $item = Get-Item $dst -Force
        if ($item.LinkType -eq "SymbolicLink") {
            Run "Remove-Item '$dst'" { Remove-Item $dst }
        } else {
            Write-Host "Warning: $dst is a real directory, not a symlink. Removing it."
            Run "Remove-Item -Recurse -Force '$dst'" { Remove-Item -Recurse -Force $dst }
        }
    }

    Run "New-Item -ItemType SymbolicLink -Path '$dst' -Target '$src'" {
        New-Item -ItemType SymbolicLink -Path $dst -Target $src | Out-Null
    }

    if (-not $DryRun) {
        Write-Host "Symlinked:"
        Write-Host "`t$src"
        Write-Host "`tto"
        Write-Host "`t$dst"
    }
}

if ($DryRun) { Write-Host "NOTE: This is a dry-run. No changes will be made." }

Main
