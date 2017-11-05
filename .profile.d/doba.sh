# ls options differ between my mac an unix boxes.
if [ ${OSTYPE//[0-9.]/} == 'darwin' ]; then
    alias salt='ssh ec2-user@salt.doba.com'
    alias npm-check="npm-check -i babel* -i eslint-* -i react-hot-loader -i webpack-dev-server"
    alias sshs='ssh root@jweir.dev.doba.com'
    alias cdc='cd ~/Sites/doba/docker.doba.com/src/'
    alias cdd='cd ~/Sites/doba/docker.doba.com/'
    alias cdt='cd ~/Sites/thanos/thanos-ui/'
    alias sql="mycli -h 127.0.0.1 -u root -proot"
    alias msql="mysql --auto-rehash -h 127.0.0.1 -u root -proot"
    alias dobad='docker-compose up -d aurora-local dynamodb-local kinesis-local memcached s3-local sqs-local solr-local; docker-compose up web'
    alias docker-web='docker exec -i -t dockerdobacom_web_1 /bin/bash'
    alias cda="cd ~/Sites/doba/docker.doba.com/src/tech.doba.com/ansible"
else
    alias sshs='echo "You are already on the dev server, dummy."'
    alias sql='mysql --auto-rehash -uroot -pQu@ntum Doba'
    alias runserver="cd /home/build/new.doba.com/ && ./manage.py runserver_plus --cert tmp 0.0.0.0:8000"
    alias elog="tail -f /var/log/httpd/error_log | sed 's/\\\\n/\\n/g'"

    if [ -d /home/build/new.doba.com -a -n "${SSH_CLIENT}" ]; then
        cd /home/build/new.doba.com/;
    fi
fi

# thanos grep
thanos_grep(){
    grep -r $@ --exclude=./node_modules* --exclude=./assets/dist* .
}
