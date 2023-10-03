provider "aws" {}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu*"]
  }
}

resource "aws_instance" "my_webserver" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [aws_security_group.my_webserver.id]

  tags = {
    Name = "webserver-build-by-terraform"
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_eip" "my_static_ip" {
  instance = aws_instance.my_webserver.id
}

resource "aws_security_group" "my_webserver" {
  name = "Dynamic Security Group"

  dynamic "ingress" {
    for_each = ["80", "22", "8080", "443"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Dynamic Security Group"
  }
}

output "webserver_instance_id" {
  value = aws_instance.my_webserver.id
}

output "webserver_public_ip_address" {
  value = aws_eip.my_static_ip.public_ip
}

output "webserver_sg_id" {
  value = aws_security_group.my_webserver.id
}

output "webserver_sg_arn" {
  value = aws_security_group.my_webserver.arn
}

