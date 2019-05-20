# .dotfiles

This is my home public home directory and all the things I need to set up a new system the way I like.
This started based off the excellent [.dotfiles by Mathias Bynens](https://github.com/mathiasbynens/dotfiles)
and has since grown.

## Installation

If you are setting up a new system, you can simply run:
```
/bin/bash <(curl -fsSL https://raw.githubusercontent.com/Gidgidonihah/.dotfiles/master/.install/init.sh)
```

If you would like to simply apply the dotfiles:
```
/bin/bash <(curl -fsSL https://raw.githubusercontent.com/Gidgidonihah/.dotfiles/master/.install/dotfiles.sh)
```
Please note that by default that script uses ssh to clone.
You may want to copy and use https if you don't have access.

## Personal TODO

### Vim tweaks, updates and things to try

* Try replacing the pulse line function with https://github.com/inside/vim-search-pulse
* Try a new line commenting function:
    * https://github.com/tpope/vim-commentary
    * https://github.com/tomtom/tcomment_vim
* Take a look at incorporating parts of these
    * https://github.com/L0stSoul/vim-config
    * https://github.com/victorvoid/vim-frontend
    * https://dougblack.io/words/a-good-vimrc.html
