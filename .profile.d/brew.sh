if command -v /opt/homebrew/bin/brew &> /dev/null
then
    # Brew is on apple silicon
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif command -v /usr/local/bin/brew &> /dev/null
then
    # Brew is on intel silicon
    eval "$(/usr/local/bin/brew shellenv)"
else
    echo "no brew found"
    exit 1
fi
