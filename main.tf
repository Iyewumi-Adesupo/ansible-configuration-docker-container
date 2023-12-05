# create default vpc
resource "aws_default_vpc" "default_vpc" {

  tags = {
    Name = "default vpc"
  }
}


# use data source to get all avalablility zones in region
data "aws_availability_zones" "available_zones" {}


# create default subnet 
resource "aws_default_subnet" "default_az1" {
  availability_zone = data.aws_availability_zones.available_zones.names[0]

  tags = {
    Name = "default subnet"
  }
}

# create security group for the docker-nginx-sg
resource "aws_security_group" "docker-nginx-sg" {
  name        = "docker-nginx-container"
  description = "allow access on ports 22 and 443"
  vpc_id      = aws_default_vpc.default_vpc.id

  # allow access on port 22 and 443
  ingress {
    description = "ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "access to nginx container"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "docker-nginx-sg"
  }
}

# create security group for the ansible-sg
resource "aws_security_group" "ansible-sg" {
  name        = "ec2 security group"
  description = "allow access on ports 22"
  vpc_id      = aws_default_vpc.default_vpc.id

  # allow access on port 22
  ingress {
    description = "ssh access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ansible-sg"
  }
}

#creating a key pair in terraform

resource "tls_private_key" "key_pair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "pub_key" {
  key_name   = "public_key"
  public_key = tls_private_key.key_pair.public_key_openssh
}

resource "local_file" "ssh_key" {
  filename = "${aws_key_pair.pub_key.key_name}.pem"
  content  = tls_private_key.key_pair.private_key_pem
}


# creating ansible server
resource "aws_instance" "ansible-server" {
  ami                    = "ami-00983e8a26e4c9bd9"
  instance_type          = "t2.micro"
  subnet_id              = aws_default_subnet.default_az1.id
  vpc_security_group_ids = [aws_security_group.ansible-sg.id]
  key_name               = aws_key_pair.pub_key.key_name
  user_data              = local.ansible-user-data

  tags = {
    Name = "ansible-server"
  }
}

# creating docker container
resource "aws_instance" "docker-nginx-container" {
  ami                    = "ami-00983e8a26e4c9bd9"
  instance_type          = "t2.micro"
  subnet_id              = aws_default_subnet.default_az1.id
  vpc_security_group_ids = [aws_security_group.docker-nginx-sg.id]
  key_name               = aws_key_pair.pub_key.key_name

  tags = {
    Name = "docker-nginx-container"
  }
}
