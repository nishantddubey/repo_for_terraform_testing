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

  # dynamic "ingress" {
  #   for_each = var.ports
  #   content {
  #     from_port   = ingress.value
  #     to_port     = ingress.value
  #     protocol    = "tcp"
  #     cidr_blocks = [ingress.value] # Allow traffic from any IP
  #   }
  # }
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
