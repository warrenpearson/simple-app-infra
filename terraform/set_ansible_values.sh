#!/bin/bash

# defaults
echo "---" > ../ansible/roles/simple_app/defaults/main.yml
echo "http_port: 8080" >> ../ansible/roles/simple_app/defaults/main.yml

db_host=`terraform output| grep tf_rds_endpoint|cut -d\" -f2|sed -e 's/:3306//'`
db_user=`terraform show --json |gron |grep tf_rds_username.value |cut -d\" -f2`
db_pass=`terraform show --json |gron |grep tf_rds_password.value |cut -d\" -f2`

echo "tf_rds_username: ${db_user}" >> ../ansible/roles/simple_app/defaults/main.yml
echo "tf_rds_password: ${db_pass}" >> ../ansible/roles/simple_app/defaults/main.yml
echo "tf_rds_endpoint: ${db_host}" >> ../ansible/roles/simple_app/defaults/main.yml

# hosts file
rm -f ../ansible/hosts

terraform output |grep tf_ec2_instance_ip |cut -d\" -f2 > ../ansible/hosts
