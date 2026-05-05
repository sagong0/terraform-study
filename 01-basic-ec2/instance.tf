provider "aws" {
  region     = "ap-northeast-2"
}


resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type.example1

  subnet_id = module.vpc.public_subnets[0]

  vpc_security_group_ids = [ aws_security_group.allow_ssh.id ] // sg-122334

  key_name = aws_key_pair.mykey.key_name

  tags = {
    Name="example"
  }
}



// 보안그룹 (ssh 허용)
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic and all outbound traffic"
  vpc_id      = module.vpc.vpc_id

   ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

   egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

resource "aws_key_pair" "mykey" {
  key_name   = "demo-mykey"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDd584oaBeEXHjozQih3Zln7xwIwgmsaMcHOmDYYeDIjMn4R1ITK6Gc3ROMc5KWPRemLjBDvOLGdwmAP//ihweL/hvHAt5X3P2h2Zp1FOhhLFDjEXv6LHSKiMxxtBdHM9aHe/U1rJ4uu9JM2EGpbVez4VtSRCkkHmIqf3XvHG9np5dQkOgxkbdFacb/+b6W6WxfdWfGYsZc/ho4cLQV+vrD87lZrcb+j7Ix8C1ZraCR7f8fC1oJ4sonTuEfzMlFbqMQfqhQXvRb92Jgpy+zIT0298wd4GL1eoD8yCDyNb2oeG/F/kn0vYkCyuQy4tLtHtKmCckNbhK9TBM44e50ptffV2x2GQaWg1fSe6IDCtUEv2C35qUYnlwrn6XR9GibVB1R2R5NYrqJeojzHMWt55GTsTv5lccGAcy6g9hSeO06tu5/LNvZ9L25OCy4f6n6Oi3kUthtQcAbjtfwHwx4DyDMlex4gB9dO/yZ6nO6sBi6VmGmQr7b4TZEGBiLMZ6d7Jp6HSbgFlO3eNRAOGB+nWwu2j4d5PxDC8TFAPvoUGPcjPn7xtZebm1e9z74sTGW4BzYLMOapESO9WiGJ/liq4y3RMfkQwDDA8rJoJaPX0kHYuJF1PO7yD6jEfCtGbTuUM1rBixsMkRYsyxvOC73803KFV/q9XEqZhCFqzMSVrarlw== lee@DESKTOP-I37HGI8"
}