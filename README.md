<h1 align="center" id="title">Ansible-configuration-dockerised-container</h1>
<p id="description"> Docker is an open-source platform for developing, shipping, and running applications in containers. Containers are lightweight, portable, and self-sufficient, making it easy to deploy applications consistently across different environments. Nginx is a popular web server and reverse proxy server that is often used in containers for serving web applications. 
This is a Dockerized container application using the Nginx image on Ubuntu. An EC2 instance will be provisioned, featuring an Ubuntu 22.04 image. Then Nginx Docker container will be deployed on this instance using an Ansible playbook.
Required Docker packages are installed to enable the execution of a container on the instance as shown below:

<img width="957" alt="image" src="https://github.com/Iyewumi-Adesupo/ansible-configuration-docker-container/assets/135404420/e7610b5d-9da9-44f8-ab00-b80478636207">

<img width="959" alt="image" src="https://github.com/Iyewumi-Adesupo/ansible-configuration-docker-container/assets/135404420/7ddbb7dc-3f12-4a4f-a6b1-8601f852219f">

Also, the playbook will subsequently execute a Docker login command. Upon running the playbook, it will interactively request the user to input the username and password to be utilized for the Docker login. This will be shown below with the screenshot as username and login is prompted for login on the terminal:

<img width="957" alt="image" src="https://github.com/Iyewumi-Adesupo/ansible-configuration-docker-container/assets/135404420/1e112f93-ce1b-42f5-b2a9-115c992c57f8">

<img width="950" alt="image" src="https://github.com/Iyewumi-Adesupo/ansible-configuration-docker-container/assets/135404420/114e43b3-f54e-4252-b864-ec276359fb38">

<img width="820" alt="image" src="https://github.com/Iyewumi-Adesupo/ansible-configuration-docker-container/assets/135404420/6730babd-cebf-411b-9fe0-a180a759135a">

<img width="805" alt="image" src="https://github.com/Iyewumi-Adesupo/ansible-configuration-docker-container/assets/135404420/2e04b62d-d668-41e2-adab-da527c24b658">

<img width="817" alt="image" src="https://github.com/Iyewumi-Adesupo/ansible-configuration-docker-container/assets/135404420/c1f8bc89-6043-458f-909e-bb84a0f8d898">

<img width="809" alt="image" src="https://github.com/Iyewumi-Adesupo/ansible-configuration-docker-container/assets/135404420/1fa649b5-e90c-4f05-9d89-9ba34f1784ab">

Furthermore, the running playbook will create a container with an open port 443, and the container will be named nginx-example-docker. 

<img width="800" alt="image" src="https://github.com/Iyewumi-Adesupo/ansible-configuration-docker-container/assets/135404420/3519e3b5-4125-4e55-8dc5-9dc29cc482d1">

<img width="806" alt="image" src="https://github.com/Iyewumi-Adesupo/ansible-configuration-docker-container/assets/135404420/e154e514-9bf2-4597-9f16-9e137477f7dc">

<img width="937" alt="image" src="https://github.com/Iyewumi-Adesupo/ansible-configuration-docker-container/assets/135404420/22e8f82e-2e47-4854-b78e-873a470b1246">

The following instructions, along with accompanying scripts, illustrate the process of executing an Ansible playbook designed for deploying the mentioned Dockerized container.

Ensure Ansible is installed on your machine. You can install Ansible on various operating systems. But Ubuntu will be used for this container

Step 1:
Ansible user data script is created using Terraform. Then the local block file is created which is on line 1 and 2.  

<img width="553" alt="image" src="https://github.com/Iyewumi-Adesupo/ansible-configuration-docker-container/assets/135404420/8cd774aa-341f-4576-ab7c-06759994d965">

Step 2:
#!/bin/bash: This line is known as a shebang, and it specifies the path to the Bash interpreter. It tells the system to execute the script using Bash.

<img width="316" alt="image" src="https://github.com/Iyewumi-Adesupo/ansible-configuration-docker-container/assets/135404420/d1c5835a-b473-43ab-ba0b-48f5313063a9">

