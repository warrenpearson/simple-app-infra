#!/bin/bash

KEY_FILE=$1

if [ -z ${KEY_FILE} ]; then
    echo "Please specify an ssh private key"
    exit 1
fi


ansible-playbook -u ubuntu -b -i hosts simple_app.yml --private-key ${KEY_FILE}
