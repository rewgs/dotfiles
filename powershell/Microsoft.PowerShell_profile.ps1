# =============================================================================
# Oh-My-Posh
# =============================================================================

# # initializes Oh-My-Posh
$private:themeName = "onehalf.minimal"
$private:theme = "$themeName.omp.json"
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/$theme" | Invoke-Expression

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

function Reset-Shell {
    . $PROFILE
}


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
    ls -al
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
#
# NOTE: Aliases can not have spaces in the field following `-Value`!
# Instead, must be wrapped in a function and that function invoked.

function Remove-Aliases {
    $aliases = @(
        "cls"
    )

    foreach ($a in $aliases) {
        if (Test-Path -Path alias:$a) {
            # del alias:$a -force
            Remove-Alias $a
        }
    }
}


function Add-Aliases {
    $aliases = @(
        @{ name = 'es';    value = 'Reset-Shell' },
        @{ name = 'c';     value = 'clear' },
        @{ name = 'cls';   value = 'Invoke-ClearAndList' },
        @{ name = 'v';     value = 'nvim' },
        @{ name = 'vp';    value = 'Open-ProfileWithNvim' },
        @{ name = 'gfarp'; value = 'Invoke-GitFetchResetAndPull' },
        @{ name = 'd';     value = 'Open-Dotfiles' }
    )

    foreach ($a in $aliases) {
        # NOTE: the `$()` around `$a['key']`. 
        # Unlike most languages, PowerShell will *not* expand a variable in a string. 
        # Instead, the variable must be an expression, i.e. wrapped in `$()`
        $name = $($a.name)
        $value = $($a.value)

        # Write-Output "$name; $value"

        if (Test-Path -Path alias:$name) {
            # Write-Output "Removing alias $name"
            # del alias:$name -force
            Remove-Alias $name
        }
        if (-Not (Test-Path -Path alias:$name)) {
            # Write-Output "Adding alias $name"
            New-Alias -Scope Global -Name $name -Value $value
        }
    }
}

function Initialize-Aliases {
    Remove-Aliases
    Add-Aliases
}
Initialize-Aliases
