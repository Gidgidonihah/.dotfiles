alias cdt="scd ~/Sites/termly"
alias nohttp="http --verify=no"

# rspec opens Too Many Files when the whole suite is run.
alias rspec_all="ulimit -n 1024; qspec"

# Multi repo search
alias ggt="~/.sh/multi-repo-search.sh -b ~/Sites/termly"

function specwatch(){
  TESTS=$1
  echo "Watching tests: $TESTS"
  find \
    app/api \
    app/forms \
    app/models \
    app/interactors \
    spec/support/shared_examples \
    $TESTS \
  | entr -cc qspec \
    $TESTS
}
alias ,specwatch=specwatch

function remote-rails-console(){
    # Login to first aws if needed
    echo "Do you wish Log In to AWS?"
    select yn in "Yes" "No"; do
        case $yn in
            Yes ) aws sso login --profile login; break;;
            No ) break;;
        esac
    done
    echo "Querying for pod"

    # Find a webserver pod
    label="app.kubernetes.io/name=web-server"
    pod=$(kubectl get pod -l$label | tail -n1 | awk '{ print $1 }')
    echo "Connecting to pod: $pod"

    # Run the command
    if [[ ! -z $pod ]]; then
        if [[ ! -z $1 ]]; then
            kubectl exec -it $pod -c web-server -- $1
        else
            kubectl exec -it $pod -c web-server -- rails c
        fi
    else
        echo "Unable to find pod with label $label"
    fi
}
alias rrc=remote-rails-console
alias ,rrc=remote-rails-console

function docker-aws-login() {
    aws sso login --profile ecr
    aws --profile ecr ecr get-login-password | docker login -u AWS --password-stdin 104448803897.dkr.ecr.us-west-2.amazonaws.com
}
