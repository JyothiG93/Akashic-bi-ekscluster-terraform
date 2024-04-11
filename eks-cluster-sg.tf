resource "aws_security_group" "eks-sg" {
  name        = "eks-cluster-sg"
  description = "Cluster communication with worker nodes"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port       = 1234
    to_port         = 1234
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion-sg.id]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "Akashic-Bi-eks"
    Environment = "Dev"
  }
}


resource "aws_security_group_rule" "cluster-ingress-node-https" {
  description              = "Allow pods to communicate with the cluster API Server"
  from_port                = 443
  protocol                 = "tcp"
  security_group_id        = aws_security_group.eks-sg.id
  source_security_group_id = aws_security_group.node-sg.id
  to_port                  = 443
  type                     = "ingress"
}
