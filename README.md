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

Extract ssh private key:

```bash
./make_pem.sh
```

## Validate infrastructure and connectivity

Log onto the box and check connectivity:

```bash
# output public ip address for EC2 box, and hostname for RDS instance
terraform output

ssh -i tf.pem ubuntu@<ec2_public_ip>

telnet <rds_hostname> 3306

exit
```

## Run ansible

First, populate the ansible config with outputs:

This script writes the EC2 box's public ip to the ansible `hosts` file, and updates the `roles/simple_app/defaults/main.yml` with the database parameters. N.B. the script has a dependency on `gron` <https://github.com/TomNomNom/gron>.

```bash
# N.B. we are still in the terraform directory

./set_ansible_values.sh

cd ../ansible

./run_ansible.sh ../terraform/tf.pem
```


## Remove infra:

```bash
terraform destroy

# simplest way to remove .tfstate files, but
# requires re-running terraform init on a following run
git clean -xdf
```
