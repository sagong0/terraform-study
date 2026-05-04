provider "aws" {
  region     = "ap-northeast-2"
}


resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type.example1

  tags = {
    Name="example"
  }
}
