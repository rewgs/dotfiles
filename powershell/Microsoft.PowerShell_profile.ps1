# =============================================================================
# Oh-My-Posh
# =============================================================================

# # initializes Oh-My-Posh
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/onehalf.minimal.omp.json" | Invoke-Expression

# vi mode
Set-PSReadLineOption -EditMode Vi
# Set-PSReadlineOption -ViModeIndicator Script -ViModeChangeHandler {
    # Param($mode)
    # $Env:SHELL_VI_MODE = $mode
    # go back to the beginning of the line
    # Write-Host -NoNewLine "`e[1000D"
    # rewrite the prompt manually
    # write-Host -NoNewLine (oh-my-posh --shell pwsh --config ~/.jandedobbeleer.omp.json)
# }

# =============================================================================
# functions
# =============================================================================

function grep {
  $input | out-string -stream | select-string $args
}

function Update-Oh-My-Posh {
    if ($IsWindows) {
        Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://ohmyposh.dev/install.ps1'))
    }
}

function Open-Profile-With-Nvim {
    nvim $PROFILE
}

function Clear-And-List {
    clear
    ls
}

function Delete-Aliases {
    $private:aliasesToDelete = @(
        "cls"
    )
    foreach ($a in $aliasesToDelete) {
        del alias:$a -force
    }
}


# =============================================================================
# aliases 
# =============================================================================

# This must be run first to avoid any conflicts (e.g. with `cls`, which by default is the same as `clear`)
Delete-Aliases

New-Alias -Name "c" -Value "clear"
New-Alias -Name "cls" -Value Clear-And-List
New-Alias -Name "v" -Value "nvim"
New-Alias -Name "vp" -Value Open-Profile-With-Nvim
