terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~>3.0"
    }
  }
}

provider "aws" {
  region = "us-east-2"
}


resource "aws_vpc" "my-lab-vpc" {
  cidr_block = var.cidr_block[0]
  tags = {
    Name = "MyLab-VPC"
  }

}

resource "aws_subnet" "MyLab-subnet1" {
  vpc_id     = aws_vpc.my-lab-vpc.id
  cidr_block = var.cidr_block[1]
  tags = {
    "Name" = "MyLab-subnet1"
  }

}

resource "aws_internet_gateway" "MyLab-intgw" {
  vpc_id = aws_vpc.my-lab-vpc.id
  tags = {
    "Name" = "MyLab-intgw"
  }

}


resource "aws_security_group" "MyLab-SG" {
  name        = "mySG"
  description = "To allow inbound and outbound traffic to myLab"
  vpc_id      = aws_vpc.my-lab-vpc.id
  dynamic "ingress" {
    iterator = port
    for_each = var.ports
    content {
      cidr_blocks = ["0.0.0.0/0"]
      from_port   = port.value
      to_port     = port.value
      protocol    = "tcp"
    }
  }

  egress {
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
  }
  tags = {
    "Name" = "MyLabSG"
  }

}

resource "aws_route_table" "MyLab_Routetable" {
  vpc_id = aws_vpc.my-lab-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.MyLab-intgw.id
  }
  tags = {
    "Name" = "MyLab_Routetable"
  }
}

resource "aws_route_table_association" "MyLab_Association" {
  subnet_id      = aws_subnet.MyLab-subnet1.id
  route_table_id = aws_route_table.MyLab_Routetable.id
}

resource "aws_instance" "Jenkins" {
  
  ami = var.ami
  associate_public_ip_address = true
  instance_type = var.instance_type
  subnet_id = aws_subnet.MyLab-subnet1.id
  vpc_security_group_ids = [aws_security_group.MyLab-SG.id]
  key_name = "EC2"
  user_data = file("./infraSetup.sh")  
    tags = {
    "Name" = "Jenkins"
  }
  
}

resource "aws_instance" "k8s" {
  
  ami = var.ami
  associate_public_ip_address = true
  instance_type = var.instance_type
  subnet_id = aws_subnet.MyLab-subnet1.id
  vpc_security_group_ids = [aws_security_group.MyLab-SG.id]
  key_name = "EC2"  
    tags = {
    "Name" = "k8swn"
  }
  
}

resource "aws_instance" "Nexus" {

  ami = var.nexusami
  associate_public_ip_address = true
  instance_type = var.instance_type_for_nexus
  subnet_id = aws_subnet.MyLab-subnet1.id
  vpc_security_group_ids = [aws_security_group.MyLab-SG.id]
  key_name = "EC2"
  user_data = file("./InstallNexus.sh")
  
    tags = {
    "Name" = "nexus-server"
  }
  
}

resource "aws_instance" "Sonarqube" {

  ami = var.ami
  associate_public_ip_address = true
  instance_type = var.instance_type
  subnet_id = aws_subnet.MyLab-subnet1.id
  vpc_security_group_ids = [aws_security_group.MyLab-SG.id]
  key_name = "EC2"
  user_data = file("./installSQ.sh")
  
    tags = {
    "Name" = "sonarqube-server"
  }
  
}