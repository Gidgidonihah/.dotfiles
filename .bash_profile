alias sshs='ssh root@jason.dev.dropship.com'
alias ls="ls -G"
alias ll="ls -l"
alias cleanup="chflags -R nouchg ."
alias cup="cleanup"
alias dcup="dot_clean -mv /Volumes/build/"

export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

alias ping="ping -c 4"
alias ssbg='/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine -background'

# Source local bashrc
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

# MacPorts Installer addition on 2011-10-12_at_09:48:58: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
