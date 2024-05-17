# Symlinks the 'dots' dir to '$env:LOCALAPPDATA\nvim'
#
# TODO: fix "No C compiler found" error:
# https://www.reddit.com/r/neovim/comments/14oozmu/neovim_cant_find_c_compiler/
# https://github.com/nvim-treesitter/nvim-treesitter/wiki/Windows-support


$script:_THIS_FILE = $MyInvocation.MyCommand.Definition
$script:_THIS_DIR = split-path -parent $_THIS_FILE
# Write-Output $_THIS_FILE
# Write-Output $_THIS_DIR


function get-packer {
    $private:SRC = "https://github.com/wbthomason/packer.nvim.git"
    $private:DST = "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"

    if (-Not (Test-Path -Path $DST)) {
        $private:DST_DIR = split-path -parent $DST
    	Write-Output "$DST does not exist. Cloning packer.nvim to $DST_DIR..."

        if (-Not (Test-Path -Path $DST_DIR)) {
            New-Item -ItemType "directory" -Path $DST_DIR
        }

        git clone $SRC $DST
    }
}


function symlink-dotfiles {
    $private:SRC = Join-Path -Path $_THIS_DIR -ChildPath "dots"
    $private:DST = Join-Path -Path $env:LOCALAPPDATA -ChildPath "nvim"
    # Write-Output $SRC
    # Write-Output $DST
    
    if (-Not (Test-Path -Path $DST)) {
    	Write-Output "$DST does not exist. Symlinking $SRC to $DST..."
    	$link = New-Item -ItemType SymbolicLink -Path $DST -Target $SRC
    }
    
    # if (Test-Path -Path $DST) {
    #     Write-Output "$DST exists!"
    # }
}
 

function main {
    get-packer
    symlink-dotfiles
}
main
