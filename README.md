# Terraform 

This repo stores the terraform code to create infrastructure on AWS, in order to host a Jupyter notebook on an EC2 instance. 

## What this terraform script does

This Terraform will do the following automatically:

1. Creates a key-pair and puts it in your working directory.
2. Creates a AWS Security Group that is pre-configured for Jupyter Notebooks.
3. Creates a AWS Instance using the latest Amazon Linux 2 AMI.
4. Downloads Anaconda
5. Installs Anaconda
6. Sets the environment variable for Anaconda, python, jupyter, etc
7. Configures the Jupyter Notebook config file for use with AWS.

## Instructions

### Set up of IDE and terraform

If you are using your own terminal, ensure that [terraform](https://www.terraform.io/downloads.html) is installed. Alternatively, you can use AWS Cloud9 terminal. I would suggest using this as terraform should already be pre-installed. Make sure to use `t2.micro` instance to stay within the free tier. 

### Spin up infrastructure 

To avoid conflict in creating resources, change the `user_name` variable in `variables.tf` to your name. This variable is used primarily in tagging resources. 

To initialize the terraform configuration, run 

```bash
$ terraform init
```

Next, we want to see the the resources that will be created, change or destroyed. Run the following command

```bash
$ terraform plan
```

To execute the plan, run

```bash
$ terraform apply
```

After Terraform has completed creating resources it will output the connection string, which you'll use to connect via SSH. Wait for around 10-15 minutes for the `script.sh` to finish running. You can SSH into the instance, and run the command `cat terraform.log` to view the progress. 

After all the installation is complete, exit and enter the instance again. Run the command `jupyter notebook` to start up the notebook.

### Tear down resources

After Terraform has completed creating resources it will output the connection string, which you'll use to connect with SSH. Wait for around 10-15 minutes for the script `script.sh` to finish

```bash
$ terraform destroy
```
You can confirm that the resources are destroyed on the AWS console. If you are using Cloud9, please also delete the environment. 

## Credits

This tutorial is adapted from [wblakecannon](https://github.com/wblakecannon/terraform-jupyter).