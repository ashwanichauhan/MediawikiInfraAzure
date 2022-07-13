
# Deploying Mediawiki App

Creating Azure Infrastructure Using Terraform. Setting the Servers
to deploy mediawiki app using ansible.










## The infrasructure includes


1) Resource group
2) Virtual network
3) Subnets
4) A public vm to enter inside the virtual network with openvpn installed
5) Virtual machine scale set
6) Ansible playbook
7) openvpn bash script 


## Steps to run the script
1) Clone the repo
2) Put the credential in Var_values.tfvars file
3) Open Git bash and run sh Terraform.sh
## Ansible Playbook Content
playbook- https://github.com/ashwanichauhan/MediawikiInfraAzure/blob/main/Scripts/playbook.yaml
1) Install apache, mysql and PHP
2) Start mariadb
3) Create Database
4) Create wiki user
5) Download the mediawiki tar
6) Unzip the tar
6) Create hardlink for mediawiki
7) Update apache httpd conf file
8) Open the firewall ports
9) setting the correct selinux context