Step 3:
sudo apt update: This command updates the package lists for available software packages. It ensures that the system has the latest information about available packages before installation.

<img width="245" alt="image" src="https://github.com/Iyewumi-Adesupo/ansible-configuration-docker-container/assets/135404420/1f4801bc-52ef-4c7b-b9ce-9bedf7e72935">

Step 4:
Sudo hostnamectl set-hostname Ansible: This line sets the hostname of the machine to "Ansible" using the hostnamectl command. The hostname is a label assigned to the machine for identification on a network.

<img width="280" alt="image" src="https://github.com/Iyewumi-Adesupo/ansible-configuration-docker-container/assets/135404420/95085133-735d-4839-aaa8-847314141216">

Step 5:
sudo apt update: After adding the Ansible repository, it's necessary to update the package lists again to include information from the newly added repository.

<img width="320" alt="image" src="https://github.com/Iyewumi-Adesupo/ansible-configuration-docker-container/assets/135404420/4c9c0b85-5832-450e-9fce-c71a20818e10">

Step 6:
Sudo apt install ansible -y: This command installs Ansible on the system. The -y flag automatically answers "yes" to prompts during the installation, avoiding the need for user interaction.

<img width="254" alt="image" src="https://github.com/Iyewumi-Adesupo/ansible-configuration-docker-container/assets/135404420/012bbf04-7cc9-4625-a802-8586835260be">

Step 7:
sudo bash -c 'echo "StrictHostKeyChecking No" >> /etc/ssh/ssh_config': This line adds a configuration to the SSH client configuration file (/etc/ssh/ssh_config). The added configuration, "StrictHostKeyChecking No", essentially disables strict host key checking, which means the SSH client will automatically accept new host keys without prompting for confirmation. The sudo command is used to execute this with elevated privileges.

<img width="503" alt="image" src="https://github.com/Iyewumi-Adesupo/ansible-configuration-docker-container/assets/135404420/f2048ec2-9934-4360-9d0f-f676dbdce055">

Step 8: 
echo "${tls_private_key.key_pair.private_key_pem}" >> /home/ubuntu/public_key.pem: This line appends the contents of the private key (presumably stored in the tls_private_key.key_pair.private_key_pem variable) to a file named public_key.pem in the /home/ubuntu/ directory. The echo command is used to output the content, and >> appends it to the specified file.

<img width="588" alt="image" src="https://github.com/Iyewumi-Adesupo/ansible-configuration-docker-container/assets/135404420/61bc9b01-348b-40ad-a86b-274df927bc79">

Step 9: 
echo "${file("./docker-image.yml")}" >> /home/ubuntu/docker-image.yml: This line appends the content of the file located at ./docker-image.yml to a file named docker-image.yml in the /home/ubuntu/ directory. The echo command is used to output the content of the file, and >> appends it to the specified file.

<img width="502" alt="image" src="https://github.com/Iyewumi-Adesupo/ansible-configuration-docker-container/assets/135404420/c606b687-ad28-4987-8eae-bd41c7836e59">

Step 10:
sudo chown ubuntu:ubuntu /home/ubuntu/public_key.pem: This line changes the ownership of the public_key.pem file to the user ubuntu and the group ubuntu. The sudo command is used for elevated privileges.

<img width="396" alt="image" src="https://github.com/Iyewumi-Adesupo/ansible-configuration-docker-container/assets/135404420/1f16a6e2-9285-4c0e-b2fe-98e9657736cd">

Step 11:
chmod 400 authentise /home/ubuntu/public_key.pem: This line sets the file permissions for the public_key.pem file. It restricts access to the file, allowing only the owner to read the contents.

<img width="374" alt="image" src="https://github.com/Iyewumi-Adesupo/ansible-configuration-docker-container/assets/135404420/1882a0a4-ebeb-4a2c-8bce-e729c2a36bf8">

