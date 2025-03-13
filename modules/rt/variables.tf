variable "project_name" {
  type        = string
  description = "project namliste"
}
variable "project_environment" {
  type        = string
  description = "project environment"
}
variable "vpc_id" {
  type        = string
  description = "vpc id"
}
variable "type" {
  type        = string
  description = "connection type"
}
variable "subnet_id" {
  type        = list(string)
  description = "subnet id"
}
variable "vpc_peering_connection_id" {
  type        = string
  description = "vpc peering connection id"
}
variable "peer_cidr_block" {
  type        = string
  description = "peer cidr block"
}
variable "internet_gateway_id" {
  type        = string
  description = "igw id"
}
variable "enable_internet" {
  description = "Enable public internet access"
  type        = bool
}
variable "enable_peering" {
  description = "Enable VPC peering route"
  type        = bool
}
