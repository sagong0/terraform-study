provider "aws" {
  region     = "ap-northeast-2"
}


resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type.example1

  subnet_id = module.vpc.public_subnets[0]

  vpc_security_group_ids = [ aws_security_group.allow_ssh.id ] // sg-122334

  key_name = aws_key_pair.mykey.key_name

  # user_data = templatefile("${path.module}/templates/web.tpl", {
  #   "region" = var.aws_region
  #   "bucket_name" = var.bucket_name
  # })

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
  public_key = file(pathexpand("~/.ssh/mykey.pub"))
}