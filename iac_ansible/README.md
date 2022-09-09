# IaC with Ansible

## What is Ansible?

Ansible is a software tool used for the automation of IaC configurations. It is an agentless software, meaning it doesn't require any of it's agent nodes to have the Ansible software installed on them in order to interact with them. One of the most powerful aspects of Ansible is that it allows the configuration of a network of computers at once. 

## Using Ansible

![iac](https://user-images.githubusercontent.com/99980305/189075626-5404344d-844d-433a-980e-515036be4d77.png)

- Vagrant should be installed on the localhost
- A multi-machine environment will be created with three virtual machines (VM) configured in the `Vagrantfile`: controller, web and db
- After each VM has been configured, navigate to each and run the following command: `sudo apt-get update -y && sudo apt-get upgrade -y`
- For the rest of this process, only the controller VM will be required

### In the controller VM

#### Run these commands to configure the VM:

- `sudo apt-get install software-properties-common`- installs the remaining software dependencies
- `sudo apt-add-repository ppa:ansible/ansible`- adds the Ansible repository to the VM
- `sudo apt-get install ansible -y`- installs Ansible software onto the VM
- `sudo apt install tree`- installs a package that allows a cleaner look into directory contents

NOTE- Any command that utilises the Ansible software to configure the target node from the Ansible controller, is known as an Ansible ad-hoc command.

#### Run these commands to check the connection with the agent nodes:

- `ping 192.168.33.10/11`- receives a response from the web VM and db VM respectively
- `ssh vagrant@192.168.33.10/11`- SSH from the controller to either agent node with `vagrant` being the default password that needs to be inputted when prompted
- To enable an Ansible connection with each node need to navigate to `/etc/ansible` and then `sudo nano hosts` and paste the following information into this file: `[web]
192.168.33.10 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant` and `[db]
192.168.33.11 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant`
- `sudo ansible all -m ping`- checks the connection to the node by outputting `pong`

#### Run these commands to configure the web VM:

- To configure the web VM the following dependencies are required: npm, NodeJS and Nginx
- These configurations are made with YAML files known as Ansible playbooks
- Please see `playbooks` in this directory to see the YAML files
- `ansible-playbook name.yml`- runs the playbook

NOTE- Due to multiple issues with Vagrant, certain steps (`DB_HOST environment variable` and `npm start`) were conducted manually

Breakdown of a simple example playbook:

```
# create a playbook to install nodejs inside web
# initialise YAML file with ---
--- 

# add name of host server/agent node
- hosts: web

# gather live information
  gather_facts: yes

# need admin access
  become: true

# add the instructions
  tasks:
  - name: Install NodeJS
    apt: pkg=nodejs state=present

# nodejs is running
```

#### Vagrant, Ansible and AWS to make a Hybrid Cloud Environment

[Follow these steps](https://medium.datadriveninvestor.com/devops-using-ansible-to-provision-aws-ec2-instances-3d70a1cb155f) to use Ansible to spin up an EC2 instance on AWS

An Ansible Vault needs to be set up in order to create a secure communication channel between the controller VM and AWS. This has the latest versions of the following dependencies: python3, pip3 and awscli. Moreover, the following file path/folder structure has to be created: `/etc/ansible/group_vars/all/pass.yml`.

- Install the Ansible Vault dependencies with the following commands:

1. sudo apt install python3-pip
2. pip3 install awscli
3. pip3 install boto boto3

- To create the file path use `mkdir` command
- Navigate to `/etc/ansible/group_vars/all` 
- `sudo ansible-vault create pass.yml`- creates the Ansible Vault
- Create a password for the Vault and then within the fault paste the following lines of information:

1. aws_access_key: xxxx
2. aws_secret_key: xxxx

- In the `.ssh` folder, ensure that there is a private key and public key generated using `ssh-keygen -t rsa -b 4096` as well as the `.pem` file needed to securely communicate with AWS:

1. All these keys should have the same name to avoid confusion
2. The .pem file key-pair can be created in AWS following [these steps](https://docs.aws.amazon.com/servicecatalog/latest/adminguide/getstarted-keypair.html)

- Use the following playbook to create the EC2 instances

```
---

- hosts: localhost
  connection: local
  gather_facts: False



 vars:
    ansible_python_interpreter: /usr/bin/python3
    key_name: eng122
    region: eu-west-1
    image: ami-0d28346e264907026
    id: "web-app"
    sec_group: "{{ id }}-sec"



 tasks:



   - name: Facts
      block:



     - name: Get instances facts
        ec2_instance_facts:
          aws_access_key: "{{aws_access_key}}"
          aws_secret_key: "{{aws_secret_key}}"
          region: "{{ region }}"
        register: result



     - name: Instances ID
        debug:
          msg: "ID: {{ item.instance_id }} - State: {{ item.state.name }} - Public DNS: {{ item.public_dns_name }}"
        loop: "{{ result.instances }}"



     tags: always




    - name: Provisioning EC2 instances
      block:



     - name: Upload public key to AWS
        ec2_key:
          name: "{{ key_name }}"
          key_material: "{{ lookup('file', '/home/vagrant/.ssh/{{ key_name }}.pub') }}"
          region: "{{ region }}"
          aws_access_key: "{{aws_access_key}}"
          aws_secret_key: "{{aws_secret_key}}"



     - name: Create security group
        ec2_group:
          name: "{{ sec_group }}"
          description: "Sec group for app {{ id }}"
          region: "{{ region }}"
          aws_access_key: "{{aws_access_key}}"
          aws_secret_key: "{{aws_secret_key}}"
          rules:
            - proto: tcp
              ports:
                - 22
              cidr_ip: 0.0.0.0/0
              rule_desc: allow all on ssh port
        register: result_sec_group



     - name: Provision instance(s)
        ec2:
          aws_access_key: "{{aws_access_key}}"
          aws_secret_key: "{{aws_secret_key}}"
          key_name: "{{ key_name }}"
          id: "{{ id }}"
          group_id: "{{ result_sec_group.group_id }}"
          image: "{{ image }}"
          instance_type: t2.micro
          region: "{{ region }}"
          wait: true
          count: 1
         # exact_count: 2
          count_tag:
            Name: eng122-fahim-ansible-app
          instance_tags:
            Name: eng122-fahim-ansible-app



     tags: ['never', 'create_ec2']
```

- `sudo ansible-playbook create-ec2-playbook.yml --ask-vault-pass --tags ec2_create`- specific ansible command to run a playbook that creates an EC2 instance 

#### In EC2 instance

The steps detailed earlier in this documentation can be followed to use the controller EC2 instance to make the web and db EC2 instances. 

Key points:

- Ensure the correct keys (private, public and pem) are in the `.ssh` folder 
- Ensure the pem key has the correct permissions with `sudo chmod 400 file.pem`
- Ensure you can ping the web and db instances with `sudo ansible all -m ping --ask-vault-pass`- it now has to seek authentication with Ansible Vault in order to run commands and communicate with the other instances
- Ensure in `\etc\ansible\hosts` paste the following lines to establish a connection between the controller and the agent nodes:

```
[app]
ec2-instance ansible_host=private-ip ansible_user=ubuntu ansible_ssh_private_key_file=/home/ubuntu/.ssh/file.pem

[db]
ec2-instance ansible_host=private-ip ansible_user=ubuntu ansible_ssh_private_key_file=/home/ubuntu/.ssh/file.pem
```
