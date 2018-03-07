# .bashrc
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Source the profile scripts
# See .profile.d/common.sh for shared (bash/zsh) settings
# See .profile.d/aliases.sh for commonly used aliases
# See .profile.d/functions.sh for commonly used functions
for f in ~/.profile.d/*.sh ~/.profile.d/*.bash; do
    source $f
done
