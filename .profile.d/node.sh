export NVM_DIR="$HOME/.nvm"
[ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && . "$HOMEBREW_PREFIX/opt/nvm/nvm.sh"  # This loads nvm
[ -s "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion" ] && . "$HOMEBREW_PREFIX/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

function npmdo { (PATH=$(npm bin):$PATH; eval $@;) }
