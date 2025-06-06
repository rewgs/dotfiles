# =============================================================================
# functions
# =============================================================================

function Reset-Shell {
    . $PROFILE
}

function grep {
  $input | out-string -stream | select-string $args
}

function touch {
	param(
		[parameter(mandatory=$true, position=0)]
		[string]$filename
	)
	echo $null >> $filename
}

function Open-ProfileWithNvim {
    nvim $PROFILE
}

function Invoke-ClearAndList {
    clear
    ls
}

function Invoke-GitFetchResetAndPull {
    git fetch --all
    git reset --hard
    git pull
}

function Open-Dotfiles {
    $dir = Join-Path $HOME "dotfiles"
    if (Test-Path $dir) {
        Set-Location $dir
    } else {
        Write-Output "$dir does not exist!"
    }
}

# TODO: Move to Sparks-and-Shadows/env repo
# function Open-Sns {
#     $dir = Join-Path $HOME "work" "sns"
#     if (Test-Path $dir) {
#         Set-Location $dir
#     } else {
#         Write-Output "$dir does not exist!"
#     }
# }

# TODO: Move to Sparks-and-Shadows/env repo
# function Open-SnsDevelopment {
#     $dir = Join-Path $HOME "work" "sns" "development"
#     if (Test-Path $dir) {
#         Set-Location $dir
#     } else {
#         Write-Output "$dir does not exist!"
#     }
# }

# TODO: Check if pyenv-win is installed; if not, install pyenv-win (see script in $DOTFILES/utils/installs/windows)
function Install-PythonVersion {
    Param (
        [Parameter(Mandatory=$True)]
        [String[]]$versions
    )
    $installed = $(pyenv versions)
    foreach ($version in $versions) {
        if (-Not ($version -in $installed)) {
            # write-output "$version is not installed!"
            pyenv install $version

            $_python = Join-Path $env:PYENV_ROOT "versions" $version 
            $python_exe = Join-Path $_python "python3.exe"

            # FIXME: -m is throwing an "unexpected token error"
            # Upgrade pip
            # $python_exe -m pip install --upgrade pip

            # FIXME: -m is throwing an "unexpected token error"
            # Install virtualenv
            # $python_exe -m pip install --user virtualenv
        }
    }
}

function Create-Venv {
    python -m venv .venv
}

function Activate-Venv {
    $activate_script = Join-Path $pwd ".venv" "Scripts" "activate"
    .\$activate_script
}

# TODO: Make sure current directory contains a .venv.
function Deactivate-Venv {
    deactivate
}

function Am-Admin {
    [OutputType([bool])]

    $currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
    $CheckforAdmin = $currentPrincipal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
    if ($CheckforAdmin) {
        # Write-Host "PowerShell is running as administrator."
        return $true
    }
    # Write-Host "PowerShell is not running as administrator."
    return $false
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
        @{ name = 'es';     value = 'Reset-Shell' },
        @{ name = 'c';      value = 'clear' },
        @{ name = 'cls';    value = 'Invoke-ClearAndList' },
        @{ name = 'v';      value = 'nvim' },
        @{ name = 'vp';     value = 'Open-ProfileWithNvim' },
        @{ name = 'gfarp';  value = 'Invoke-GitFetchResetAndPull' },
        @{ name = 'd';      value = 'Open-Dotfiles' },
        @{ name = 'sns';    value = 'Open-Sns' },
        @{ name = 'snsd';   value = 'Open-SnsDevelopment' }
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

# =============================================================================
# Setup
# =============================================================================

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

# Makes autocomplete more zsh-ish
Set-PSReadLineKeyHandler -Chord "Tab" -Function MenuComplete
Set-PSReadLineKeyHandler -Chord "RightArrow" -Function ForwardWord

$PSStyle.FileInfo.Directory = ""

# Starship
Invoke-Expression (&starship init powershell)