Step 12:
touch /etc/ansible/hosts: This line creates an empty file named hosts in the /etc/ansible/ directory. In Ansible, the hosts file is used to define the inventory of remote hosts that Ansible will manage.

<img width="207" alt="image" src="https://github.com/Iyewumi-Adesupo/ansible-configuration-docker-container/assets/135404420/71fe0af6-b0f1-43ad-9dbd-398f7c5da8bf">

Step 13:
sudo chown -R ubuntu:ubuntu /etc/ansible/hosts: This line changes the ownership of the /etc/ansible/hosts file and its contents recursively. It sets the owner to the user ubuntu and the group to ubuntu. The sudo command is used for elevated privileges.

<img width="345" alt="image" src="https://github.com/Iyewumi-Adesupo/ansible-configuration-docker-container/assets/135404420/205c7885-042e-49a8-8715-5f121597678c">

Step 14:
cat <<EOT> /etc/ansible/hosts: This line uses the cat command in combination with a "here document" (<<EOT) to create or overwrite the content of the /etc/ansible/hosts file. A "here document" is a way to include multiple lines of text in a script. The input is provided until a delimiter (EOT in this case) is encountered.

<img width="245" alt="image" src="https://github.com/Iyewumi-Adesupo/ansible-configuration-docker-container/assets/135404420/c43c2abc-8bb4-4827-940f-99dfd4517d07">

Step 15:
[docker_host]: This line adds a group named docker_host to the Ansible inventory file (/etc/ansible/hosts). In Ansible, groups help organize and manage hosts.

