function install_google_chrome () {
    # typeset -a deps 
    # deps=(
    #     "libasound2"
    #     "libatk-bridge"
    #     "libatk"
    #     "libatspi"
    #     "libc"
    #     "libcairo"
    #     "libcups"
    #     "libcurl"
    #     "libdbus"
    #     "libdrm"
    #     "libexpat"
    #     "libgbm"
    #     "libglib"
    #     "libgtk"
    #     "libnspr"
    #     "libnss"
    #     "libpango"
    #     "libvulkan"
    #     "libx11"
    #     "libxcb"
    #     "libxcomposite"
    #     "libxdamage"
    #     "libxext"
    #     "libxfixes"
    #     "libxkbcommon"
    #     "libxrandr"
    # )

    # sudo apt update
    # for d in "${deps[@]}"; do
    #     sudo apt install "$d" -y
    # done

    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    sudo dpkg -i google-chrome-stable_current_amd64.deb
    sudo apt --fix-broken install
}


function install_lazygit_from_source () {
    if [ ! -d "$HOME"/src ]; then mkdir "$HOME"/src; fi
    cd "$HOME"/src
    git clone https://github.com/jesseduffield/lazygit.git
    cd "$HOME"/src/lazygit
    go install
}


function install_firefox_without_snap () {
    # assumes that snap has already been removed and `sudo snap remove firefox` run

    # depends on software-properties-common package (installed in `install_from_package_manager()`
    sudo add-apt-repository ppa:mozillateam/ppa

    # alters the Firefox package priority to ensure the PPA/deb/apt version is preferred
    echo '
    Package: *
    Pin: release o=LP-PPA-mozillateam
    Pin-Priority: 1001
    ' | sudo tee /etc/apt/preferences.d/mozilla-firefox

    # ensures future Firefox upgrades are installed
    echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox

    sudo apt update && sudo apt install firefox
}


function install_tailscale () {
    # Add Tailscale’s package signing key and repository:
    curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/jammy.noarmor.gpg | sudo tee /usr/share/keyrings/tailscale-archive-keyring.gpg >/dev/null
    curl -fsSL https://pkgs.tailscale.com/stable/ubuntu/jammy.tailscale-keyring.list | sudo tee /etc/apt/sources.list.d/tailscale.list

    sudo apt-get update
    sudo apt-get install tailscale

    sudo tailscale up
    sudo tailscale up --ssh
}


function install_github_cli () {
    # add repository
	type -p curl >/dev/null || sudo apt install curl -y
	curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg \
	&& sudo chmod go+r /usr/share/keyrings/githubcli-archive-keyring.gpg \
	&& echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null \

	sudo apt update && sudo apt install gh -y
}


function install_oh_my_zsh () {
    # interactive
    # sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

    # unattended
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

    # FIXME: the following doesn't work!
    # `< /dev/tty` forces that new shell to start reading input from the terminal. 
    #   Without this, the script would exit, returning to your calling script. I 
    #   don't want this to happen - I want more functions to run aftr this.
    # exec zsh < /dev/tty
}