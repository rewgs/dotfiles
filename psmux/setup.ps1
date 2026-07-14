#Requires -Version 7.0
#
# Sets up psmux:
# - Finds the subdirectory in dots that matches $env:COMPUTERNAME; prompts if not found.
# - Creates $HOME\.config\tmux as a real directory and symlinks each item from the
#   matching dots dir into it, keeping plugin installs outside the dotfiles repo.
# - Symlinks $HOME\.config\tmux\tmux.conf to $HOME\.tmux.conf.
#
# Plugins are managed via tmuxpanel (winget install marlocarlo.tmuxpanel).
# Requires Developer Mode or elevation for file symlinks.
# Run with -DryRun to show what will happen without executing.

param(
    [switch]$DryRun
)

function Run {
    param([scriptblock]$ScriptBlock, [string]$Description)
    if ($DryRun) {
        Write-Host "[dry-run] $Description"
    } else {
        & $ScriptBlock
    }
}

function Setup-Config {
    param([string]$DotsDir)

    $hostname = $env:COMPUTERNAME
    $hostDir = Join-Path $DotsDir $hostname

    if (-not (Test-Path $hostDir -PathType Container)) {
        Write-Host "No config found for hostname '$hostname'."
        Write-Host "Available configs:"
        Get-ChildItem $DotsDir -Directory | ForEach-Object { Write-Host "  $($_.Name)" }
        Write-Host

        $configs = Get-ChildItem $DotsDir -Directory | Select-Object -ExpandProperty Name

        $chosen = Read-Host "Which config to use as a base?"

        if ($chosen -notin $configs) {
            Write-Error "Invalid choice '$chosen'. Exiting."
            exit 1
        }

        $action = $null
        while ($action -notin @('use', 'copy')) {
            $action = Read-Host "Use '$chosen' as-is, or copy it to create a new config for '$hostname'? [use/copy]"
            if ($action -notin @('use', 'copy')) {
                Write-Host "Please enter 'use' or 'copy'."
            }
        }

        if ($action -eq 'copy') {
            Write-Host "Copying '$chosen' config to '$hostname'..."
            $src = Join-Path $DotsDir $chosen
            Run { Copy-Item $src $hostDir -Recurse } "Copy-Item `"$src`" `"$hostDir`" -Recurse"
        } else {
            $hostDir = Join-Path $DotsDir $chosen
        }
    }

    $configDst = Join-Path $HOME '.config\tmux'

    $existing = Get-Item $configDst -ErrorAction SilentlyContinue
    if ($existing -and ($existing.Attributes -band [System.IO.FileAttributes]::ReparsePoint)) {
        Run { Remove-Item $configDst -Force } "Remove-Item `"$configDst`""
        $existing = $null
    }

    if (-not (Test-Path $configDst -PathType Container)) {
        Run { New-Item -ItemType Directory -Path $configDst -Force | Out-Null } "New-Item -ItemType Directory -Path `"$configDst`""
    }

    Get-ChildItem $hostDir | ForEach-Object {
        $src = $_.FullName
        $name = $_.Name
        $dst = Join-Path $configDst $name
        $isDir = $_.PSIsContainer

        $old = Get-Item $dst -ErrorAction SilentlyContinue
        if ($old) {
            if ($old.PSIsContainer -and -not ($old.Attributes -band [System.IO.FileAttributes]::ReparsePoint)) {
                Run { Remove-Item $dst -Recurse -Force } "Remove-Item `"$dst`" -Recurse -Force"
            } else {
                Run { Remove-Item $dst -Force } "Remove-Item `"$dst`""
            }
        }

        $type = if ($isDir) { 'Junction' } else { 'SymbolicLink' }
        Run { New-Item -ItemType $type -Path $dst -Target $src | Out-Null } "New-Item -ItemType $type -Path `"$dst`" -Target `"$src`""

        if (-not $DryRun) {
            Write-Host "Linked:`n`t$src`n`tto`n`t$dst"
        }
    }

    $confSrc = Join-Path $configDst 'tmux.conf'
    $confDst = Join-Path $HOME '.tmux.conf'

    $old = Get-Item $confDst -ErrorAction SilentlyContinue
    if ($old) {
        Run { Remove-Item $confDst -Force } "Remove-Item `"$confDst`""
    }

    Run { New-Item -ItemType SymbolicLink -Path $confDst -Target $confSrc | Out-Null } "New-Item -ItemType SymbolicLink -Path `"$confDst`" -Target `"$confSrc`""

    if (-not $DryRun) {
        Write-Host "Linked:`n`t$confSrc`n`tto`n`t$confDst"
    }
}

if ($DryRun) {
    Write-Host "NOTE: This is a dry-run. No changes will be made."
}

$dotsDir = Resolve-Path (Join-Path $PSScriptRoot 'dots')

Setup-Config $dotsDir
