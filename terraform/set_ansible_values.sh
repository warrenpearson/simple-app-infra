#!/bin/bash

echo "---" > ../ansible/roles/simple_app/defaults/main.yml
echo "http_port: 80" >> ../ansible/roles/simple_app/defaults/main.yml

terraform output | grep rds | sed -e 's/ =/:/' | sed -e 's/"//g' |sed -e 's/:3306//' |sort >> ../ansible/roles/simple_app/defaults/main.yml

rm -f ../ansible/hosts

terraform output |grep ec2 |cut -d\" -f2 > ../ansible/hosts
