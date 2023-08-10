terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "us-west-2"
}

resource "aws_instance" "app_server" {
  ami           = "ami-0507f77897697c4ba"
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleAppServerInstance"
  }

  key_name      = "myKey"         # Replace with the name of your key pair

  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]  # Replace with the ID of your security group
   
  user_data     =  "${file("./install_ansible.sh")}"
  subnet_id = aws_subnet.public-subnet.id# Replace with the ID of your subnet
}