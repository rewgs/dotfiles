install_google_chrome () {
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

    # apt update
    # for d in "${deps[@]}"; do
    #     apt install "$d" -y
    # done

    wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
    dpkg -i google-chrome-stable_current_amd64.deb
    apt --fix-broken install
}


install_lazygit_from_source () {
    if [ ! -d "$HOME"/src ]; then mkdir "$HOME"/src; fi
    cd "$HOME"/src
    git clone https://github.com/jesseduffield/lazygit.git
    cd "$HOME"/src/lazygit
    go install
}


