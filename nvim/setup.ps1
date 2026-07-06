# Sets up neovim:
# - Finds the subdirectory in dots/lua/machines that matches $env:COMPUTERNAME; prompts if not found,
#   with an option to use an existing machine's config as-is or copy it to create a new one.
# - Symlinks the dots dir to $env:LOCALAPPDATA\nvim.
# - Symlinks the chosen dots/lua/machines/<hostname> dir to dots\lua\plugins\machine.
#
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

# Copies a machine config directory, preserving symlinks rather than resolving them.
function Copy-MachineConfig {
    param([string]$Source, [string]$Destination)
    New-Item -ItemType Directory -Path $Destination -Force | Out-Null
    foreach ($item in Get-ChildItem -Path $Source -Force) {
        $destPath = Join-Path $Destination $item.Name
        if ($item.LinkType -eq "SymbolicLink") {
            New-Item -ItemType SymbolicLink -Path $destPath -Target $item.Target | Out-Null
        } else {
            Copy-Item -Path $item.FullName -Destination $destPath -Recurse
        }
    }
}

function Main {
    $dotsDir = Join-Path $PSScriptRoot "dots"
    $machinesDir = Join-Path $dotsDir "lua\machines"
    $machineDir = Join-Path $machinesDir $env:COMPUTERNAME

    if (-not (Test-Path $machineDir -PathType Container)) {
        Write-Host "No config found for hostname '$($env:COMPUTERNAME)'."
        Write-Host "Available configs:"
        $configs = @(Get-ChildItem -Path $machinesDir -Directory | ForEach-Object { $_.Name })
        for ($i = 0; $i -lt $configs.Count; $i++) {
            Write-Host "  [$($i + 1)] $($configs[$i])"
        }
        Write-Host ""

        $chosen = $null
        while ($null -eq $chosen) {
            $raw = Read-Host "Which config to use as a base? (name or number)"
            if ($raw -match '^\d+$') {
                $idx = [int]$raw - 1
                if ($idx -ge 0 -and $idx -lt $configs.Count) {
                    $chosen = $configs[$idx]
                } else {
                    Write-Host "Invalid number. Please choose between 1 and $($configs.Count)."
                }
            } elseif ($configs -contains $raw) {
                $chosen = $raw
            } else {
                Write-Host "Invalid choice '$raw'. Please enter a config name or number."
            }
        }

        $action = $null
        while ($null -eq $action) {
            $response = Read-Host "Use '$chosen' as-is, or copy it to create a new config for '$($env:COMPUTERNAME)'? [use/copy]"
            switch ($response) {
                "use"  { $action = "use" }
                "copy" { $action = "copy" }
                default { Write-Host "Please enter 'use' or 'copy'." }
            }
        }

        if ($action -eq "copy") {
            $srcConfig = Join-Path $machinesDir $chosen
            Write-Host "Copying '$chosen' config to '$($env:COMPUTERNAME)'..."
            Run "Copy-MachineConfig '$srcConfig' -> '$machineDir'" {
                Copy-MachineConfig -Source $srcConfig -Destination $machineDir
            }
        } else {
            $machineDir = Join-Path $machinesDir $chosen
        }
    }

    # Symlink dots/ to $env:LOCALAPPDATA\nvim
    $dst = Join-Path $env:LOCALAPPDATA "nvim"

    $parent = Split-Path -Parent $dst
    if (-not (Test-Path $parent)) {
        Run "New-Item -ItemType Directory -Path '$parent'" {
            New-Item -ItemType Directory -Path $parent | Out-Null
        }
    }

    if (Test-Path $dst -PathType Any) {
        $existing = Get-Item $dst -Force
        if ($existing.LinkType -eq "SymbolicLink") {
            Run "Remove-Item '$dst'" { Remove-Item $dst }
        } else {
            Write-Host "Warning: $dst is a real directory, not a symlink. Removing it."
            Run "Remove-Item -Recurse -Force '$dst'" { Remove-Item -Recurse -Force $dst }
        }
    }

    Run "New-Item -ItemType SymbolicLink -Path '$dst' -Target '$dotsDir'" {
        New-Item -ItemType SymbolicLink -Path $dst -Target $dotsDir | Out-Null
    }

    if (-not $DryRun) {
        Write-Host "Symlinked:"
        Write-Host "`t$dotsDir"
        Write-Host "`tto"
        Write-Host "`t$dst"
    }

    # Symlink machines/<hostname> to dots\lua\plugins\machine
    $machineLink = Join-Path $dotsDir "lua\plugins\machine"

    if (Test-Path $machineLink -PathType Any) {
        $existing = Get-Item $machineLink -Force
        if ($existing.LinkType -eq "SymbolicLink") {
            Run "Remove-Item '$machineLink'" { Remove-Item $machineLink }
        } else {
            Write-Host "Warning: $machineLink is a real directory. Removing it."
            Run "Remove-Item -Recurse -Force '$machineLink'" { Remove-Item -Recurse -Force $machineLink }
        }
    }

    Run "New-Item -ItemType SymbolicLink -Path '$machineLink' -Target '$machineDir'" {
        New-Item -ItemType SymbolicLink -Path $machineLink -Target $machineDir | Out-Null
    }

    if (-not $DryRun) {
        Write-Host "Symlinked:"
        Write-Host "`t$machineDir"
        Write-Host "`tto"
        Write-Host "`t$machineLink"
    }
}

if ($DryRun) { Write-Host "NOTE: This is a dry-run. No changes will be made." }

Main
