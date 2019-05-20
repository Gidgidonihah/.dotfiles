# Crux specific helpers
alias cdx='scd crux'
alias cdo='scd ops'
alias cruxalias='cat ~/.profile.d/crux.sh'

# UI development
alias tw="yarn test --watch"
alias crux-ui="cd ~/Sites/crux/crux-ui/; AXIOS_DELAY=0 yarn hot"
alias crux-bak="cd ~/Sites/crux/crux-bak/; AXIOS_DELAY=0 yarn hot"
alias crux-ops="cd ~/Sites/crux/crux-ops/; yarn start"
alias crux-crul="cd ~/Sites/crux/crux-crul/; yarn start"

# Integration development
alias vfd='docker run -v `echo $PWD`:/action_test -w /action_test --rm -it --entrypoint=dcrunner.py projectthanos/crux-docker:action_test'
alias cxv="vfd && drone1.0.1 exec"
alias mvzip='TO=`echo ${PWD%actions*}actions/`; find . -iregex ".*zip$" -mindepth 2 -exec mv {} $TO \;'
alias zipcrux="python3 -m integrations.dev.zip_feed_src -g -b"
alias zcr="zipcrux"

# API codebase development
alias sqlx="mycli -h 127.0.0.1 -u develro -pd3v3lRO"
alias msqlx="mysql --auto-rehash -h 127.0.0.1 -u develro -pd3v3lRO"
## Test running. For example:
### testapi apps.adminstration
### note that alias cannot be used with entr. Instead:
# find apps/administration -iname '*.py' | entr -c docker exec -i -t crux-api_web_1 ./manage.py test --testrunner=django_utils.test.runners.PrettyTestRunner --keepdb apps.administration
alias testapi="docker exec -i -t crux-api_web_1 ./manage.py test --testrunner=django_utils.test.runners.PrettyTestRunner --keepdb"


function pycover(){
    unset AUTH_TOKEN
    unset THANOS_API
    unset OUT_DIRECTORY
    LOCATION=${1:-discover}
    echo "Running tests against $LOCATION"
    find . -iname '*.py' | entr -c -s "coverage run -m --source=. unittest $LOCATION && coverage html"
}