${aws_instance.docker-nginx-container.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=/home/ubuntu/public_key.pem: This line adds a host entry to the docker_host group. It specifies the public IP address of an AWS EC2 instance (${aws_instance.docker-nginx-container.public_ip}) as the target host. It also sets the Ansible user to ubuntu and specifies the path to the private key file used for SSH authentication (ansible_ssh_private_key_file=/home/ubuntu/public_key.pem).

In summary, this script is preparing the Ansible inventory file by setting its ownership, creating a group (docker_host), and adding a host entry with specific configuration details for connecting to an AWS EC2 instance. The sudo command is used to execute privileged operations, and the cat command with a "here document" is employed to manage the content of the Ansible inventory file.

<img width="785" alt="image" src="https://github.com/Iyewumi-Adesupo/ansible-configuration-docker-container/assets/135404420/c8519735-4762-4c76-a19e-099187d7fc6f">

<img width="803" alt="image" src="https://github.com/Iyewumi-Adesupo/ansible-configuration-docker-container/assets/135404420/d3090d9c-09da-4b69-9be5-be31d90a4b34">

Note that the Ansible data script in step 9 is responsible for transmitting the playbook. The YAML file for the playbook is generated utilizing variables and then this playbook is executed with certain arguments. The arguments employed in executing the playbook are outlined below.

<img width="620" alt="image" src="https://github.com/Iyewumi-Adesupo/ansible-configuration-docker-container/assets/135404420/3c93aed9-1c33-48da-8279-f4f2128b14f5">

This Ansible playbook is designed to install Docker on servers belonging to the docker_host group. It uses the become: true option to execute tasks with elevated privileges. Additionally, it prompts the user for the values of username and password during playbook execution using the vars_prompt section. These variables can then be used within the playbook tasks for customization based on user input.

<img width="614" alt="image" src="https://github.com/Iyewumi-Adesupo/ansible-configuration-docker-container/assets/135404420/9a6fdff1-eca4-43f4-bb91-b78c125f06f0">

These tasks are part of an Ansible playbook designed to update the package cache and install a set of required system packages on a target server. The tasks use the apt module to interact with the package management system on Ubuntu systems.

<img width="659" alt="image" src="https://github.com/Iyewumi-Adesupo/ansible-configuration-docker-container/assets/135404420/62e8dcf2-9a17-4a1b-9c05-74aa289980e0">

This task is named "Add Docker," and its purpose is to add the GPG key needed for verifying the integrity of Docker packages.
The apt_key module is used to manage APT GPG keys.
The url parameter specifies the URL from which to retrieve the GPG key.
state: present indicates that the GPG key should be present on the system after the task is executed.

<img width="511" alt="image" src="https://github.com/Iyewumi-Adesupo/ansible-configuration-docker-container/assets/135404420/cbd8fd74-759f-4c8c-9626-ca4e727b9ed2">

This task is named "Add Docker Repository," and its goal is to add the Docker repository to the list of APT sources.
The apt_repository module is used to manage APT repositories.
The repo parameter specifies the repository to add, including the URL and repository details.
state: present indicates that the repository should be present on the system after the task is executed.

<img width="448" alt="image" src="https://github.com/Iyewumi-Adesupo/ansible-configuration-docker-container/assets/135404420/3adaeeb9-089b-4aa7-bad6-9591e0d0413d">

This task is named "Update apt and install docker-ce," and its purpose is to update the package cache and install the Docker Community Edition (docker-ce).
The apt module is used for package management.
The name parameter specifies the package to be installed, which is docker-ce in this case.
state: latest ensures that the Docker package is updated to the latest available version.
update_cache: true is included to refresh the package cache before installing Docker.

<img width="452" alt="image" src="https://github.com/Iyewumi-Adesupo/ansible-configuration-docker-container/assets/135404420/0f6514ab-ffad-44e3-b8a6-02ca24958ea8">

This task is named "Start docker," and its purpose is to ensure that the Docker service is running on the target server.
The service module is used to manage services on the system.
The name parameter specifies the service to be managed, which is docker in this case.
state: started indicates that the Docker service should be started.

<img width="264" alt="image" src="https://github.com/Iyewumi-Adesupo/ansible-configuration-docker-container/assets/135404420/be9effba-61b4-49c0-b052-19905ee48e4b">

This task is named "docker pull," and its goal is to pull the official Nginx Docker image from the Docker Hub.
The command module is used to run shell commands.
The command being executed is docker pull nginx, which fetches the Nginx image

<img width="301" alt="image" src="https://github.com/Iyewumi-Adesupo/ansible-configuration-docker-container/assets/135404420/c73b8133-3024-4d97-bbec-9e5a623fcd2f">

This task is named "Add tag to image," and its purpose is to tag the pulled Nginx image with a new name.
The command module is used to run the docker tag command.
The command being executed is docker tag nginx sueade/nginx, which assigns the new name sueade/nginx to the Nginx image.

<img width="448" alt="image" src="https://github.com/Iyewumi-Adesupo/ansible-configuration-docker-container/assets/135404420/a2d75223-242d-43f4-9925-850342e821a7">

This task is named "Login to Docker Hub," and its goal is to authenticate with Docker Hub using a specified username and password.
The command module is used to run the docker login command.
{{username}} and {{password}} are placeholders for variables, and their actual values would be provided during playbook execution.

<img width="434" alt="image" src="https://github.com/Iyewumi-Adesupo/ansible-configuration-docker-container/assets/135404420/7c5daa96-8056-456a-b22d-a619d6c7c219">

This task is named "Pushing nginx container to private docker hub," and its purpose is to push the tagged Nginx image to a private Docker Hub repository.
The command module is used to run the docker push command.
The command being executed is docker push sueade/nginx, which uploads the tagged Nginx image to the Docker Hub repository.

<img width="614" alt="image" src="https://github.com/Iyewumi-Adesupo/ansible-configuration-docker-container/assets/135404420/8bf316e0-f45a-4bfc-a142-92da78440030">

This task is named "Running nginx container," and its goal is to start a Docker container using the Nginx image.
The command module is used to run the docker run command.
The command being executed is docker run -it -d --name nginx-example-docker -p 443:80 sueade/nginx, which creates and runs a detached Docker container named nginx-example-docker based on the sueade/nginx image, mapping port 80 on the container to port 443 on the host.
These tasks are part of an Ansible playbook that automates the process of starting the Docker service, pulling, tagging, and pushing a Docker image to a private Docker Hub repository, and finally running a Docker container based on the Nginx image.
