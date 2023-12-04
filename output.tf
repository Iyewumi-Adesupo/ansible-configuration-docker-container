output "docker-nginx-container" {
  value = aws_instance.docker-nginx-container.public_ip
}
output "ansible-server" {
  value = aws_instance.ansible-server.public_ip
}