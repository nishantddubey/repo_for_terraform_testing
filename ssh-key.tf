resource "tls_private_key" "my_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}


#it will save private key locally in our local system use this to access the intsances
resource "local_file" "private_key" {
  content         = tls_private_key.my_ssh_key.private_key_pem
  filename        = "${var.key_pair_name}.pem"  
  file_permission = 0700
}

#it will save public key locally in our local system 
resource "local_file" "public_key" {
  content  = tls_private_key.my_ssh_key.public_key_openssh
  filename = "${var.key_pair_name}.pub"
}

#it will create keypair in aws 
resource "aws_key_pair" "my_keypair" {
  key_name   = var.key_pair_name # Name of the key pair
  public_key = local_file.public_key.content
}
