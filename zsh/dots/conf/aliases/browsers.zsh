# Chrome
if [[ "$(uname)" == "Darwin" ]]; then
    if [[ -d "/Applications/Google Chrome.app" ]]; then
        alias chrome="open -a Google Chrome"
        alias chromedev="open -a Google Chrome --args --auto-open-devtools-for-tabs"
    fi
elif [[ "$(uname)" == "Linux" ]]; then
    # TODO: Check if Google Chrome is installed
    alias chrome="google-chrome"
    alias chromedev="google-chrome --auto-open-devtools-for-tabs"
fi

# Chromium
if [[ "$(uname)" == "Darwin" ]]; then
    if [[ -d "/Applications/Chromium.app" ]]; then
        alias chromium="open -a Chromium"
        alias chromiumdev="open -a Chromium --args --auto-open-devtools-for-tabs"
    fi
fi
