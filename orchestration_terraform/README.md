# Orchestration with Terraform

## What is Terraform?

Terraform is another IaC tool that allows a user to define infrastructure on both the cloud and localhost with configuration files. It is a lightweight application used to manage low-level infrastructure components.

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