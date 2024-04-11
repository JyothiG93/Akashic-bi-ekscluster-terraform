resource "aws_security_group" "node-sg" {
  name        = "node-sg"
  description = "Allow ssh inbound traffic"
  vpc_id      = aws_vpc.vpc.id


  ingress {
    description     = "ssh access to public"
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.bastion-sg.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group_rule" "node-ingress-self" {
  description              = "Allow node to communicate with each other"
  from_port                = 0
  protocol                 = "-1"
  security_group_id        = aws_security_group.node-sg.id
  source_security_group_id = aws_security_group.node-sg.id
  to_port                  = 65535
  type                     = "ingress"
}

resource "aws_security_group_rule" "demo-node-ingress-cluster" {
  description              = "Allow worker Kubelets and pods to receive communication from the cluster control plane"
  from_port                = 1025
  protocol                 = "tcp"
  security_group_id        = aws_security_group.node-sg.id
  source_security_group_id = aws_security_group.eks-sg.id
  to_port                  = 65535
  type                     = "ingress"
}



