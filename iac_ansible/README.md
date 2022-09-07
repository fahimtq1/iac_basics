# IaC with Ansible

## What is Ansible?

Ansible is a software tool used for the automation of IaC configurations. It is an agentless software, meaning it doesn't require any of it's agent nodes to have the Ansible software installed on them in order to interact with them. One of the most powerful aspects of Ansible is that it allows the configuration of a network of computers at once. 

## Using Ansible

![iac](https://user-images.githubusercontent.com/99980305/188607910-a4d5866d-8856-4e84-b146-a5859a12b960.png)


- Vagrant should be installed on the localhost
- A multi-machine environment will be created with three virtual machines (VM) configured in the `Vagrantfile`: controller, web and db
- After each VM has been configured, navigate to each and run the following command: `sudo apt-get update -y && sudo apt-get upgrade -y`
- For the rest of this process, only the controller VM will be required

### In the controller VM

Run these commands to configure the VM:

- `sudo apt-get install software-properties-common`- installs the remaining software dependencies
- `sudo apt-add-repository ppa:ansible/ansible`- adds the Ansible repository to the VM
- `sudo apt-get install ansible -y`- installs Ansible software onto the VM
- `sudo apt install tree`- installs a package that allows a cleaner look into directory contents

NOTE- Any command that utilises the Ansible software to configure the target node from the Ansible controller, is known as an Ansible ad-hoc command.

Run these commands to check the connection with the agent nodes:

- `ping 192.168.33.10/11`- receives a response from the web VM and db VM respectively
- `ssh vagrant@192.168.33.10/11`- SSH from the controller to either agent node with `vagrant` being the default password that needs to be inputted when prompted
- To enable an Ansible connection with each node need to navigate to `/etc/ansible` and then `sudo nano hosts` and paste the following information into this file: `[web]
192.168.33.10 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant` and `[db]
192.168.33.11 ansible_connection=ssh ansible_ssh_user=vagrant ansible_ssh_pass=vagrant`
- `sudo ansible all -m ping`- checks the connection to the node by outputting `pong`

Run these commands to configure the web VM:

- To configure the web VM the following dependencies are required: npm, NodeJS and Nginx
- These configurations are made with YAML files known as Ansible playbooks
- Please see `playbooks` in this directory to see the YAML files
- `ansible-playbook name.yml`- runs the playbook

Breakdown of an example playbook:

```
# create a playbook to install nodejs inside web

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