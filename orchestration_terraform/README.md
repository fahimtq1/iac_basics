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

### Setting up Terraform on Windows machine

- Run Windows Powershell as Administrator and run this command- `Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))`
- The command can be found on [this link](https://chocolatey.org/install) and Chocolatey is installed
- `choco install terraform`- downloads and installs the latest version of Terraform

### Orchestration with Terraform

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