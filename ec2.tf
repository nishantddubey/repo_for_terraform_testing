resource "aws_instance" "public_instance" {
  ami                    = var.ami_id
  instance_type          = var.instance_type # Change to a different supported instance type
  subnet_id              = aws_subnet.public_subnet.id
  key_name               = var.key_pair_name
  vpc_security_group_ids = [aws_security_group.public_instance_sg["public_ssh"].id, aws_security_group.public_instance_sg["public_http"].id]

  user_data = file("${path.module}/script.sh")


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

output "public_instance_ip" {
  value = aws_instance.public_instance.public_ip
}

output "private_instance_ip" {
  value = aws_instance.private_instance.private_ip
}
