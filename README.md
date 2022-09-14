# Infrastructure as Code

## What is IaC?

IaC stands for Infrastructure as Code and it refers to the management of software infrastructure with code rather than traditional manual processes. IaC uses files to codify and automate the configuration and provisioning of a machine. 

IaC is a key component of the DevOps approach, because it helps streamline the communication channels between the development and operations teams. The production environments, for both teams, are kept consistent; the automation process only works when the production environments of both teams are configured in the same manner. Moreover, IaC removes the need to individually maintain deployment environments, as configurations can be reproduced easily.

## Iac Tools

See [this link](https://bluelight.co/blog/best-infrastructure-as-code-tools) for more information

- Terraform
- Ansible
- Chef
- Puppet
- Vagrant

## Benefits of IaC

- Cost reduction
- Increase in the efficiency of deployment
- Scalability

## Details of the project

The two IaC tools used in this project are Ansible and Terraform. Ansible will be used to configure the Vagrant virtual machines ([found in this project](https://github.com/fahimtq1/virtualisation_basics/blob/main/PROJECT.md)) and then used to configure EC2 instances on AWS. Please see the `iac_ansible` directory for more details on how Ansible was used in this project.

## Comparing Ansible and Terraform

### Similarities

- Agentless
- Uses SSH keys to perform tasks

### Differences

- Terraform is more comprehensive in its orchestration process
- Ansible is better at handling and configuring a large number of machines
