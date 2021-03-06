# Git prompt settings
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWCOLORHINTS=true

# Virtualenv prompt settings
VIRTUAL_ENV_DISABLE_PROMPT=1

# Source my git prompt code
if [ ! -n "$(type -t __git_ps1)" ] && [ ! "$(type -t __git_ps1)" = function ] && [ -f ~/.profile.d/git-prompt.sh ]; then
    source ~/.profile.d/git-prompt.sh
fi

# Reset
Color_Off='\e[0m'       # Text Reset

# Regular Colors
Black='\e[0;30m'        # Black
Red='\e[0;31m'          # Red
Green='\e[0;32m'        # Green
Yellow='\e[0;33m'       # Yellow
Blue='\e[0;34m'         # Blue
Purple='\e[0;35m'       # Purple
Cyan='\e[0;36m'         # Cyan
White='\e[0;37m'        # White

# Bold
BBlack='\e[1;30m'       # Black
BRed='\e[1;31m'         # Red
BGreen='\e[1;32m'       # Green
BYellow='\e[1;33m'      # Yellow
BBlue='\e[1;34m'        # Blue
BPurple='\e[1;35m'      # Purple
BCyan='\e[1;36m'        # Cyan
BWhite='\e[1;37m'       # White

# Underline
UBlack='\e[4;30m'       # Black
URed='\e[4;31m'         # Red
UGreen='\e[4;32m'       # Green
UYellow='\e[4;33m'      # Yellow
UBlue='\e[4;34m'        # Blue
UPurple='\e[4;35m'      # Purple
UCyan='\e[4;36m'        # Cyan
UWhite='\e[4;37m'       # White

# Background
On_Black='\e[40m'       # Black
On_Red='\e[41m'         # Red
On_Green='\e[42m'       # Green
On_Yellow='\e[43m'      # Yellow
On_Blue='\e[44m'        # Blue
On_Purple='\e[45m'      # Purple
On_Cyan='\e[46m'        # Cyan
On_White='\e[47m'       # White

# High Intensity
IBlack='\e[0;90m'       # Black
IRed='\e[0;91m'         # Red
IGreen='\e[0;92m'       # Green
IYellow='\e[0;93m'      # Yellow
IBlue='\e[0;94m'        # Blue
IPurple='\e[0;95m'      # Purple
ICyan='\e[0;96m'        # Cyan
IWhite='\e[0;97m'       # White

# Bold High Intensity
BIBlack='\e[1;90m'      # Black
BIRed='\e[1;91m'        # Red
BIGreen='\e[1;92m'      # Green
BIYellow='\e[1;93m'     # Yellow
BIBlue='\e[1;94m'       # Blue
BIPurple='\e[1;95m'     # Purple
BICyan='\e[1;96m'       # Cyan
BIWhite='\e[1;97m'      # White

# High Intensity backgrounds
On_IBlack='\e[0;100m'   # Black
On_IRed='\e[0;101m'     # Red
On_IGreen='\e[0;102m'   # Green
On_IYellow='\e[0;103m'  # Yellow
On_IBlue='\e[0;104m'    # Blue
On_IPurple='\e[0;105m'  # Purple
On_ICyan='\e[0;106m'    # Cyan
On_IWhite='\e[0;107m'   # White

if [[ ${EUID} == 0 ]] ; then
    sq_color="\001$Red\002"
else
    sq_color="\001$Blue\002"
fi
function SQcolor(){
    if [[ ${EUID} == 0 ]] ; then
        printf "\001$Red\002"
    else
        printf "\001$Blue\002"
    fi
}

# Special Characters
Longdash="\342\224\200" # "─"
Topleft="\342\224\214" # "┌"
Bottomleft="\342\224\224" # "└"
Failed_X="\342\234\227" # "✗"

TIME="[\[$White\]\@$sq_color]"
HOST="[\[$White\]\h$sq_color]"
GIT="[\[$Green\$(__git_ps1 "%s")$sq_color]"
CWD="[$Yellow\w$sq_color]"

function virtualenv_info(){
    # Get Virtual Env
    if [[ -n "$VIRTUAL_ENV" ]]; then
        # Strip out the path and just leave the env name
        venv="${VIRTUAL_ENV##*/}"
    else
        # In case you don't have one activated
        venv=''
    fi
    # Must use \001 and \002, printf, and the SQcolor function to print colors from functions
    [[ -n "$venv" ]] && printf "[\001$Purple\002$venv$(SQcolor)]-"
}

function failed_cmd(){
    CODE=$@
    # Must use \001 and \002, printf, and the SQcolor function to print colors from functions
    [[ $@ != 0 ]] && printf "[\001$Red\002$Failed_X$(SQcolor)]"
    return $CODE
}

function f_notifyme {
    LAST_EXIT_CODE=$@
    # I should be able to use:
    # CMD=$(fc -ln -1)
    # but because of some sillyness with my configs, that always gives me the penultimate command
    # so instead, I'm generic:
    CMD='The last terminal command'
    # # No point in waiting for the command to complete
    ~/.sh/notify_cmd_complete "$CMD" "$LAST_EXIT_CODE" &
}

PS1="$sq_color\
$Topleft\
$Longdash\
\$(failed_cmd \$?)\
\$(f_notifyme \$?)\
$Longdash\
\$(virtualenv_info)\
$HOST-\
$GIT-\
$CWD\
\n\
$Bottomleft\
$Longdash\
$Longdash>>\
\[$White\]\\[\\033[0m\\]"

unset sq_color
