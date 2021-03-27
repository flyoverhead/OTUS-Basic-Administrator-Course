# OTUS Basic Andinistrator Course Project
Final homework project for OTUS Administrator Course - Basic Level

### Prerequisites
I use vagrant && ansbible to bring machines up and make some magik inside them. Vagrant provisions & manages vitual machines easily and it depends on virtualbox/vmware to run machines. I used virtualbox to run machines. Here are the links to install for both

* [Vagrant](https://www.vagrantup.com/intro/getting-started/install.html) - Vagrant manages virtual machines 
* [Virtualbox](https://www.virtualbox.org/wiki/Linux_Downloads) - Vagrant depends on virtualbox to run virtual machines
* [Ansible](https://github.com/ansible/ansible) - Vagrant uses Ansible to provisioning hosts

### Installing

First install vagrant, ansible and virtualbox on your machine. 
Then, just clone this github repo.
```
git clone https://github.com/viveksatasiya/vagrant-prometheus-grafana.git
cd vagrant-prometheus-grafana/
vagrant up
```
### Postinstall

1. Vagrant ssh to SQL Master (192.168.121.12) and do next:
```
sudo grep 'temporary password' /var/log/mysqld.log
sudo mysql_secure_installation
sudo mysql -u root -p
SELECT * from mysql.user where User="root" \G
exit
sudo nano /etc/my.cnf
    bind-address = 192.168.121.12
sudo systemctl restart mysqld.service
sudo mysql -u root -p
create user repl@192.168.121.13 IDENTIFIED WITH caching_sha2_password BY 'tynMOD#123';
GRANT REPLICATION SLAVE ON *.* TO repl@192.168.121.13;
SELECT User, Host FROM mysql.user;
SHOW MASTER STATUS;
```
2. Vagrant ssh to SQL Slave (192.168.121.13) and to next:
```
sudo grep 'temporary password' /var/log/mysqld.log
sudo mysql_secure_installation
sudo mysql -u root -p
SELECT * from mysql.user where User="root" \G
sudo nano /etc/my.cnf
    server_id = 2
sudo systemctl restart mysqld.service
sudo mysql -u root -p
CHANGE MASTER TO MASTER_HOST='192.168.121.12', MASTER_USER='repl', MASTER_PASSWORD='tynMOD#123', MASTER_LOG_FILE='binlog.XXXXXX', MASTER_LOG_POS=XXX, GET_MASTER_PUBLIC_KEY = 1;
START SLAVE;
show slave status\G
```
3. Vagrant ssh to SQL Master:
```
create database otus;
connect otus;
create table t ( i int);
```
4. Vagrant ssh to SQL Slave:
```
show databases;
connect otus;
show tables;
```