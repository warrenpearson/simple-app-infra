#!/bin/bash

KEY_FILE=$1
ansible-playbook -u ubuntu -b -i hosts simple_app.yml --private-key ${KEY_FILE}
