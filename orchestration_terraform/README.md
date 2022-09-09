# Orchestration with Terraform

## What is Terraform?

Terraform is an IaC tool that allows a user to define infrastructure on both the cloud and localhost with configuration files. It is a lightweight application used to manage low-level infrastructure components.

## Benefits of Terraform 

- Supports a range of cloud service providers
- Open-source software
- Agentless

## What is Orchestration?

Orchestration refers to the process of automating an entire workflow that involves many steps and many systems. It is different to automation, as automation refers to automating a single task. The main benefit of orchestration is that it helps easily manage complex tasks and workflows.

## Using Terraform

![terraform](https://user-images.githubusercontent.com/99980305/189128354-1a922e93-c1a6-4c50-bfed-6b154eb6fabe.png)

### Saving AWS Access and Secret Keys

- Edit the system environment variables -> Environment variables - User variables 
- Add AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY (specific syntax) as two new environment variables

### Setting up Terraform on Windows machine

- Run Windows Powershell as Administrator and run this command- `Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))`
- The command can be found on [this link](https://chocolatey.org/install) and Chocolatey is installed
- `choco install terraform`- downloads and installs the latest version of Terraform
- `terraform`- shows all terraform commands

### Orchestration with Terraform

#### EC2 instance

- Create a file `main.tf`- the .tf extension symbolises a Terraform configuration file
- Paste the following contents into the file

```hcl 
# who is the cloud service provider- aws
provider "aws" {

# within which cloud service provider region- eu-west-1
    region = "eu-west-1"

}

# create a block of code to launch ec2-server

# which resource do we like to create
resource "aws_instance" "app_instance" {

# which ami
    ami = "ami-0b47105e3d7fc023e"

# which instance type
    instance_type = "t2.micro"

# do we need it to have public ip
    associate_public_ip_address = true

# how to name your instance
    tags = {
      "Name" = "eng122-fahim-tf-app"
    }

# how to add ssh connection to instance
    key_name = "eng122-fahim-tf-key"

}
```

- The file performs the following:

1. The cloud service provider being utilised and the region in that cloud service provider
2. The configuration of the EC2 instance

- In the file location of `main.tf`, run these commands:

1. `terraform init`- initialises Terraform software in that directory
2. `terraform plan`- checks the syntax of the files in log outputs
3. `terraform apply`- runs the file and spins up on instance on AWS
4. `terraform destroy`- destroys the instance that has been created with the file

#### EC2 instance in VPC

The file `main.tf` will be edited to perform orchestration of an entire worklow: VPC, Gateway, Route Table, Subnets and EC2 instance. It is important to be careful of the order of the resource blocks:

1. Create the VPC
2. Create the subnets within the VPC
3. Create an internet gateway within the VPC
4. Create a route table, that is connected to the internet gateway, within the VPC
5. Attach the public subnet to the route table
6. Create the instance

#### Abstraction with Terraform

Sensitive information can be stored and hidden (abstracted) in a `variables.tf` file. This file contains all the required variables and is to be kept in the same file location as the `main.tf` file. Within the `main.tf` file, the variables can be called upon and Terraform's software will recognise it. Details can be viewed in `main.tf` file. 
