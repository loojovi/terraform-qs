# Terraform 

This repo stores the terraform code to create infrastructure on AWS, in order to host a Jupyter notebook on an EC2 instance. 

## Instructions

### Set up of IDE and terraform

If you are using your own terminal, ensure that [terraform](https://www.terraform.io/downloads.html) is installed. Alternatively, you can use AWS Cloud9 terminal. I would suggest using this as terraform should already be pre-installed. Make sure to use `t2.micro` instance to stay within the free tier. 

### Spin up infrascture 

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

Finally, to destroy resources, run 

```bash
$ terraform destroy
```
You can confirm that the resources are destroyed on the AWS console. If you are using Cloud9, please also delete the environment. 

## Credits

This tutorial is adapted from [wblakecannon](https://github.com/wblakecannon/terraform-jupyter).