# Setup fzf
# ---------
set -o vi
if [[ ! "$PATH" == */Users/jason/.fzf/bin* ]]; then
  export PATH="$PATH:/Users/jason/.fzf/bin"
fi

# Man path
# --------
if [[ ! "$MANPATH" == */Users/jason/.fzf/man* && -d "/Users/jason/.fzf/man" ]]; then
  export MANPATH="$MANPATH:/Users/jason/.fzf/man"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/jason/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/Users/jason/.fzf/shell/key-bindings.bash"
