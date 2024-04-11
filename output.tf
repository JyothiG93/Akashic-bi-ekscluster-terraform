output "private_subnet_ids" {
  value = aws_subnet.private-subnet.*.id
}
output "vpc_id" {
  value = aws_vpc.vpc.id
}
output "bastion_host_public_ip" {
  value = aws_instance.bastion_host.public_ip
}
output "security_group_public" {
  value = aws_security_group.node-sg.id
}
output "endpoint" {
  value = aws_eks_cluster.eks.endpoint
}