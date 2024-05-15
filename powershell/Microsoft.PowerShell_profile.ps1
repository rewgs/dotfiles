# # Initializes Oh-My-Posh
# FIXME: not working on macOS
oh-my-post init pwsh | Invoke-Expression

# vi mode
Set-PSReadLineOption -EditMode Vi
# Set-PSReadlineOption -ViModeIndicator Script -ViModeChangeHandler {
#     Param($mode)
#     $Env:SHELL_VI_MODE = $mode
#     # go back to the beginning of the line
#     Write-Host -NoNewLine "`e[1000D"
#     # rewrite the prompt manually
#     write-Host -NoNewLine (oh-my-posh --shell pwsh --config ~/.jandedobbeleer.omp.json)
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
