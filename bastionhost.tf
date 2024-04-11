resource "aws_eip" "example_eip" {
  instance = aws_instance.bastion_host.id
  tags = {
    Name = "bastion-eip"
  }
}

resource "aws_instance" "bastion_host" {
  ami                         = var.ami
  instance_type               = "t2.small"
  subnet_id                   = aws_subnet.public-subnet.0.id
  vpc_security_group_ids      = [aws_security_group.bastion-sg.id]
  associate_public_ip_address = true
  key_name                    = "bastionkey"
  tags = {
    Name        = "Akashic-Bi-Bastionhost"
    Environment = "Dev"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "curl 'https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip' -o 'awscliv2.zip'", # Download AWS CLI v2 zip file
      "sudo apt install unzip -y",
      "unzip awscliv2.zip",
      "sudo ./aws/install",                                                                                                                                                         # Install AWS CLI v2
      "curl -LO https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl", # Download kubectl binary
      "chmod +x ./kubectl",                                                                                                                                                         # Make kubectl binary executable
      "sudo mv ./kubectl /usr/local/bin/kubectl"                                                                                                                                    # Move kubectl binary to a directory in your PATH

    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file("key.pem")
      host        = aws_instance.bastion_host.public_ip
    }
  }
}
