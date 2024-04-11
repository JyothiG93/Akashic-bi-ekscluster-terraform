variable "region" {

}
variable "vpcname" {
}
variable "vpc-cidr" {
}
variable "enable" {
}
variable "publicsubnet-cidrs" {
  type = list(string)
}
variable "azs" {
  type = list(string)
}
variable "privatesubnet-cidrs" {
  type = list(string)
}
variable "clustername" {

}
variable "ami" {

}