resource "aws_security_group" "bastion-sg" {
  name        = "bastionhost-sg"
  description = "Allow ssh inbound traffic"
  vpc_id      = aws_vpc.vpc.id


  ingress {
    description = "ssh access to public"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["192.168.31.97/32"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}