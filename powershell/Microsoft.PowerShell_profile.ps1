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

function Update-OhMyPosh {
    if ($IsWindows) {
        Set-ExecutionPolicy Bypass -Scope Process -Force; Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://ohmyposh.dev/install.ps1'))
    }
}

function Open-ProfileWithNvim {
    nvim $PROFILE
}

function Invoke-ClearAndList {
    clear
    ls
}

function Remove-Aliases {
    $private:aliasesToRemove = @(
        "cls"
    )
    foreach ($a in $aliasesToRemove) {
        del alias:$a -force
    }
}

function Invoke-GitFetchResetAndPull {
    git fetch --all
    git reset --hard
    git pull
}

function Open-Dotfiles {
    cd $HOME/dotfiles
}


# =============================================================================
# aliases 
# =============================================================================

# This must be run first to avoid any conflicts (e.g. with `cls`, which by default is the same as `clear`)
Remove-Aliases

New-Alias -Name "c" -Value "clear"
New-Alias -Name "cls" -Value Invoke-ClearAndList
New-Alias -Name "v" -Value "nvim"
New-Alias -Name "vp" -Value Open-ProfileWithNvim
New-Alias -Name "gfarp" -Value Invoke-GitFetchResetAndPull
New-Alias -Name "d" -Value Open-Dotfiles
