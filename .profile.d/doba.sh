# Doba specific helpers
alias cdd='scd doba'

alias salt='ssh ec2-user@salt.doba.com'
alias npm-check="npm-check -i babel* -i eslint-* -i react-hot-loader -i webpack-dev-server"
alias cdc='cd ~/Sites/doba/docker.doba.com/src/'
alias sqld="mycli -h 127.0.0.1 -u root -proot"
alias msqld="mysql --auto-rehash -h 127.0.0.1 -u root -proot"
alias dobad='docker-compose up -d aurora-local dynamodb-local kinesis-local memcached s3-local sqs-local solr-local; docker-compose up web'
alias docker-web='docker exec -i -t dockerdobacom_web_1 /bin/bash'
alias cda="cd ~/Sites/doba/docker.doba.com/src/tech.doba.com/ansible"
alias ggg="~/.sh/doba-git-search.sh"

function dorepos(){
    CODEDIR=~/Sites/doba/docker.doba.com/src;
    cd $CODEDIR
    for REPO in `find . -maxdepth 1 -type d`; do
        cd $REPO;
        hr
        echo $REPO
        hr
        $@
        cd $CODEDIR
    done
}
