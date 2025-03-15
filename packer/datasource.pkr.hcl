data "amazon-ami" "amazonlinux" {
  filters = {
    virtualization-type = "hvm"
    name                = "al2023-ami-*arm64"
    architecture        = "arm64"
    root-device-type    = "ebs"
  }
  owners      = ["amazon"]
  region      = lookup(var.regions, var.environment, "development")
  most_recent = true
}
