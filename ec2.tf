resource "aws_instance" "public_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type # Change to a different supported instance type
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = var.key_pair_name
  vpc_security_group_ids = [aws_security_group.public_instance_sg["public_ssh"].id, aws_security_group.public_instance_sg["public_http"].id]

  user_data = file("${path.module}/script.sh") #script.sh file contains the script to install and start nginx in instances


  tags = {
    Name = var.public_instance_name
  }
}

resource "aws_instance" "private_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type # Change to a different supported instance type
  subnet_id              = aws_subnet.private_subnet.id
  key_name               = var.key_pair_name
  vpc_security_group_ids = [aws_security_group.public_instance_sg["private_ssh"].id, aws_security_group.public_instance_sg["private_http"].id]

  tags = {
    Name = var.private_instance_name
  }

  // Additional configuration for private instance if needed
  
}

#security group creation configuration

resource "aws_security_group" "public_instance_sg" {
  for_each = var.security_group_tags

  name        = each.value["name"]
  description = each.value["description"]
  vpc_id      = aws_vpc.my_vpc.id

    dynamic "ingress" {
      for_each = each.key == "public_ssh" || each.key == "private_ssh" ? [var.ssh_cidr] : []
      content {
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = [ingress.value]
      }
    }

    dynamic "ingress" {
      for_each = each.key == "public_http" || each.key == "private_http" ? [var.http_cidr] : []
      content {
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = [ingress.value]
      }
    }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"          # Allow all protocols
    cidr_blocks = ["0.0.0.0/0"] # Allow traffic to any IP
  }



  tags = {
    Name = each.value["name"]
  }
}


output "public_instance_ip" {
  value = aws_instance.public_instance.public_ip
}

output "private_instance_ip" {
  value = aws_instance.private_instance.private_ip
}
