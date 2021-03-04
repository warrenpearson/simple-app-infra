#!/bin/bash

echo "---" > ../ansible/roles/meetings_api/defaults/main.yml
echo "http_port: 80" >> ../ansible/roles/meetings_api/defaults/main.yml

terraform output | grep rds | sed -e 's/ =/:/' | sed -e 's/"//g' |sed -e 's/:3306//' |sort >> ../ansible/roles/meetings_api/defaults/main.yml

rm -f ../ansible/hosts

terraform output |grep ec2 |cut -d\" -f2 > ../ansible/hosts
