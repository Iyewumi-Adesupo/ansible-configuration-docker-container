locals {
  ansible-user-data = <<-EOF
#!bin/bash
sudo apt update
sudo hostnamectl set-hostname Ansible
sudo apt-add-repository ppa:ansible/ansible
sudo apt update
sudo apt install ansible -y
sudo bash -c 'echo "StrictHostKeyChecking No" >> /etc/ssh/ssh_config'
echo "${tls_private_key.key_pair.private_key_pem}" >> /home/ubuntu/public_key.pem
echo "${file("./docker-image.yml")}" >> /home/ubuntu/docker-image.yml
sudo chown ubuntu:ubuntu /home/ubuntu/public_key.pem
chmod 400 authentise  /home/ubuntu/public_key.pem
touch /etc/ansible/hosts
sudo chown -R ubuntu:ubuntu /etc/ansible/hosts
cat <<EOT> /etc/ansible/hosts
[docker_host]
${aws_instance.docker-nginx-container.public_ip} ansible_user=ubuntu ansible_ssh_private_key_file=/home/ubuntu/public_key.pem
EOT
EOF
}