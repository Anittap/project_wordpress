variable "regions" {
  type        = map(string)
  description = "AWS region maps"
  default = {
    "production" : "ap-south-1"
    "development" : "us-west-2"
  }
}
variable "environment" {
  type        = string
  description = "Project environment"
  default     = "development"
}
variable "project_name" {
  type        = string
  description = "Project name"
  default     = "redux-project"
}
locals {
  ami_name = "${var.project_name}-${var.environment}-${formatdate("DD-MMM-YYYY-hh-mm", timestamp())}"
}
variable "instance_type" {
  type        = map(string)
  description = "instance type"
  default = {
    development : "t4g.small"
    production : "t4g.medium"
  }
}
locals {
  source_ami_id   = data.amazon-ami.amazonlinux.id
  source_ami_name = data.amazon-ami.amazonlinux.name
}
