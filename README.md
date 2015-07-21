# Creating a disposable test environment

## Requirements
    Virtualbox                 => https://www.virtualbox.org
    Vagrant                    => http://www.vagrantup.comva
    vagrant-hostmanager        => vagrant plugin install vagrant-hostmanager
    vagrant-cachier (optional) => vagrant plugin install vagrant-cachier

## Setup Node
    git submodule update --init
    vagrant up
    
## Setup morgue
    vagrant ssh
    cd /var/www/morgue
    /usr/local/bin/composer update
    mysql -p -u morgue -h localhost morgue < schemas/postmortems.sql
    mysql -p -u morgue -h localhost morgue < schemas/images.sql
    mysql -p -u morgue -h localhost morgue < schemas/jira.sql
    mysql -p -u morgue -h localhost morgue < schemas/links.sql
    mysql -p -u morgue -h localhost morgue < schemas/irc.sql
    

    morgue  => http://morgue.testlab.vagrant
    mysql
    username: root
    passwd  : secret
    username:  morgue
    passwd  : morgue_password
