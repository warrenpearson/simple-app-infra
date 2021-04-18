#!/bin/bash


grep private_key_pem terraform.tfstate |cut -d\" -f4 | sed 's/\\n/\
/g' > tf.pem

chmod 400 tf.pem
