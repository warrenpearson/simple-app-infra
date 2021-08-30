# simple-app-infra

This project was originally intended to set up EC2, RDS and security groups for a simple app via `terraform`. Over time, it grew to include the accompanying `ansible` for deploying the app to that infra.

## Create infrastructure

Create infra via terraform:

```bash
cd terraform

terraform init

terraform plan

terraform apply
```

Inspect output params:

```bash
terraform output
```

Extract ssh private key:

```bash
./make_pem.sh
```

## Validate infrastructure and database connectivity (optional)

Log onto the box and check connectivity:

```bash
# output public ip address for EC2 box, and hostname for RDS instance
terraform output

ssh -i tf.pem ubuntu@<tf_ec2_instance_ip>

telnet <tf_rds_endpoint> 3306

# example output
Trying 172.31.0.68...
Connected to terraform-20210830135841864100000003.cpjnv5hlz7rp.eu-west-2.rds.amazonaws.com.
Escape character is '^]'.

^]

exit
```

## Create ansible config

The script below writes the EC2 box's public ip to the ansible `hosts` file, and updates the `roles/simple_app/defaults/main.yml` with the database parameters. 

N.B. the script has a dependency on `gron` <https://github.com/TomNomNom/gron>.

```bash
# N.B. we are still in the terraform directory

./set_ansible_values.sh

cat ../ansible/roles/simple_app/defaults/main.yml
---
http_port: 8080
tf_rds_username: ...
tf_rds_password: ...
tf_rds_endpoint: ...

```

## Run ansible

Run the script with the generated ssh key as the only param:

```bash
cd ../ansible

./run_ansible.sh ../terraform/tf.pem
```

## Test app

If all is well, running the following command should show the expected output

```bash
curl <tf_ec2_instance_ip>:8080/json_example

[{"id":1,"value":"This is test data"},{"id":2,"value":"This is also test data"}]
```

## Remove infra

To completely remove everything:

```bash
terraform destroy

# simplest way to remove .tfstate files, but
# requires re-running terraform init on a following run
git clean -xdf
```
