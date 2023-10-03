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
  user_data = templatefile("script.sh.tpl", {
    f_name = "Nikita",
    l_name = "Hramcenko",
    names  = ["Vasya", "Kolya", "Petya", "John", "Donald", "Masha"]
  })

  tags = {
    Name = "webserver-build-by-terraform"
  }
}

resource "aws_security_group" "my_webserver" {
  name = "Web Server Security Group"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
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
}
