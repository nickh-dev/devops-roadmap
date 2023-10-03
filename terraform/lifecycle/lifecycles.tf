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
    prevent_destroy = true
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
    ignore_changes = ["ami", "instance_type"]
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

