# sns
if [[ -d "$HOME/work/sns" ]]; then
    SNS_DIR="$HOME/work/sns"
    alias sns="cd $SNS_DIR"
elif [[ -d "$HOME/sns" ]]; then
    SNS_DIR="$HOME/sns"
    alias sns="cd $SNS_DIR"
elif [[ -d "$HOME/.sns" ]]; then
    SNS_DIR="$HOME/.sns"
    alias sns="cd $SNS_DIR"
else
    echo "SNS_DIR not set."
fi

# snsd
if [[ -d "$SNS_DIR/development" ]]; then
    SNS_DEV="$SNS_DIR/development"
    alias snsd="cd $SNS_DEV"
else
    echo "SNS_DEV not set."
fi
